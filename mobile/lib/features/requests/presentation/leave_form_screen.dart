import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hrms_api/hrms_api.dart';

import '../../../app/l10n/app_localizations.dart';
import '../../../core/format.dart';
import '../../../core/session.dart';
import '../../../core/widgets/async_view.dart';
import '../../../core/widgets/date_field.dart';
import '../../employees/data/employees_repository.dart';
import '../../employees/presentation/employee_picker.dart';
import '../../home/presentation/providers/dashboard_provider.dart';
import '../data/requests_repository.dart';
import 'providers/requests_providers.dart';

/// New leave or OD request (§5). Managers raise for themselves; an RM can also raise for a driver /
/// loadman reporting to them and approve it in the same step.
class LeaveFormScreen extends ConsumerStatefulWidget {
  const LeaveFormScreen({super.key, this.employeeId, this.employeeName});

  final String? employeeId;
  final String? employeeName;

  @override
  ConsumerState<LeaveFormScreen> createState() => _LeaveFormScreenState();
}

class _LeaveFormScreenState extends ConsumerState<LeaveFormScreen> {
  LeaveKind _kind = LeaveKind.LEAVE;
  late bool _forTeam = widget.employeeId != null;
  late PickedEmployee? _subject = widget.employeeId == null ? null : (id: widget.employeeId!, name: widget.employeeName ?? '');
  String? _leaveTypeId;
  String _from = todayIso();
  String _to = todayIso();
  bool _fromHalf = false;
  bool _toHalf = false;
  bool _autoApprove = true;
  final _reason = TextEditingController();
  final _location = TextEditingController();
  final _purpose = TextEditingController();
  bool _saving = false;
  bool _tried = false;

