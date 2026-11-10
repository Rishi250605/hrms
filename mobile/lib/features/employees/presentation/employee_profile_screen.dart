import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:hrms_api/hrms_api.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../app/l10n/app_localizations.dart';
import '../../../app/router.dart';
import '../../../core/format.dart';
import '../../../core/labels.dart';
import '../../../core/session.dart';
import '../../../core/widgets/async_view.dart';
import '../../../core/widgets/date_field.dart';
import '../../../core/widgets/status_chip.dart';
import '../../auth/domain/current_user.dart';
import '../data/employees_repository.dart';
import 'document_capture_sheet.dart';
import 'providers/employees_providers.dart';

class EmployeeProfileScreen extends StatelessWidget {
  const EmployeeProfileScreen({super.key, required this.employeeId});

  final String employeeId;

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: Text(AppLocalizations.of(context).employeeProfile)),
    body: EmployeeProfileView(employeeId: employeeId),
  );
}

/// Profile body: compliance, documents (with capture), job history and HR actions.
class EmployeeProfileView extends ConsumerWidget {
  const EmployeeProfileView({super.key, required this.employeeId});

  final String employeeId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final detail = ref.watch(employeeDetailProvider(employeeId));
    return AsyncView(
      value: detail,
      onRetry: () => ref.invalidate(employeeDetailProvider(employeeId)),
      data: (e) => RefreshIndicator(
        onRefresh: () async {
          ref.invalidate(employeeDocumentsProvider(employeeId));
          await ref.refreshFuture(employeeDetailProvider(employeeId).future);
        },
        child: _Profile(employee: e),
      ),
    );
  }
}

class _Profile extends ConsumerWidget {
  const _Profile({required this.employee});

  final EmployeeDetail employee;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final user = ref.watch(currentUserProvider);
    final e = employee;
    final docs = ref.watch(employeeDocumentsProvider(e.id));
    final isHr = user?.role == UserRole.hr;
    final canRaise = user?.role == UserRole.operationalManager || user?.role == UserRole.regionalManager || isHr;
    final active = e.status != EmployeeStatus.EXITED;

    Future<void> capture() async {
      final saved = await showModalBottomSheet<bool>(
        context: context,
        isScrollControlled: true,
        useSafeArea: true,
        builder: (_) => DocumentCaptureSheet(employeeId: e.id),
      );
      if (saved == true) {
        ref.invalidate(employeeDocumentsProvider(e.id));
        ref.invalidate(employeeDetailProvider(e.id));
        if (context.mounted) showMessage(context, l10n.documentSaved);
      }
    }

