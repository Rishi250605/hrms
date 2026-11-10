import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hrms_api/hrms_api.dart';

import '../../../app/l10n/app_localizations.dart';
import '../../../core/widgets/async_view.dart';
import '../../../core/widgets/depot_selector.dart' show MonthStepper;
import '../../../core/widgets/status_chip.dart';
import '../data/payslips_repository.dart';
import 'payslips_screen.dart';

/// HR bulk upload (§7.1): pick the pay period and many `payslip-<empCode>.pdf` files; see what matched.
class PayslipUploadScreen extends ConsumerStatefulWidget {
  const PayslipUploadScreen({super.key});

  @override
  ConsumerState<PayslipUploadScreen> createState() => _PayslipUploadScreenState();
}

class _PayslipUploadScreenState extends ConsumerState<PayslipUploadScreen> {
  String _period = MonthStepper.shift(MonthStepper.current(), -1);
  List<PayslipFile> _files = const [];
  bool _uploading = false;
  int _sent = 0;
  PayslipUploadResult? _result;

  Future<void> _pick() async {
    final picked = await FilePicker.pickFiles(type: FileType.custom, allowedExtensions: const ['pdf']);
    if (picked.isEmpty) return;
    final files = <PayslipFile>[];
    for (final f in picked) {
      files.add(PayslipFile(name: f.name, bytes: await f.readAsBytes()));
    }
    setState(() {
      _files = files;
      _result = null;
    });
  }

  Future<void> _upload() async {
    setState(() {
      _uploading = true;
      _sent = 0;
    });
    try {
      final result = await ref.read(payslipsRepositoryProvider).upload(_period, _files, onProgress: (n) => setState(() => _sent = n));
      ref.invalidate(payslipsProvider);
      if (mounted) {
        setState(() {
          _result = result;
          _files = const [];
        });
      }
    } catch (e) {
      if (mounted) showFailure(context, e);
    } finally {
      if (mounted) setState(() => _uploading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final r = _result;
    return Scaffold(
      appBar: AppBar(title: Text(l10n.uploadPayslips)),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Row(
            children: [
              Expanded(child: Text(l10n.payPeriod)),
              MonthStepper(month: _period, label: monthLabel(_period), onChanged: (m) => setState(() => _period = m)),
            ],
          ),
          const SizedBox(height: 8),
          Text(l10n.payslipNameRule, style: Theme.of(context).textTheme.bodySmall),
          const SizedBox(height: 12),
          OutlinedButton.icon(
            key: const Key('upload.pick'),
            onPressed: _uploading ? null : _pick,
            icon: const Icon(Icons.folder_open),
            label: Text(l10n.choosePdfs),
          ),
          if (_files.isNotEmpty) ...[
            const SizedBox(height: 8),
            Text(l10n.filesChosen(_files.length)),
            const SizedBox(height: 8),
            FilledButton.icon(
              key: const Key('upload.go'),
              onPressed: _uploading ? null : _upload,
              icon: const Icon(Icons.cloud_upload_outlined),
              label: Text(_uploading ? l10n.uploadingProgress(_sent, _files.length) : l10n.uploadForPeriod(monthLabel(_period))),
            ),
            if (_uploading)
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: LinearProgressIndicator(value: _files.isEmpty ? null : _sent / _files.length),
              ),
          ],
          if (r != null) ...[
            const Divider(height: 32),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                StatusChip(key: const Key('upload.matched'), label: l10n.matchedCount(r.matched.length), tone: Tone.good),
                if (r.replaced.isNotEmpty) StatusChip(label: l10n.replacedCount(r.replaced.length), tone: Tone.info),
                if (r.unmatched.isNotEmpty) StatusChip(label: l10n.unmatchedCount(r.unmatched.length), tone: Tone.warn),
                if (r.invalid.isNotEmpty) StatusChip(label: l10n.invalidCount(r.invalid.length), tone: Tone.bad),
                if (r.duplicates.isNotEmpty) StatusChip(label: l10n.duplicateCount(r.duplicates.length), tone: Tone.bad),
              ],
            ),
            if (r.unmatched.isNotEmpty) _Section(title: l10n.unmatchedFiles, lines: r.unmatched),
            if (r.invalid.isNotEmpty) _Section(title: l10n.invalidFiles, lines: [for (final i in r.invalid) '${i.fileName} — ${i.reason.value}']),
            if (r.duplicates.isNotEmpty) _Section(title: l10n.duplicateFiles, lines: r.duplicates),
            _Section(
              title: l10n.matchedFiles,
              lines: [for (final m in r.matched) '${m.employee.empCode} · ${m.employee.name}${m.version > 1 ? ' (v${m.version})' : ''}'],
            ),
          ],
        ],
      ),
    );
  }
}

class _Section extends StatelessWidget {
  const _Section({required this.title, required this.lines});

  final String title;
  final List<String> lines;

  @override
  Widget build(BuildContext context) => ExpansionTile(
    title: Text('$title (${lines.length})'),
    initiallyExpanded: lines.length <= 10,
    children: [for (final l in lines) ListTile(dense: true, title: Text(l))],
  );
}
