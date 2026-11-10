import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hrms_api/hrms_api.dart';
import 'package:image_picker/image_picker.dart';

import '../../../app/l10n/app_localizations.dart';
import '../../../core/format.dart';
import '../../../core/labels.dart';
import '../../../core/session.dart';
import '../../../core/widgets/async_view.dart';
import '../../../core/widgets/date_field.dart';
import '../../employees/data/employees_repository.dart';
import '../../employees/presentation/employee_picker.dart';
import '../../home/presentation/providers/dashboard_provider.dart';
import '../data/allowances_repository.dart';
import 'providers/allowances_providers.dart';
import 'widgets/voice_note.dart';

/// New allowance request (§6.2). An RM can raise for themself or for several drivers / loadmen at once
/// (one request each, one batch). A comment and/or a voice note is required; a receipt photo is optional.
class AllowanceFormScreen extends ConsumerStatefulWidget {
  const AllowanceFormScreen({super.key});

  @override
  ConsumerState<AllowanceFormScreen> createState() => _AllowanceFormScreenState();
}

class _AllowanceFormScreenState extends ConsumerState<AllowanceFormScreen> {
  bool _forTeam = false;
  List<PickedEmployee> _beneficiaries = const [];
  String? _typeId;
  final _amount = TextEditingController();
  final _comment = TextEditingController();
  String _from = todayIso();
  String? _to;
  Uint8List? _voice;
  PickedUpload? _receipt;
  bool _saving = false;
  bool _tried = false;

  @override
  void dispose() {
    _amount.dispose();
    _comment.dispose();
    super.dispose();
  }

  Future<void> _pickReceipt(ImageSource source) async {
    final file = await ImagePicker().pickImage(source: source, maxWidth: 2000, imageQuality: 80);
    if (file == null) return;
    final bytes = await file.readAsBytes();
    setState(() => _receipt = PickedUpload(bytes: bytes, contentType: 'image/jpeg'));
  }

