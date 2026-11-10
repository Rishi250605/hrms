import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hrms_api/hrms_api.dart';

import '../../../app/l10n/app_localizations.dart';
import '../../../core/errors/api_failure.dart';
import '../../../core/labels.dart';
import '../../../core/widgets/async_view.dart';
import '../../../core/widgets/status_chip.dart';
import '../../employees/presentation/providers/employees_providers.dart';
import '../../home/presentation/providers/dashboard_provider.dart';
import '../data/roster_repository.dart';
import 'providers/roster_providers.dart';

/// Duty detail: crew (remove), assign a driver/conductor/helper from spare suggestions, cancel the duty.
class DutySheet extends ConsumerWidget {
  const DutySheet({super.key, required this.dutyId, required this.depotId, required this.date});

  final String dutyId;
  final String depotId;
  final String date;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final day = ref.watch(rosterDayProvider(depotId, date));
    final duty = day.value?.duties.where((d) => d.id == dutyId).firstOrNull;
    if (duty == null) return const SizedBox(height: 200, child: Center(child: CircularProgressIndicator()));
    final repo = ref.read(rosterRepositoryProvider);
    final open = duty.status == DutyStatus.PLANNED || duty.status == DutyStatus.CONFIRMED;

    void refresh() {
      ref.invalidate(rosterDayProvider(depotId, date));
      ref.invalidate(dashboardProvider);
    }

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text('${duty.startTime}–${duty.endTime} · ${duty.route?.name ?? duty.template?.name ?? l10n.duty}', style: Theme.of(context).textTheme.titleLarge),
          Text(duty.vehicle?.regNo ?? l10n.noVehicle),
          const SizedBox(height: 12),
          Text(l10n.crew, style: Theme.of(context).textTheme.titleMedium),
          if (duty.assignments.isEmpty) ListTile(title: Text(l10n.noCrew)),
          for (final a in duty.assignments)
            ListTile(
              key: Key('crew.${a.employee.id}'),
              title: Text(a.employee.fullName),
              subtitle: Text([l10n.assignmentRole(a.role), ...a.warnings.map((w) => w.message)].join('\n')),
              leading: a.warnings.isEmpty ? const Icon(Icons.person_outline) : Icon(Icons.warning_amber, color: Colors.orange.shade800),
              trailing: open
                  ? IconButton(
                      tooltip: l10n.remove,
                      icon: const Icon(Icons.remove_circle_outline),
                      onPressed: () async {
                        try {
                          await repo.unassign(a.id);
                          refresh();
                        } catch (err) {
                          if (context.mounted) showFailure(context, err);
                        }
                      },
                    )
                  : null,
            ),
          if (open) ...[
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                for (final role in AssignmentRole.values)
                  OutlinedButton.icon(
                    key: Key('duty.assign.${role.value}'),
                    onPressed: () => showModalBottomSheet<void>(
                      context: context,
                      isScrollControlled: true,
                      useSafeArea: true,
                      builder: (_) => AssignSheet(duty: duty, depotId: depotId, date: date, role: role),
                    ).then((_) => refresh()),
                    icon: const Icon(Icons.person_add_alt),
                    label: Text(l10n.assignRole(l10n.assignmentRole(role))),
                  ),
              ],
            ),
            const SizedBox(height: 16),
            TextButton.icon(
              style: TextButton.styleFrom(foregroundColor: Theme.of(context).colorScheme.error),
              onPressed: () async {
                try {
                  await repo.updateDuty(duty.id, DutyUpdateBody(status: DutyStatus.CANCELLED));
                  refresh();
                  if (context.mounted) Navigator.pop(context);
                } catch (err) {
                  if (context.mounted) showFailure(context, err);
                }
              },
              icon: const Icon(Icons.cancel_outlined),
              label: Text(l10n.cancelDuty),
            ),
          ],
        ],
      ),
    );
  }
}

/// Picks someone for a duty role. Shows the API's spare suggestions first, and any employee of the depot
/// via search. A 409 DOCUMENT_INVALID shows which documents fail and offers the suggested spares.
class AssignSheet extends ConsumerStatefulWidget {
  const AssignSheet({super.key, required this.duty, required this.depotId, required this.date, required this.role});

  final DutyItem duty;
  final String depotId;
  final String date;
  final AssignmentRole role;

  @override
  ConsumerState<AssignSheet> createState() => _AssignSheetState();
}

class _AssignSheetState extends ConsumerState<AssignSheet> {
  bool _busy = false;
  _Blocked? _blocked;