  @override
  void dispose() {
    _reason.dispose();
    _location.dispose();
    _purpose.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    final l10n = AppLocalizations.of(context);
    setState(() => _tried = true);
    final invalid =
        _reason.text.trim().length < 3 ||
        (_kind == LeaveKind.LEAVE && _leaveTypeId == null) ||
        (_kind == LeaveKind.OD && _location.text.trim().isEmpty) ||
        (_forTeam && _subject == null) ||
        _to.compareTo(_from) < 0;
    if (invalid) return;
    setState(() => _saving = true);
    try {
      final created = await ref
          .read(requestsRepositoryProvider)
          .create(
            LeaveRequestCreateBody(
              subjectEmployeeId: _forTeam ? _subject!.id : null,
              kind: _kind,
              leaveTypeId: _kind == LeaveKind.LEAVE ? _leaveTypeId : null,
              fromDate: _from,
              toDate: _to,
              fromHalf: _fromHalf,
              toHalf: _toHalf,
              reason: _reason.text.trim(),
              odLocation: _kind == LeaveKind.OD ? _location.text.trim() : null,
              odPurpose: _kind == LeaveKind.OD && _purpose.text.trim().isNotEmpty ? _purpose.text.trim() : null,
              autoApprove: _forTeam ? _autoApprove : null,
            ),
          );
      ref.invalidate(leaveRequestsProvider);
      ref.invalidate(dashboardProvider);
      if (!mounted) return;
      showMessage(context, created.status == RequestStatus.APPROVED ? l10n.leaveApproved : l10n.leaveSubmitted);
      Navigator.pop(context);
    } catch (err) {
      if (mounted) {
        setState(() => _saving = false);
        showFailure(context, err);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final user = ref.watch(currentUserProvider);
    final types = ref.watch(leaveTypesProvider);
    final subjectId = _forTeam ? _subject?.id : user?.employeeId;
    final balances = subjectId == null || _kind == LeaveKind.OD ? null : ref.watch(leaveBalancesProvider(subjectId));
    final balance = balances?.value?.items.where((b) => b.leaveTypeId == _leaveTypeId).firstOrNull;
    String? err(bool bad) => _tried && bad ? l10n.required : null;

    return Scaffold(
      appBar: AppBar(title: Text(l10n.newRequest)),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          SegmentedButton<LeaveKind>(
            key: const Key('leave.kind'),
            segments: [
              ButtonSegment(value: LeaveKind.LEAVE, label: Text(l10n.kindLeave), icon: const Icon(Icons.beach_access_outlined)),
              ButtonSegment(value: LeaveKind.OD, label: Text(l10n.kindOd), icon: const Icon(Icons.work_outline)),
            ],
            selected: {_kind},
            onSelectionChanged: (s) => setState(() => _kind = s.first),
          ),
          if (user?.isRm ?? false) ...[
            const SizedBox(height: 12),
            SwitchListTile(
              key: const Key('leave.forTeam'),
              contentPadding: EdgeInsets.zero,
              title: Text(l10n.forTeamMember),
              value: _forTeam,
              onChanged: (v) => setState(() => _forTeam = v),
            ),
            if (_forTeam) ...[
              EmployeePickerField(
                value: _subject,
                filter: EmployeeFilter(staffOnly: true, reportingToEmployeeId: user!.employeeId),
                errorText: err(_subject == null),
                onChanged: (e) => setState(() => _subject = e),
              ),
              CheckboxListTile(
                key: const Key('leave.autoApprove'),
                contentPadding: EdgeInsets.zero,
                title: Text(l10n.approveNow),
                value: _autoApprove,
                onChanged: (v) => setState(() => _autoApprove = v ?? true),
              ),
            ],
          ],
          const SizedBox(height: 12),
          if (_kind == LeaveKind.LEAVE)
            AsyncView(
              value: types,
              onRetry: () => ref.invalidate(leaveTypesProvider),
              data: (list) => DropdownButtonFormField<String>(
                isExpanded: true,
                key: const Key('leave.type'),
                initialValue: _leaveTypeId,
                decoration: InputDecoration(labelText: l10n.leaveType, errorText: err(_leaveTypeId == null)),
                items: [for (final t in list.where((t) => t.isActive)) DropdownMenuItem(value: t.id, child: Text('${t.name} (${t.code})'))],
                onChanged: (v) => setState(() => _leaveTypeId = v),
              ),
            ),
          if (balance != null)
            Padding(
              padding: const EdgeInsets.only(top: 4),
              child: Text(
                balance.tracksBalance ? l10n.leaveAvailable(formatDays(balance.available), formatDays(balance.pending)) : l10n.noBalanceKept,
                key: const Key('leave.balance'),
              ),
            ),
          if (_kind == LeaveKind.OD) ...[
            TextField(
              key: const Key('leave.odLocation'),
              controller: _location,
              decoration: InputDecoration(labelText: l10n.odLocation, errorText: err(_location.text.trim().isEmpty)),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _purpose,
              decoration: InputDecoration(labelText: '${l10n.odPurpose} (${l10n.optional})'),
            ),
          ],
          const SizedBox(height: 12),
          DateField(
            label: l10n.fromDate,
            value: _from,
            onChanged: (v) => setState(() {
              _from = v;
              if (_to.compareTo(v) < 0) _to = v;
            }),
          ),
          CheckboxListTile(
            contentPadding: EdgeInsets.zero,
            title: Text(l10n.startsMidday),
            value: _fromHalf,
            onChanged: (v) => setState(() => _fromHalf = v ?? false),
          ),
          DateField(label: l10n.toDate, value: _to, firstDate: parseIsoDate(_from), onChanged: (v) => setState(() => _to = v)),
          CheckboxListTile(
            contentPadding: EdgeInsets.zero,
            title: Text(l10n.endsMidday),
            value: _toHalf,
            onChanged: (v) => setState(() => _toHalf = v ?? false),
          ),
          TextField(
            key: const Key('leave.reason'),
            controller: _reason,
            maxLines: 2,
            decoration: InputDecoration(labelText: l10n.reason, errorText: err(_reason.text.trim().length < 3)),
          ),
          const SizedBox(height: 16),
          FilledButton(
            key: const Key('leave.submit'),
            onPressed: _saving ? null : _submit,
            child: Text(_forTeam && _autoApprove ? l10n.saveAndApprove : l10n.submitForApproval),
          ),
        ],
      ),
    );
  }
}
