import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../app/l10n/app_localizations.dart';
import '../../../core/format.dart';
import '../../../core/labels.dart';
import '../../../core/widgets/async_view.dart';
import '../../home/presentation/providers/dashboard_provider.dart';
import '../data/attendance_repository.dart';
import 'attendance_screen.dart';

/// Asks for a rejection reason (min 3 characters); null when cancelled.
Future<String?> askReason(BuildContext context, {String? title}) {
  final l10n = AppLocalizations.of(context);
  final controller = TextEditingController();
  return showDialog<String>(
    context: context,
    builder: (ctx) => AlertDialog(
      title: Text(title ?? l10n.reject),
      content: TextField(
        key: const Key('reason.field'),
        controller: controller,
        autofocus: true,
        maxLines: 3,
        decoration: InputDecoration(labelText: l10n.reason, border: const OutlineInputBorder()),
      ),
      actions: [
        TextButton(onPressed: () => Navigator.pop(ctx), child: Text(l10n.cancel)),
        FilledButton(
          key: const Key('reason.ok'),
          onPressed: () {
            if (controller.text.trim().length >= 3) Navigator.pop(ctx, controller.text.trim());
          },
          child: Text(l10n.reject),
        ),
      ],
    ),
  );
}

/// Self-marks and corrections of my direct reports waiting for me (§4.2, §11 "Attendance approvals").
class AttendanceApprovalsTab extends ConsumerWidget {
  const AttendanceApprovalsTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final data = ref.watch(attendanceApprovalsProvider);
    final repo = ref.read(attendanceRepositoryProvider);

    Future<void> run(Future<void> Function() action, String done) async {
      try {
        await action();
        ref.invalidate(attendanceApprovalsProvider);
        ref.invalidate(dashboardProvider);
        if (context.mounted) showMessage(context, done);
      } catch (e) {
        if (context.mounted) showFailure(context, e);
      }
    }

    return RefreshIndicator(
      onRefresh: () => ref.refreshFuture(attendanceApprovalsProvider.future),
      child: AsyncView(
        value: data,
        onRetry: () => ref.invalidate(attendanceApprovalsProvider),
        data: (d) {
          final decidable = d.marks.where((m) => m.canDecide).toList();
          if (d.marks.isEmpty && d.corrections.isEmpty) {
            return ListView(
              children: [EmptyState(icon: Icons.inbox_outlined, message: l10n.inboxEmpty)],
            );
          }
          return ListView(
            padding: const EdgeInsets.only(bottom: 24),
            children: [
              if (decidable.length > 1)
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: FilledButton.icon(
                    key: const Key('approvals.approveAll'),
                    onPressed: () => run(() => repo.approveMany([for (final m in decidable) m.id]), l10n.approvedCount(decidable.length)),
                    icon: const Icon(Icons.done_all),
                    label: Text(l10n.approveAll(decidable.length)),
                  ),
                ),
              for (final m in d.marks)
                Card(
                  key: Key('approval.mark.${m.id}'),
                  margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  child: ListTile(
                    title: Text('${m.employee.fullName} · ${l10n.attendanceStatus(m.status)}'),
                    subtitle: Text([formatDate(m.date), m.businessUnit.code, if (m.note != null) m.note!].join(' · ')),
                    trailing: m.canDecide
                        ? Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                key: Key('approval.reject.${m.id}'),
                                tooltip: l10n.reject,
                                icon: const Icon(Icons.close),
                                onPressed: () async {
                                  final reason = await askReason(context);
                                  if (reason != null) await run(() => repo.reject(m.id, reason), l10n.rejectedMessage);
                                },
                              ),
                              IconButton(
                                key: Key('approval.approve.${m.id}'),
                                tooltip: l10n.approve,
                                icon: const Icon(Icons.check),
                                onPressed: () => run(() => repo.approve(m.id), l10n.approvedMessage),
                              ),
                            ],
                          )
                        : null,
                  ),
                ),
              if (d.corrections.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 4),
                  child: Text(l10n.corrections, style: Theme.of(context).textTheme.titleSmall),
                ),
              for (final c in d.corrections)
                Card(
                  key: Key('approval.correction.${c.id}'),
                  margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  child: ListTile(
                    title: Text('${c.employee.fullName} · ${formatDate(c.date)}'),
                    subtitle: Text(
                      '${c.fromStatus == null ? l10n.notMarked : l10n.attendanceStatus(c.fromStatus!)} → ${l10n.attendanceStatus(c.toStatus)}\n${c.reason} · ${l10n.raisedBy(c.raisedByName)}',
                    ),
                    isThreeLine: true,
                    trailing: c.canDecide
                        ? Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                tooltip: l10n.reject,
                                icon: const Icon(Icons.close),
                                onPressed: () async {
                                  final reason = await askReason(context);
                                  if (reason != null) await run(() => repo.rejectCorrection(c.id, reason), l10n.rejectedMessage);
                                },
                              ),
                              IconButton(
                                tooltip: l10n.approve,
                                icon: const Icon(Icons.check),
                                onPressed: () => run(() => repo.approveCorrection(c.id), l10n.approvedMessage),
                              ),
                            ],
                          )
                        : null,
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}