  Future<void> _assign(String employeeId, String name, {bool isSpare = false}) async {
    final l10n = AppLocalizations.of(context);
    setState(() => _busy = true);
    try {
      final result = await ref.read(rosterRepositoryProvider).assign(widget.duty.id, employeeId, widget.role, isSpare: isSpare);
      if (!mounted) return;
      Navigator.pop(context);
      if (result.warnings.isNotEmpty) {
        await showDialog<void>(
          context: context,
          builder: (_) => AlertDialog(
            icon: Icon(Icons.warning_amber, color: Colors.orange.shade800),
            title: Text(l10n.assignedWithWarnings(name)),
            content: Text(result.warnings.map((w) => '• ${w.message}').join('\n')),
            actions: [TextButton(onPressed: () => Navigator.pop(context), child: Text(l10n.ok))],
          ),
        );
      }
    } on ApiFailure catch (f) {
      if (!mounted) return;
      setState(() => _busy = false);
      if (f.code == 'DOCUMENT_INVALID' && f.details is Map) {
        setState(() => _blocked = _Blocked.fromDetails(name, f.details! as Map));
      } else {
        showFailure(context, f);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final spares = ref.watch(sparesProvider(widget.depotId, widget.date, widget.duty.id, widget.role));
    final blocked = _blocked;
    return SizedBox(
      height: MediaQuery.sizeOf(context).height * 0.8,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(l10n.assignRole(l10n.assignmentRole(widget.role)), style: Theme.of(context).textTheme.titleLarge),
          ),
          if (_busy) const LinearProgressIndicator(),
          if (blocked != null)
            Card(
              key: const Key('assign.blocked'),
              margin: const EdgeInsets.symmetric(horizontal: 16),
              color: Theme.of(context).colorScheme.errorContainer,
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(l10n.documentsBlock(blocked.name), style: Theme.of(context).textTheme.titleSmall),
                    const SizedBox(height: 6),
                    Wrap(
                      spacing: 6,
                      runSpacing: 6,
                      children: [
                        for (final f in blocked.failing) StatusChip(label: '${l10n.documentType(f.type)}: ${l10n.complianceState(f.state)}', tone: Tone.bad),
                      ],
                    ),
                    if (blocked.spares.isNotEmpty) ...[const SizedBox(height: 8), Text(l10n.trySpares)],
                  ],
                ),
              ),
            ),
          Expanded(
            child: ListView(
              children: [
                if (blocked != null && blocked.spares.isNotEmpty)
                  for (final s in blocked.spares) _spareTile(context, s, key: Key('blocked.spare.${s.employee.id}')),
                ListTile(title: Text(l10n.suggestedSpares, style: Theme.of(context).textTheme.titleSmall)),
                AsyncView(
                  value: spares,
                  onRetry: () => ref.invalidate(sparesProvider(widget.depotId, widget.date, widget.duty.id, widget.role)),
                  data: (items) => items.isEmpty ? ListTile(title: Text(l10n.noSpares)) : Column(children: [for (final s in items) _spareTile(context, s)]),
                ),
                const Divider(),
                ListTile(title: Text(l10n.allEmployees, style: Theme.of(context).textTheme.titleSmall)),
                _AllEmployees(onPick: (id, name) => _assign(id, name)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _spareTile(BuildContext context, SpareItem s, {Key? key}) {
    final l10n = AppLocalizations.of(context);
    return ListTile(
      key: key ?? Key('spare.${s.employee.id}'),
      enabled: !_busy,
      leading: CircleAvatar(child: Text(s.employee.fullName[0])),
      title: Text(s.employee.fullName),
      subtitle: Text(
        [s.employee.empCode, l10n.hoursLast7Days((s.dutyMinutesLast7Days / 60).toStringAsFixed(1)), ...s.warnings.map((w) => w.message)].join(' · '),
      ),
      trailing: s.warnings.isEmpty ? const Icon(Icons.add) : Icon(Icons.warning_amber, color: Colors.orange.shade800),
      onTap: () => _assign(s.employee.id, s.employee.fullName, isSpare: true),
    );
  }
}

class _Blocked {
  const _Blocked({required this.name, required this.failing, required this.spares});

  final String name;
  final List<ComplianceItem> failing;
  final List<SpareItem> spares;

  factory _Blocked.fromDetails(String name, Map<dynamic, dynamic> details) {
    List<Map<String, dynamic>> maps(Object? v) => v is List
        ? [
            for (final x in v)
              if (x is Map) Map<String, dynamic>.from(x),
          ]
        : const [];
    return _Blocked(
      name: name,
      failing: [for (final m in maps(details['failing'])) ComplianceItem.fromJson(m)],
      spares: [for (final m in maps(details['spares'])) SpareItem.fromJson(m)],
    );
  }
}

/// Any employee of the depot (the API decides whether they may be assigned).
class _AllEmployees extends ConsumerWidget {
  const _AllEmployees({required this.onPick});

  final void Function(String id, String name) onPick;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final list = ref.watch(employeeListProvider);
    final l10n = AppLocalizations.of(context);
    return AsyncView(
      value: list,
      data: (s) => Column(
        children: [
          for (final e in s.items)
            ListTile(
              key: Key('assign.employee.${e.id}'),
              title: Text(e.fullName),
              subtitle: Text('${e.empCode} · ${l10n.category(e.category)}'),
              trailing: StatusChip(label: l10n.compliance(e.compliance), tone: complianceTone(e.compliance)),
              onTap: () => onPick(e.id, e.fullName),
            ),
        ],
      ),
    );
  }
}
