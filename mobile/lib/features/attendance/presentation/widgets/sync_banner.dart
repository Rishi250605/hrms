import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../app/l10n/app_localizations.dart';
import '../../data/offline/attendance_queue.dart';
import '../providers/attendance_sync.dart';

/// Offline state of the attendance queue: "N marks waiting to sync" (offline / syncing) and rejected marks.
class SyncBanner extends ConsumerWidget {
  const SyncBanner({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final queued = ref.watch(queuedMarksProvider).value ?? const <QueuedMark>[];
    final sync = ref.watch(attendanceSyncProvider);
    final pending = queued.where((m) => m.state == QueuedState.pending).length;
    final failed = queued.where((m) => m.state == QueuedState.failed).toList();
    if (pending == 0 && failed.isEmpty) return const SizedBox.shrink();
    final scheme = Theme.of(context).colorScheme;
    return Column(
      children: [
        if (pending > 0)
          MaterialBanner(
            key: const Key('sync.pending'),
            backgroundColor: sync.offline ? scheme.tertiaryContainer : scheme.secondaryContainer,
            leading: Icon(sync.offline ? Icons.cloud_off : Icons.cloud_upload_outlined),
            content: Text(sync.offline ? l10n.offlinePending(pending) : l10n.syncingPending(pending)),
            actions: [TextButton(onPressed: sync.syncing ? null : () => ref.read(attendanceSyncProvider.notifier).sync(), child: Text(l10n.retry))],
          ),
        if (failed.isNotEmpty)
          MaterialBanner(
            key: const Key('sync.failed'),
            backgroundColor: scheme.errorContainer,
            leading: const Icon(Icons.error_outline),
            content: Text(
              '${l10n.syncRejected(failed.length)}\n${failed.take(3).map((m) => '${m.employeeName} (${m.date}): ${m.errorMessage ?? m.errorCode}').join('\n')}',
            ),
            actions: [TextButton(onPressed: () => ref.read(attendanceSyncProvider.notifier).discardFailed(), child: Text(l10n.dismiss))],
          ),
      ],
    );
  }
}
