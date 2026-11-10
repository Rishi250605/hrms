import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hrms_api/hrms_api.dart';

import '../../../app/l10n/app_localizations.dart';
import '../../../core/format.dart';
import '../../../core/labels.dart';
import '../../../core/widgets/async_view.dart';
import '../../../core/widgets/date_field.dart';
import '../../attendance/data/attendance_repository.dart';
import '../../attendance/presentation/attendance_screen.dart';
import '../../attendance/presentation/team_tab.dart' show kMarkable;
import '../../employees/presentation/employee_picker.dart';

/// Attendance change after the edit window closed or after approval (§4.3) — approved by my reporting manager.
class CorrectionFormScreen extends ConsumerStatefulWidget {
  const CorrectionFormScreen({super.key, this.employeeId, this.employeeName, this.date});

  final String? employeeId;
  final String? employeeName;
  final String? date;

  @override
  ConsumerState<CorrectionFormScreen> createState() => _CorrectionFormScreenState();
}

class _CorrectionFormScreenState extends ConsumerState<CorrectionFormScreen> {
  late PickedEmployee? _employee = widget.employeeId == null ? null : (id: widget.employeeId!, name: widget.employeeName ?? '');
  late String _date = widget.date ?? addDaysIso(todayIso(), -2);
  AttendanceStatus _status = AttendanceStatus.PRESENT;
  final _reason = TextEditingController();
  bool _saving = false;
  bool _tried = false;

  Future<void> _submit() async {
    final l10n = AppLocalizations.of(context);
    setState(() => _tried = true);
    if (_employee == null || _reason.text.trim().length < 3) return;
    setState(() => _saving = true);
    try {
      await ref
          .read(attendanceRepositoryProvider)
          .correction(CorrectionBody(employeeId: _employee!.id, date: _date, status: _status, reason: _reason.text.trim()));
      ref.invalidate(myAttendanceProvider);
      if (!mounted) return;
      showMessage(context, l10n.correctionSubmitted);
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
    return Scaffold(
      appBar: AppBar(title: Text(l10n.attendanceCorrection)),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          EmployeePickerField(value: _employee, errorText: _tried && _employee == null ? l10n.required : null, onChanged: (e) => setState(() => _employee = e)),
          const SizedBox(height: 12),
          DateField(label: l10n.date, value: _date, lastDate: DateTime.now(), onChanged: (v) => setState(() => _date = v)),
          const SizedBox(height: 12),
          DropdownButtonFormField<AttendanceStatus>(
            isExpanded: true,
            initialValue: _status,
            decoration: InputDecoration(labelText: l10n.correctTo),
            items: [for (final s in kMarkable) DropdownMenuItem(value: s, child: Text(l10n.attendanceStatus(s)))],
            onChanged: (s) => setState(() => _status = s ?? _status),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _reason,
            maxLines: 2,
            decoration: InputDecoration(labelText: l10n.reason, errorText: _tried && _reason.text.trim().length < 3 ? l10n.required : null),
          ),
          const SizedBox(height: 16),
          FilledButton(onPressed: _saving ? null : _submit, child: Text(l10n.submitForApproval)),
        ],
      ),
    );
  }
}