    return ListView(
      key: const Key('employee.profile'),
      padding: const EdgeInsets.all(16),
      children: [
        Row(
          children: [
            CircleAvatar(radius: 28, child: Text(e.fullName.isEmpty ? '?' : e.fullName[0], style: theme.textTheme.titleLarge)),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(e.fullName, style: theme.textTheme.titleLarge),
                  Text([e.empCode, l10n.category(e.category), if (e.designation != null) e.designation!].join(' · ')),
                  if (e.depot != null) Text('${e.depot!.name} (${e.depot!.code})', style: theme.textTheme.bodySmall),
                ],
              ),
            ),
            StatusChip(label: l10n.employeeStatus(e.status), tone: e.status == EmployeeStatus.ACTIVE ? Tone.good : Tone.warn),
          ],
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            if (active)
              FilledButton.tonalIcon(
                key: const Key('profile.addDocument'),
                onPressed: capture,
                icon: const Icon(Icons.photo_camera_outlined),
                label: Text(l10n.addDocument),
              ),
            if (active && canRaise)
              OutlinedButton.icon(
                key: const Key('profile.raiseLeave'),
                onPressed: () => context.push('${Routes.newLeave}?employeeId=${e.id}'),
                icon: const Icon(Icons.event_busy_outlined),
                label: Text(l10n.raiseLeave),
              ),
            OutlinedButton.icon(
              onPressed: () => launchUrl(Uri(scheme: 'tel', path: e.phone)),
              icon: const Icon(Icons.call_outlined),
              label: Text(e.phone),
            ),
            if (isHr && active) _HrActions(employee: e),
          ],
        ),
        const SizedBox(height: 16),
        _Section(
          title: l10n.complianceTitle,
          trailing: StatusChip(label: l10n.compliance(e.compliance.overall), tone: complianceTone(e.compliance.overall)),
          children: [
            if (e.compliance.items.isEmpty) ListTile(title: Text(l10n.noRequiredDocuments)),
            for (final item in e.compliance.items)
              ListTile(
                dense: true,
                leading: Icon(
                  item.state == ComplianceState.VALID ? Icons.check_circle_outline : Icons.error_outline,
                  color: item.state == ComplianceState.VALID ? Colors.green : theme.colorScheme.error,
                ),
                title: Text(l10n.documentType(item.type)),
                subtitle: item.expiryDate != null ? Text(l10n.validUntil(formatDate(item.expiryDate!))) : null,
                trailing: StatusChip(label: l10n.complianceState(item.state), tone: complianceStateTone(item.state)),
              ),
            if (!e.compliance.rosterable)
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
                child: Text(l10n.notRosterable, style: TextStyle(color: theme.colorScheme.error)),
              ),
          ],
        ),
        _Section(
          title: l10n.documentsTitle,
          children: [
            AsyncView(
              value: docs,
              onRetry: () => ref.invalidate(employeeDocumentsProvider(e.id)),
              data: (items) => items.isEmpty ? ListTile(title: Text(l10n.noDocuments)) : Column(children: [for (final d in items) DocumentTile(document: d)]),
            ),
          ],
        ),
        _Section(
          title: l10n.jobHistory,
          children: [
            for (final j in e.jobs)
              ListTile(
                dense: true,
                title: Text('${j.designation} · ${j.depot.code}${j.grade != null ? ' · ${j.grade}' : ''}'),
                subtitle: Text(
                  [
                    j.effectiveTo == null
                        ? l10n.jobFromOpen(formatDate(j.effectiveFrom))
                        : l10n.jobRange(formatDate(j.effectiveFrom), formatDate(addDaysIso(j.effectiveTo!, -1))),
                    if (j.reportingTo != null) l10n.reportsTo(j.reportingTo!.name),
                    if (j.changeReason != null) j.changeReason!,
                  ].join('\n'),
                ),
              ),
          ],
        ),
        _Section(
          title: l10n.personalDetails,
          children: [
            _kv(l10n.joiningDate, formatDate(e.joiningDate)),
            if (e.exitDate != null) _kv(l10n.exitDate, formatDate(e.exitDate!)),
            _kv(l10n.employmentTypeLabel, l10n.employmentType(e.employmentType)),
            if (e.contractorName != null) _kv(l10n.contractor, e.contractorName!),
            if (e.uan != null) _kv('UAN', e.uan!),
            if (e.esicNo != null) _kv('ESIC', e.esicNo!),
            if (e.aadhaarLast4 != null) _kv(l10n.aadhaarLast4, 'XXXX XXXX ${e.aadhaarLast4}'),
            if (e.panMasked != null) _kv('PAN', e.panMasked!),
          ],
        ),
      ],
    );
  }

  Widget _kv(String k, String v) => ListTile(dense: true, title: Text(k), trailing: Text(v));
}

class _Section extends StatelessWidget {
  const _Section({required this.title, required this.children, this.trailing});

  final String title;
  final List<Widget> children;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.only(bottom: 12),
    child: Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 4),
            child: Row(
              children: [
                Expanded(child: Text(title, style: Theme.of(context).textTheme.titleMedium)),
                ?trailing,
              ],
            ),
          ),
          ...children,
        ],
      ),
    ),
  );
}

/// One document row with status, expiry and a "view" button (signed URL, ≤ 10 min).
class DocumentTile extends ConsumerWidget {
  const DocumentTile({super.key, required this.document});

  final DocumentItem document;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final d = document;
    final lines = [
      d.number,
      if (d.expiryDate != null) l10n.validUntil(formatDate(d.expiryDate!)),
      if (d.status == DocumentStatus.REJECTED && d.rejectionReason != null) l10n.rejectedBecause(d.rejectionReason!),
    ];
    return ListTile(
      key: Key('document.${d.id}'),
      title: Text(l10n.documentType(d.type)),
      subtitle: Text(lines.join('\n')),
      isThreeLine: lines.length > 2,
      leading: d.hasFile
          ? IconButton(
              tooltip: l10n.viewFile,
              icon: const Icon(Icons.image_outlined),
              onPressed: () async {
                try {
                  final url = await ref.read(employeesRepositoryProvider).fileUrl(d.id);
                  await launchUrl(Uri.parse(url.url), mode: LaunchMode.externalApplication);
                } catch (err) {
                  if (context.mounted) showFailure(context, err);
                }
              },
            )
          : const Icon(Icons.description_outlined),
      trailing: StatusChip(label: l10n.documentStatus(d.status), tone: documentStatusTone(d.status)),
    );
  }
}

