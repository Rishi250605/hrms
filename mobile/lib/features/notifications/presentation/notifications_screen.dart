import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../app/destinations.dart';
import '../../../app/l10n/app_localizations.dart';
import '../../../app/router.dart';
import '../../../core/format.dart';
import '../../../core/widgets/async_view.dart';
import '../../home/data/dashboard_repository.dart';
import '../../home/presentation/providers/dashboard_provider.dart';

/// Where tapping a notification goes (PHASE-2-FEATURES §10: "opens the related record").
String? notificationTarget(String? entityType, String? entityId) => switch (entityType) {
  'ATTENDANCE' || 'CORRECTION' => AppDestination.attendance.path,
  'LEAVE' => AppDestination.requests.path,
  'ALLOWANCE' => entityId == null ? AppDestination.allowances.path : '${AppDestination.allowances.path}?open=$entityId',
  'TASK' => entityId == null ? AppDestination.tasks.path : '${AppDestination.tasks.path}?open=$entityId',
  'PAYSLIP_PERIOD' => entityId == null ? AppDestination.payslips.path : '${AppDestination.payslips.path}?period=$entityId',
  'PAYSLIP' => AppDestination.payslips.path,
  'DOCUMENT' => AppDestination.documents.path,
  'EMPLOYEE' => entityId == null ? null : Routes.employee(entityId),
  'USER' => AppDestination.profile.path,
  _ => null,
};

/// In-app feed of the notices also pushed to the manager's devices (bell icon).
class NotificationsScreen extends ConsumerWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final page = ref.watch(notificationsProvider);
    final repo = ref.read(dashboardRepositoryProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.navNotifications),
        actions: [
          TextButton(
            onPressed: () async {
              await repo.markAllRead();
              ref.invalidate(notificationsProvider);
              ref.invalidate(dashboardProvider);
            },
            child: Text(l10n.markAllRead),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () => ref.refreshFuture(notificationsProvider.future),
        child: AsyncView(
          value: page,
          onRetry: () => ref.invalidate(notificationsProvider),
          data: (p) => p.items.isEmpty
              ? ListView(
                  children: [EmptyState(icon: Icons.notifications_none, message: l10n.noNotifications)],
                )
              : ListView.separated(
                  itemCount: p.items.length,
                  separatorBuilder: (_, _) => const Divider(height: 1),
                  itemBuilder: (context, i) {
                    final n = p.items[i];
                    final unread = n.readAt == null;
                    return ListTile(
                      key: Key('notification.${n.id}'),
                      leading: Icon(unread ? Icons.circle : Icons.circle_outlined, size: 12, color: unread ? Theme.of(context).colorScheme.primary : null),
                      title: Text(n.title, style: unread ? const TextStyle(fontWeight: FontWeight.w600) : null),
                      subtitle: Text('${n.body}\n${formatDateTime(n.createdAt)}'),
                      isThreeLine: true,
                      onTap: () async {
                        if (unread) {
                          try {
                            await repo.markRead(n.id);
                          } catch (_) {}
                          ref.invalidate(notificationsProvider);
                          ref.invalidate(dashboardProvider);
                        }
                        final target = notificationTarget(n.entityType, n.entityId);
                        if (target != null && context.mounted) await context.push(target);
                      },
                    );
                  },
                ),
        ),
      ),
    );
  }
}
