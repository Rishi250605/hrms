import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hrms_api/hrms_api.dart';

import '../../../app/l10n/app_localizations.dart';
import '../../../core/format.dart';
import '../../../core/labels.dart';
import '../../../core/session.dart';
import '../../../core/widgets/async_view.dart';
import '../../../core/widgets/depot_selector.dart';
import '../../../core/widgets/status_chip.dart';
import '../../home/presentation/providers/dashboard_provider.dart';
import '../data/roster_repository.dart';
import 'add_duty_sheet.dart';
import 'duty_sheet.dart';
import 'providers/roster_providers.dart';

/// Roster day view per depot (CLAUDE.md §9): duties with crew, vehicle and route; add duties,
/// assign crew (with document blocking and spare suggestions) and copy the previous day.
class RosterScreen extends ConsumerWidget {
  const RosterScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final depotId = ref.watch(selectedDepotProvider);
    final date = ref.watch(rosterDateProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.navRoster),
        actions: [
          const DepotSelector(),
          if (depotId != null)
            PopupMenuButton<String>(
              key: const Key('roster.menu'),
              onSelected: (v) => _copyPrevious(context, ref, depotId, date),
              itemBuilder: (_) => [PopupMenuItem(value: 'copy', key: const Key('roster.copy'), child: Text(l10n.copyPreviousDay))],
            ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(48),
          child: DateStepper(date: parseIsoDate(date), label: formatDate(date), onChanged: (d) => ref.read(rosterDateProvider.notifier).set(isoDate(d))),
        ),
      ),
      floatingActionButton: depotId == null
          ? null
          : FloatingActionButton.extended(
              key: const Key('roster.addDuty'),
              onPressed: () async {
                final created = await showModalBottomSheet<bool>(
                  context: context,
                  isScrollControlled: true,
                  useSafeArea: true,
                  builder: (_) => AddDutySheet(depotId: depotId, date: date),
                );
                if (created == true) ref.invalidate(rosterDayProvider(depotId, date));
              },
              icon: const Icon(Icons.add),
              label: Text(l10n.addDuty),
            ),
      body: depotId == null ? EmptyState(icon: Icons.warehouse_outlined, message: l10n.scopeNone) : _RosterBody(depotId: depotId, date: date),
    );
  }

  Future<void> _copyPrevious(BuildContext context, WidgetRef ref, String depotId, String date) async {
    final l10n = AppLocalizations.of(context);
    final from = addDaysIso(date, -1);
    try {
      final result = await ref.read(rosterRepositoryProvider).copy(depotId, from, date);
      ref.invalidate(rosterDayProvider(depotId, date));
      ref.invalidate(dashboardProvider);
      if (!context.mounted) return;
      await showDialog<void>(
        context: context,
        builder: (_) => AlertDialog(
          title: Text(l10n.copyDone),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(l10n.copySummary(result.createdDuties, result.copiedAssignments, result.existingDuties)),
              if (result.skipped.isNotEmpty) ...[
                const SizedBox(height: 12),
                Text(l10n.copySkipped, style: Theme.of(context).textTheme.titleSmall),
                for (final s in result.skipped) Text('• ${s.employeeName}: ${humanize(s.reason)}'),
              ],
            ],
          ),
          actions: [TextButton(onPressed: () => Navigator.pop(context), child: Text(l10n.ok))],
        ),
      );
    } catch (err) {
      if (context.mounted) showFailure(context, err);
    }
  }
}

class _RosterBody extends ConsumerWidget {
  const _RosterBody({required this.depotId, required this.date});

  final String depotId;
  final String date;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final day = ref.watch(rosterDayProvider(depotId, date));
    return RefreshIndicator(
      onRefresh: () => ref.refreshFuture(rosterDayProvider(depotId, date).future),
      child: AsyncView(
        value: day,
        onRetry: () => ref.invalidate(rosterDayProvider(depotId, date)),
        data: (r) => ListView(
          key: const Key('roster.list'),
          padding: const EdgeInsets.fromLTRB(12, 8, 12, 96),
          children: [
            Wrap(
              spacing: 8,
              children: [
                StatusChip(label: l10n.dutiesCount(r.summary.duties)),
                StatusChip(label: l10n.filledCount(r.summary.filled), tone: Tone.good),
                StatusChip(label: l10n.unfilledCount(r.summary.unfilled), tone: r.summary.unfilled > 0 ? Tone.bad : Tone.neutral),
              ],
            ),
            const SizedBox(height: 8),
            if (r.duties.isEmpty) EmptyState(icon: Icons.event_note_outlined, message: l10n.noDuties),
            for (final d in r.duties) DutyCard(duty: d, depotId: depotId, date: date),
          ],
        ),
      ),
    );
  }
}

class DutyCard extends ConsumerWidget {
  const DutyCard({super.key, required this.duty, required this.depotId, required this.date});

  final DutyItem duty;
  final String depotId;
  final String date;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final d = duty;
    final cancelled = d.status == DutyStatus.CANCELLED;
    return Card(
      key: Key('duty.${d.id}'),
      margin: const EdgeInsets.only(bottom: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: !d.filled && !cancelled ? theme.colorScheme.error : theme.colorScheme.outlineVariant),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () async {
          await showModalBottomSheet<void>(
            context: context,
            isScrollControlled: true,
            useSafeArea: true,
            builder: (_) => DutySheet(dutyId: d.id, depotId: depotId, date: date),
          );
          ref.invalidate(rosterDayProvider(depotId, date));
        },
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    '${d.startTime}–${d.endTime}${d.crossesMidnight ? ' (+1)' : ''}',
                    style: theme.textTheme.titleMedium?.copyWith(decoration: cancelled ? TextDecoration.lineThrough : null),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(d.route?.code ?? d.template?.name ?? '', style: theme.textTheme.bodyMedium, overflow: TextOverflow.ellipsis),
                  ),
                  if (cancelled)
                    StatusChip(label: l10n.cancelled)
                  else if (!d.filled)
                    StatusChip(label: l10n.unfilled, tone: Tone.bad, icon: Icons.person_off_outlined),
                ],
              ),
              const SizedBox(height: 4),
              Row(
                children: [
                  Icon(Icons.directions_bus_outlined, size: 16, color: theme.colorScheme.outline),
                  const SizedBox(width: 4),
                  Text(d.vehicle?.regNo ?? l10n.noVehicle, style: theme.textTheme.bodySmall),
                ],
              ),
              if (d.assignments.isNotEmpty) ...[
                const SizedBox(height: 8),
                Wrap(
                  spacing: 6,
                  runSpacing: 6,
                  children: [
                    for (final a in d.assignments)
                      Chip(
                        visualDensity: VisualDensity.compact,
                        avatar: a.warnings.isEmpty ? null : Icon(Icons.warning_amber, size: 16, color: Colors.orange.shade800),
                        label: Text('${a.employee.fullName} · ${l10n.assignmentRole(a.role)}'),
                      ),
                  ],
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