/// HR: transfer / change job (effective-dated) and record an exit.
class _HrActions extends ConsumerWidget {
  const _HrActions({required this.employee});

  final EmployeeDetail employee;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    return PopupMenuButton<String>(
      key: const Key('profile.hrActions'),
      tooltip: l10n.moreActions,
      onSelected: (action) async {
        final repo = ref.read(employeesRepositoryProvider);
        try {
          if (action == 'job') {
            final body = await showDialog<JobChangeBody>(
              context: context,
              builder: (_) => _JobChangeDialog(employee: employee),
            );
            if (body == null) return;
            await repo.changeJob(employee.id, body);
          } else {
            final body = await showDialog<ExitBody>(context: context, builder: (_) => const _ExitDialog());
            if (body == null) return;
            await repo.exit(employee.id, body);
          }
          ref.invalidate(employeeDetailProvider(employee.id));
          ref.invalidate(employeeListProvider);
          if (context.mounted) showMessage(context, l10n.saved);
        } catch (err) {
          if (context.mounted) showFailure(context, err);
        }
      },
      itemBuilder: (_) => [PopupMenuItem(value: 'job', child: Text(l10n.changeJob)), PopupMenuItem(value: 'exit', child: Text(l10n.recordExit))],
      child: Chip(avatar: const Icon(Icons.more_horiz, size: 18), label: Text(l10n.moreActions)),
    );
  }
}

class _JobChangeDialog extends ConsumerStatefulWidget {
  const _JobChangeDialog({required this.employee});

  final EmployeeDetail employee;

  @override
  ConsumerState<_JobChangeDialog> createState() => _JobChangeDialogState();
}

class _JobChangeDialogState extends ConsumerState<_JobChangeDialog> {
  final _form = GlobalKey<FormState>();
  late String _from = addDaysIso(todayIso(), 1);
  String? _depotId;
  late final _designation = TextEditingController(text: widget.employee.designation ?? '');
  final _reason = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final depots = ref.watch(onboardingDepotsProvider).value ?? const [];
    return AlertDialog(
      title: Text(l10n.changeJob),
      content: Form(
        key: _form,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              DateField(label: l10n.effectiveFrom, value: _from, onChanged: (v) => setState(() => _from = v)),
              const SizedBox(height: 12),
              DropdownButtonFormField<String>(
                isExpanded: true,
                initialValue: _depotId,
                decoration: InputDecoration(labelText: l10n.depotUnchanged),
                items: [for (final d in depots) DropdownMenuItem(value: d.id, child: Text('${d.name} (${d.code})'))],
                onChanged: (v) => setState(() => _depotId = v),
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _designation,
                decoration: InputDecoration(labelText: l10n.designation),
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _reason,
                decoration: InputDecoration(labelText: l10n.reason),
                validator: (v) => (v ?? '').trim().length < 2 ? l10n.required : null,
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(onPressed: () => Navigator.pop(context), child: Text(l10n.cancel)),
        FilledButton(
          onPressed: () {
            if (!_form.currentState!.validate()) return;
            final designation = _designation.text.trim();
            Navigator.pop(
              context,
              JobChangeBody(
                effectiveFrom: _from,
                depotId: _depotId,
                designation: designation.isEmpty || designation == widget.employee.designation ? null : designation,
                reason: _reason.text.trim(),
              ),
            );
          },
          child: Text(l10n.save),
        ),
      ],
    );
  }
}

class _ExitDialog extends StatefulWidget {
  const _ExitDialog();

  @override
  State<_ExitDialog> createState() => _ExitDialogState();
}

class _ExitDialogState extends State<_ExitDialog> {
  String _date = todayIso();
  final _reason = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return AlertDialog(
      title: Text(l10n.recordExit),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          DateField(label: l10n.lastWorkingDay, value: _date, onChanged: (v) => setState(() => _date = v)),
          const SizedBox(height: 12),
          TextField(
            controller: _reason,
            decoration: InputDecoration(labelText: l10n.reason),
            onChanged: (_) => setState(() {}),
          ),
        ],
      ),
      actions: [
        TextButton(onPressed: () => Navigator.pop(context), child: Text(l10n.cancel)),
        FilledButton(
          onPressed: _reason.text.trim().length < 2 ? null : () => Navigator.pop(context, ExitBody(exitDate: _date, reason: _reason.text.trim())),
          child: Text(l10n.save),
        ),
      ],
    );
  }
}
