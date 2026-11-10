import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hrms_api/hrms_api.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../app/l10n/app_localizations.dart';
import '../../../core/format.dart';
import '../../../core/labels.dart';
import '../../../core/widgets/async_view.dart';
import '../../../core/widgets/date_field.dart';
import '../../employees/data/employees_repository.dart';
import '../../home/presentation/providers/dashboard_provider.dart';

part 'verification_queue_screen.g.dart';

/// Pending documents, oldest first (HR works the queue FIFO).
@riverpod
Future<List<DocumentWithEmployee>> verificationQueue(Ref ref) async {
  final repo = ref.watch(employeesRepositoryProvider);
  final items = <DocumentWithEmployee>[];
  String? cursor;
  do {
    final page = await repo.verificationQueue(cursor: cursor);
    items.addAll(page.items);
    cursor = page.nextCursor;
  } while (cursor != null && items.length < 500);
  return items;
}

/// HR document verification queue (CLAUDE.md §9).
class VerificationQueueScreen extends ConsumerWidget {
  const VerificationQueueScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final queue = ref.watch(verificationQueueProvider);
    return Scaffold(
      appBar: AppBar(title: Text(l10n.verifyQueueTitle)),
      body: RefreshIndicator(
        onRefresh: () => ref.refreshFuture(verificationQueueProvider.future),
        child: AsyncView(
          value: queue,
          onRetry: () => ref.invalidate(verificationQueueProvider),
          data: (items) => items.isEmpty
              ? ListView(
                  children: [EmptyState(icon: Icons.task_alt, message: l10n.verifyQueueEmpty)],
                )
              : ListView.separated(
                  key: const Key('verify.list'),
                  itemCount: items.length,
                  separatorBuilder: (_, _) => const Divider(height: 1),
                  itemBuilder: (context, i) {
                    final d = items[i];
                    return ListTile(
                      key: Key('verify.${d.id}'),
                      leading: const Icon(Icons.description_outlined),
                      title: Text('${d.employee.fullName} · ${l10n.documentType(d.type)}'),
                      subtitle: Text(
                        [
                          d.employee.empCode,
                          if (d.employee.depot != null) d.employee.depot!.code,
                          d.number,
                          if (d.expiryDate != null) l10n.validUntil(formatDate(d.expiryDate!)),
                        ].join(' · '),
                      ),
                      trailing: const Icon(Icons.chevron_right),
                      onTap: () async {
                        final done = await showModalBottomSheet<bool>(
                          context: context,
                          isScrollControlled: true,
                          useSafeArea: true,
                          builder: (_) => VerifySheet(document: d),
                        );
                        if (done == true) {
                          ref.invalidate(verificationQueueProvider);
                          ref.invalidate(dashboardProvider);
                        }
                      },
                    );
                  },
                ),
        ),
      ),
    );
  }
}

/// Shows the scan and lets HR verify (optionally correcting the expiry) or reject with a reason.
class VerifySheet extends ConsumerStatefulWidget {
  const VerifySheet({super.key, required this.document});

  final DocumentWithEmployee document;

  @override
  ConsumerState<VerifySheet> createState() => _VerifySheetState();
}

class _VerifySheetState extends ConsumerState<VerifySheet> {
  late String? _expiry = widget.document.expiryDate;
  late final Future<SignedUrlResponse?> _file = widget.document.hasFile
      ? ref.read(employeesRepositoryProvider).fileUrl(widget.document.id).then<SignedUrlResponse?>((v) => v, onError: (_) => null)
      : Future.value(null);
  bool _busy = false;

  Future<void> _verify() async {
    setState(() => _busy = true);
    try {
      await ref.read(employeesRepositoryProvider).verify(widget.document.id, expiryDate: _expiry == widget.document.expiryDate ? null : _expiry);
      if (mounted) Navigator.pop(context, true);
    } catch (err) {
      if (mounted) {
        setState(() => _busy = false);
        showFailure(context, err);
      }
    }
  }

  Future<void> _reject() async {
    final l10n = AppLocalizations.of(context);
    final reason = await showDialog<String>(
      context: context,
      builder: (_) => ReasonDialog(title: l10n.rejectDocument, label: l10n.rejectReason),
    );
    if (reason == null) return;
    setState(() => _busy = true);
    try {
      await ref.read(employeesRepositoryProvider).reject(widget.document.id, reason);
      if (mounted) Navigator.pop(context, true);
    } catch (err) {
      if (mounted) {
        setState(() => _busy = false);
        showFailure(context, err);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final d = widget.document;
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text('${d.employee.fullName} · ${l10n.documentType(d.type)}', style: Theme.of(context).textTheme.titleLarge),
          Text('${d.employee.empCode} · ${l10n.category(d.employee.category)}'),
          const SizedBox(height: 12),
          FutureBuilder<SignedUrlResponse?>(
            future: _file,
            builder: (context, snap) {
              if (snap.connectionState != ConnectionState.done) return const SizedBox(height: 200, child: Center(child: CircularProgressIndicator()));
              final url = snap.data?.url;
              if (url == null) return ListTile(leading: const Icon(Icons.hide_image_outlined), title: Text(l10n.noFile));
              return Column(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.network(
                      url,
                      height: 280,
                      fit: BoxFit.contain,
                      errorBuilder: (_, _, _) => ListTile(leading: const Icon(Icons.picture_as_pdf_outlined), title: Text(l10n.openFile)),
                    ),
                  ),
                  TextButton.icon(
                    onPressed: () => launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication),
                    icon: const Icon(Icons.open_in_new),
                    label: Text(l10n.openFile),
                  ),
                ],
              );
            },
          ),
          ListTile(title: Text(l10n.documentNumber), trailing: Text(d.number)),
          if (d.licenceClass != null) ListTile(title: Text(l10n.licenceClass), trailing: Text(d.licenceClass!)),
          if (d.issueDate != null) ListTile(title: Text(l10n.issueDate), trailing: Text(formatDate(d.issueDate!))),
          DateField(label: l10n.expiryDate, value: _expiry, onChanged: (v) => setState(() => _expiry = v)),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  key: const Key('verify.reject'),
                  onPressed: _busy ? null : _reject,
                  icon: const Icon(Icons.close),
                  label: Text(l10n.reject),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: FilledButton.icon(
                  key: const Key('verify.approve'),
                  onPressed: _busy ? null : _verify,
                  icon: const Icon(Icons.check),
                  label: Text(l10n.verifyDocument),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

/// Asks for a required free-text reason/comment. Pops the text, or null on cancel.
class ReasonDialog extends StatefulWidget {
  const ReasonDialog({super.key, required this.title, required this.label, this.optional = false});

  final String title;
  final String label;
  final bool optional;

  @override
  State<ReasonDialog> createState() => _ReasonDialogState();
}

class _ReasonDialogState extends State<ReasonDialog> {
  final _text = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final ok = widget.optional || _text.text.trim().length >= 3;
    return AlertDialog(
      title: Text(widget.title),
      content: TextField(
        key: const Key('reason.text'),
        controller: _text,
        autofocus: true,
        maxLines: 3,
        decoration: InputDecoration(labelText: widget.label),
        onChanged: (_) => setState(() {}),
      ),
      actions: [
        TextButton(onPressed: () => Navigator.pop(context), child: Text(l10n.cancel)),
        FilledButton(key: const Key('reason.ok'), onPressed: ok ? () => Navigator.pop(context, _text.text.trim()) : null, child: Text(l10n.ok)),
      ],
    );
  }
}