  Future<void> _submit() async {
    final l10n = AppLocalizations.of(context);
    setState(() => _tried = true);
    final paise = parseRupees(_amount.text);
    if (_typeId == null || paise == null || (_comment.text.trim().isEmpty && _voice == null) || (_forTeam && _beneficiaries.isEmpty)) return;
    setState(() => _saving = true);
    try {
      final uploads = ref.read(employeesRepositoryProvider);
      final voiceKey = _voice == null
          ? null
          : await uploads.upload(null, PickedUpload(bytes: _voice!, contentType: 'audio/mp4'), PresignBodyPurposeEnum.VOICE_NOTE);
      final receiptKey = _receipt == null ? null : await uploads.upload(null, _receipt!, PresignBodyPurposeEnum.RECEIPT);
      final created = await ref
          .read(allowancesRepositoryProvider)
          .create(
            AllowanceCreateBody(
              beneficiaryEmployeeIds: _forTeam ? [for (final b in _beneficiaries) b.id] : null,
              allowanceTypeId: _typeId!,
              amountPaise: paise,
              fromDate: _from,
              toDate: _to,
              comment: _comment.text.trim().isEmpty ? null : _comment.text.trim(),
              voiceNoteKey: voiceKey,
              receiptKey: receiptKey,
            ),
          );
      ref.invalidate(allowancesProvider);
      ref.invalidate(dashboardProvider);
      if (!mounted) return;
      showMessage(context, l10n.allowanceSubmitted(created.length));
      Navigator.pop(context);
    } catch (e) {
      if (mounted) {
        setState(() => _saving = false);
        showFailure(context, e);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final user = ref.watch(currentUserProvider);
    final types = ref.watch(allowanceTypesProvider);
    final type = types.value?.where((t) => t.id == _typeId).firstOrNull;
    final paise = parseRupees(_amount.text);
    String? err(bool bad, [String? message]) => _tried && bad ? (message ?? l10n.required) : null;

    return Scaffold(
      appBar: AppBar(title: Text(l10n.newAllowance)),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          if (user?.isRm ?? false) ...[
            SegmentedButton<bool>(
              key: const Key('allowance.for'),
              segments: [
                ButtonSegment(value: false, label: Text(l10n.forMyself)),
                ButtonSegment(value: true, label: Text(l10n.forMyTeam)),
              ],
              selected: {_forTeam},
              onSelectionChanged: (s) => setState(() => _forTeam = s.first),
            ),
            if (_forTeam)
              ListTile(
                key: const Key('allowance.beneficiaries'),
                contentPadding: EdgeInsets.zero,
                title: Text(_beneficiaries.isEmpty ? l10n.chooseEmployees : _beneficiaries.map((b) => b.name).join(', ')),
                subtitle: err(_beneficiaries.isEmpty) != null ? Text(l10n.required, style: TextStyle(color: Theme.of(context).colorScheme.error)) : null,
                trailing: const Icon(Icons.group_add_outlined),
                onTap: () async {
                  final picked = await showDialog<List<PickedEmployee>>(
                    context: context,
                    builder: (_) => EmployeeSearchDialog(
                      multiple: true,
                      initial: _beneficiaries,
                      filter: EmployeeFilter(staffOnly: true, reportingToEmployeeId: user!.employeeId),
                    ),
                  );
                  if (picked != null) setState(() => _beneficiaries = picked);
                },
              ),
            const SizedBox(height: 12),
          ],
          AsyncView(
            value: types,
            onRetry: () => ref.invalidate(allowanceTypesProvider),
            data: (list) => DropdownButtonFormField<String>(
              isExpanded: true,
              key: const Key('allowance.type'),
              initialValue: _typeId,
              decoration: InputDecoration(labelText: l10n.allowanceType, errorText: err(_typeId == null)),
              items: [for (final t in list.where((t) => t.isActive)) DropdownMenuItem(value: t.id, child: Text(t.name))],
              onChanged: (v) => setState(() => _typeId = v),
            ),
          ),
          const SizedBox(height: 12),
          TextField(
            key: const Key('allowance.amountField'),
            controller: _amount,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            onChanged: (_) => setState(() {}),
            decoration: InputDecoration(
              labelText: _forTeam ? l10n.amountPerPerson : l10n.amount,
              prefixText: '₹ ',
              helperText: type?.maxAmountPaise != null ? l10n.maxAmount(formatRupees(type!.maxAmountPaise!)) : null,
              errorText: err(paise == null, l10n.amountInvalid),
            ),
          ),
          if (_forTeam && paise != null && _beneficiaries.length > 1)
            Padding(padding: const EdgeInsets.only(top: 4), child: Text(l10n.batchTotal(formatRupees(paise * _beneficiaries.length)))),
          const SizedBox(height: 12),
          DateField(label: l10n.fromDate, value: _from, lastDate: DateTime.now().add(const Duration(days: 31)), onChanged: (v) => setState(() => _from = v)),
          DateField(label: '${l10n.toDate} (${l10n.optional})', value: _to, firstDate: parseIsoDate(_from), onChanged: (v) => setState(() => _to = v)),
          const SizedBox(height: 12),
          TextField(
            key: const Key('allowance.commentField'),
            controller: _comment,
            maxLines: 3,
            onChanged: (_) => setState(() {}),
            decoration: InputDecoration(labelText: l10n.comment, errorText: err(_comment.text.trim().isEmpty && _voice == null, l10n.commentOrVoice)),
          ),
          const SizedBox(height: 12),
          VoiceNoteRecorder(onChanged: (b) => setState(() => _voice = b)),
          const SizedBox(height: 12),
          InputDecorator(
            decoration: InputDecoration(labelText: '${l10n.receiptPhoto} (${l10n.optional})'),
            child: Wrap(
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                if (_receipt != null) ...[
                  ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: Image.memory(_receipt!.bytes, height: 56, width: 56, fit: BoxFit.cover),
                  ),
                  const SizedBox(width: 8),
                  IconButton(tooltip: l10n.remove, onPressed: () => setState(() => _receipt = null), icon: const Icon(Icons.delete_outline)),
                ] else ...[
                  TextButton.icon(
                    onPressed: () => _pickReceipt(ImageSource.camera),
                    icon: const Icon(Icons.photo_camera_outlined),
                    label: Text(l10n.takePhoto),
                  ),
                  TextButton.icon(
                    onPressed: () => _pickReceipt(ImageSource.gallery),
                    icon: const Icon(Icons.photo_library_outlined),
                    label: Text(l10n.chooseFile),
                  ),
                ],
              ],
            ),
          ),
          const SizedBox(height: 16),
          FilledButton(key: const Key('allowance.submit'), onPressed: _saving ? null : _submit, child: Text(l10n.submitForApproval)),
        ],
      ),
    );
  }
}
