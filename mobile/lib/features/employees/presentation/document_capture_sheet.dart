import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hrms_api/hrms_api.dart';

import '../../../app/l10n/app_localizations.dart';
import '../../../core/labels.dart';
import '../../../core/widgets/async_view.dart';
import '../../../core/widgets/date_field.dart';
import '../data/employees_repository.dart';
import 'providers/employees_providers.dart';

/// Camera → upload → document pending HR verification (CLAUDE.md §9 "Document capture").
/// Pops `true` when saved.
class DocumentCaptureSheet extends ConsumerStatefulWidget {
  const DocumentCaptureSheet({super.key, required this.employeeId, this.initialType});

  final String employeeId;
  final DocumentType? initialType;

  @override
  ConsumerState<DocumentCaptureSheet> createState() => _DocumentCaptureSheetState();
}

class _DocumentCaptureSheetState extends ConsumerState<DocumentCaptureSheet> {
  final _form = GlobalKey<FormState>();
  late DocumentType _type = widget.initialType ?? DocumentType.DRIVING_LICENCE;
  final _number = TextEditingController();
  final _licenceClass = TextEditingController();
  String? _issue;
  String? _expiry;
  PickedUpload? _file;
  bool _saving = false;
  bool _photoMissing = false;

  Future<void> _pick({required bool camera}) async {
    final file = await ref.read(filePickerProvider)(camera: camera);
    if (file != null) {
      setState(() {
        _file = file;
        _photoMissing = false;
      });
    }
  }

  Future<void> _save() async {
    final valid = _form.currentState!.validate();
    // Shown inline: a snackbar would sit behind / on top of the sheet.
    setState(() => _photoMissing = _file == null);
    if (!valid || _file == null) return;
    setState(() => _saving = true);
    final repo = ref.read(employeesRepositoryProvider);
    try {
      final key = await repo.upload(widget.employeeId, _file!, PresignBodyPurposeEnum.DOCUMENT);
      await repo.createDocument(
        widget.employeeId,
        DocumentCreateBody(
          type: _type,
          number: _number.text.trim(),
          licenceClass: _licenceClass.text.trim().isEmpty ? null : _licenceClass.text.trim(),
          issueDate: _issue,
          expiryDate: _expiry,
          fileKey: key,
        ),
      );
      if (mounted) Navigator.pop(context, true);
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
    final aadhaar = _type == DocumentType.AADHAAR;
    return Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.viewInsetsOf(context).bottom),
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _form,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(l10n.addDocument, style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 16),
              DropdownButtonFormField<DocumentType>(
                isExpanded: true,
                key: const Key('capture.type'),
                initialValue: _type,
                decoration: InputDecoration(labelText: l10n.documentTypeLabel),
                items: [for (final t in DocumentType.values) DropdownMenuItem(value: t, child: Text(l10n.documentType(t)))],
                onChanged: (t) => setState(() => _type = t ?? _type),
              ),
              const SizedBox(height: 12),
              TextFormField(
                key: const Key('capture.number'),
                controller: _number,
                keyboardType: aadhaar ? TextInputType.number : TextInputType.text,
                textCapitalization: TextCapitalization.characters,
                decoration: InputDecoration(labelText: aadhaar ? l10n.aadhaarLast4 : l10n.documentNumber, helperText: aadhaar ? l10n.aadhaarHelper : null),
                validator: (v) {
                  final s = (v ?? '').replaceAll(' ', '');
                  if (aadhaar) return RegExp(r'^\d{4}$').hasMatch(s) ? null : l10n.aadhaarLast4Invalid;
                  return s.length < 4 ? l10n.required : null;
                },
              ),
              if (_type == DocumentType.DRIVING_LICENCE) ...[
                const SizedBox(height: 12),
                TextFormField(
                  controller: _licenceClass,
                  decoration: InputDecoration(labelText: l10n.licenceClass),
                ),
              ],
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: DateField(label: l10n.issueDate, value: _issue, lastDate: DateTime.now(), onChanged: (v) => setState(() => _issue = v)),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: DateField(key: const Key('capture.expiry'), label: l10n.expiryDate, value: _expiry, onChanged: (v) => setState(() => _expiry = v)),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              if (_file != null)
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.memory(_file!.bytes, height: 160, fit: BoxFit.cover, errorBuilder: (_, _, _) => const Icon(Icons.description, size: 64)),
                ),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton.icon(
                      key: const Key('capture.camera'),
                      onPressed: () => _pick(camera: true),
                      icon: const Icon(Icons.photo_camera_outlined),
                      label: Text(l10n.takePhoto),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () => _pick(camera: false),
                      icon: const Icon(Icons.photo_library_outlined),
                      label: Text(l10n.chooseFile),
                    ),
                  ),
                ],
              ),
              if (_photoMissing)
                Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: Text(
                    l10n.photoRequired,
                    key: const Key('capture.photoMissing'),
                    style: TextStyle(color: Theme.of(context).colorScheme.error),
                  ),
                ),
              const SizedBox(height: 16),
              FilledButton(
                key: const Key('capture.save'),
                onPressed: _saving ? null : _save,
                child: _saving ? const SizedBox(height: 20, width: 20, child: CircularProgressIndicator(strokeWidth: 2)) : Text(l10n.saveForVerification),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
