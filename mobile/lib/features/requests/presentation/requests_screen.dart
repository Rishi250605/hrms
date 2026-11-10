import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:hrms_api/hrms_api.dart';

import '../../../app/l10n/app_localizations.dart';
import '../../../app/router.dart';
import '../../../core/format.dart';
import '../../../core/labels.dart';
import '../../../core/session.dart';
import '../../../core/widgets/async_view.dart';
import '../../../core/widgets/bu_switcher.dart';
import '../../../core/widgets/status_chip.dart';
import '../../attendance/presentation/approvals_tab.dart' show askReason;
import '../../auth/domain/current_user.dart';
import '../../home/presentation/providers/dashboard_provider.dart';
import '../data/requests_repository.dart';
import 'providers/requests_providers.dart';

/// Tabs per role (§5, §11 Leave/OD): RM mine / team / approvals (their drivers); OM mine / team / approvals;
/// HR mine / approvals / all; director approvals / all.
List<String> leaveTabsFor(UserRole role) => switch (role) {
  UserRole.regionalManager || UserRole.operationalManager => const ['mine', 'team', 'approvals'],
  UserRole.hr => const ['mine', 'approvals', 'all'],
  UserRole.director => const ['approvals', 'all'],
};

class RequestsScreen extends ConsumerWidget {
  const RequestsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final user = ref.watch(currentUserProvider);
    if (user == null) return const SizedBox.shrink();
    final tabs = leaveTabsFor(user.role);
    String label(String t) => switch (t) {
      'mine' => l10n.tabMine,
      'team' => l10n.tabTeam,
      'approvals' => l10n.tabApprovals,
      _ => l10n.filterAll,
    };
    return DefaultTabController(
      length: tabs.length,
      child: Scaffold(
        appBar: AppBar(
          title: Text(l10n.navLeave),
          actions: const [BusinessUnitSwitcher()],
          bottom: TabBar(
            tabs: [for (final t in tabs) Tab(key: Key('leave.tab.$t'), text: label(t))],
          ),
        ),
        floatingActionButton: user.isDirector
            ? null
            : FloatingActionButton.extended(
                key: const Key('leave.new'),
                onPressed: () => context.push(Routes.newLeave),
                icon: const Icon(Icons.add),
                label: Text(l10n.newRequest),
              ),
        body: TabBarView(children: [for (final t in tabs) _LeaveList(scope: t)]),
      ),
    );
  }
}

class _LeaveList extends ConsumerWidget {
  const _LeaveList({required this.scope});

  final String scope;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final page = ref.watch(leaveRequestsProvider(scope));
    return RefreshIndicator(
      onRefresh: () => ref.refreshFuture(leaveRequestsProvider(scope).future),
      child: AsyncView(
        value: page,
        onRetry: () => ref.invalidate(leaveRequestsProvider(scope)),
        data: (p) => p.items.isEmpty
            ? ListView(
                children: [EmptyState(icon: Icons.event_available_outlined, message: scope == 'approvals' ? l10n.inboxEmpty : l10n.noRequests)],
              )
            : ListView.separated(
                padding: const EdgeInsets.only(bottom: 88),
                itemCount: p.items.length,
                separatorBuilder: (_, _) => const Divider(height: 1),
                itemBuilder: (context, i) {
                  final r = p.items[i];
                  final what = r.kind == LeaveKind.OD ? l10n.kindOd : (r.leaveType?.name ?? l10n.kindLeave);
                  final dates = r.fromDate == r.toDate ? formatDate(r.fromDate) : '${formatDate(r.fromDate)} – ${formatDate(r.toDate)}';
                  return ListTile(
                    key: Key('leave.${r.id}'),
                    title: Text(scope == 'mine' && r.employee.name.isNotEmpty ? '$what · ${l10n.leaveDays(formatDays(r.days))}' : '${r.employee.name} · $what'),
                    subtitle: Text('$dates · ${r.reason}', maxLines: 2, overflow: TextOverflow.ellipsis),
                    trailing: StatusChip(label: l10n.requestStatus(r.status), tone: requestTone(r.status)),
                    onTap: () => showModalBottomSheet<void>(
                      context: context,
                      isScrollControlled: true,
                      builder: (_) => LeaveDetailSheet(item: r, scope: scope),
                    ),
                  );
                },
              ),
      ),
    );
  }
}

class LeaveDetailSheet extends ConsumerWidget {
  const LeaveDetailSheet({super.key, required this.item, required this.scope});

  final LeaveRequestItem item;
  final String scope;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final r = item;
    final repo = ref.read(requestsRepositoryProvider);

    Future<void> act(Future<Object?> Function() action, String done) async {
      try {
        await action();
        ref.invalidate(leaveRequestsProvider);
        ref.invalidate(dashboardProvider);
        if (context.mounted) {
          Navigator.pop(context);
          showMessage(context, done);
        }
      } catch (e) {
        if (context.mounted) showFailure(context, e);
      }
    }

    String row(String label, String value) => '$label: $value';
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(child: Text('${r.employee.name} (${r.employee.empCode})', style: theme.textTheme.titleMedium)),
                StatusChip(label: l10n.requestStatus(r.status), tone: requestTone(r.status)),
              ],
            ),
            const SizedBox(height: 8),
            Text(row(l10n.requestType, r.kind == LeaveKind.OD ? l10n.kindOd : '${l10n.kindLeave} · ${r.leaveType?.name ?? ''}')),
            Text(
              row(
                l10n.dates,
                '${formatDate(r.fromDate)}${r.fromHalf ? ' (½)' : ''} – ${formatDate(r.toDate)}${r.toHalf ? ' (½)' : ''} · ${l10n.leaveDays(formatDays(r.days))}',
              ),
            ),
            if (r.kind == LeaveKind.OD) ...[
              if (r.odLocation != null) Text(row(l10n.odLocation, r.odLocation!)),
              if (r.odPurpose != null) Text(row(l10n.odPurpose, r.odPurpose!)),
              if (r.odFromTime != null) Text(row(l10n.time, '${r.odFromTime} – ${r.odToTime ?? ''}')),
            ],
            Text(row(l10n.reason, r.reason)),
            Text(row(l10n.raisedByLabel, r.raisedByName)),
            if (r.approver != null) Text(row(l10n.approver, r.approver!.name)),
            if (r.rejectionReason != null) Text(l10n.rejectedBecause(r.rejectionReason!), style: TextStyle(color: theme.colorScheme.error)),
            for (final w in r.warnings)
              Padding(
                padding: const EdgeInsets.only(top: 4),
                child: StatusChip(label: w, tone: Tone.warn, icon: Icons.warning_amber),
              ),
            const SizedBox(height: 16),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              alignment: WrapAlignment.end,
              children: [
                if (r.canCancel)
                  OutlinedButton(key: const Key('leave.cancel'), onPressed: () => act(() => repo.cancel(r.id), l10n.cancelled), child: Text(l10n.withdraw)),
                if (r.canDecide) ...[
                  OutlinedButton(
                    key: const Key('leave.reject'),
                    onPressed: () async {
                      final reason = await askReason(context);
                      if (reason != null) await act(() => repo.reject(r.id, reason), l10n.rejectedMessage);
                    },
                    child: Text(l10n.reject),
                  ),
                  FilledButton(
                    key: const Key('leave.approve'),
                    onPressed: () => act(() => repo.approve(r.id), l10n.approvedMessage),
                    child: Text(l10n.approve),
                  ),
                ],
              ],
            ),
          ],
        ),
      ),
    );
  }
}
