import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:hrms_api/hrms_api.dart';
import 'package:intl/intl.dart';

import '../../../app/destinations.dart';
import '../../../app/l10n/app_localizations.dart';
import '../../../core/labels.dart';
import '../../../core/session.dart';
import '../../../core/widgets/async_view.dart';
import '../../../core/widgets/bu_switcher.dart';
import '../../../core/widgets/profile_avatar.dart';
import '../../../core/widgets/status_chip.dart';
import '../../auth/domain/current_user.dart';
import 'providers/dashboard_provider.dart';
import 'widgets/home_card.dart';

/// Role home (PHASE-2-FEATURES §9.2): a greeting header with my attendance today, my to-dos, then a card set per
/// business unit. The director's home is the company dashboard with quick links.
class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final user = ref.watch(currentUserProvider);
    if (user == null) return const SizedBox.shrink();
    final dashboard = ref.watch(dashboardProvider);
    final unread = dashboard.value?.me.unreadNotifications ?? 0;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.appTitle),
        actions: [
          const BusinessUnitSwitcher(),
          IconButton(
            key: const Key('home.bell'),
            tooltip: l10n.navNotifications,
            onPressed: () => context.push(AppDestination.notifications.path),
            icon: Badge(isLabelVisible: unread > 0, label: Text('$unread'), child: const Icon(Icons.notifications_outlined)),
          ),
          const ProfileAvatarButton(),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () => ref.refreshFuture(dashboardProvider.future),
        child: AsyncView(
          value: dashboard,
          onRetry: () => ref.invalidate(dashboardProvider),
          data: (d) => ListView(
            key: Key('home.${user.role.name}'),
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
            children: [
              _Hero(user: user, me: d.me),
              const SizedBox(height: 20),
              if (user.isDirector) ...[const _QuickLinks(), const SizedBox(height: 20)],
              _MySection(user: user, me: d.me),
              for (final bu in d.businessUnits) ...[const SizedBox(height: 24), _BusinessUnitSection(card: bu)],
            ],
          ),
        ),
      ),
    );
  }
}

/// Greeting banner: name, role, primary BU, today's date and my attendance today.
class _Hero extends StatelessWidget {
  const _Hero({required this.user, required this.me});

  final CurrentUser user;
  final DashboardMe me;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final onHero = scheme.onPrimary;
    final primaryBu = user.businessUnits.where((b) => b.isPrimary).firstOrNull ?? user.businessUnits.firstOrNull;
    final mark = me.myAttendanceToday;
    return Container(
      key: const Key('home.hero'),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: LinearGradient(
          colors: [scheme.primary, Color.lerp(scheme.primary, scheme.tertiary, 0.55)!],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(DateFormat('EEEE, d MMMM').format(DateTime.now()), style: theme.textTheme.labelLarge?.copyWith(color: onHero.withValues(alpha: 0.85))),
          const SizedBox(height: 4),
          Text(l10n.homeGreeting(user.firstName), style: theme.textTheme.headlineSmall?.copyWith(color: onHero)),
          const SizedBox(height: 2),
          Text(
            [roleLabel(l10n, user.role), user.empCode, if (primaryBu != null) primaryBu.name].join(' · '),
            style: theme.textTheme.bodyMedium?.copyWith(color: onHero.withValues(alpha: 0.9)),
          ),
          if (!user.isDirector) ...[
            const SizedBox(height: 14),
            Material(
              color: onHero.withValues(alpha: 0.14),
              borderRadius: BorderRadius.circular(14),
              child: InkWell(
                key: const Key('card.myAttendance'),
                borderRadius: BorderRadius.circular(14),
                onTap: () => context.go(AppDestination.attendance.path),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                  child: Row(
                    children: [
                      Icon(mark == null ? Icons.touch_app_outlined : Icons.how_to_reg, color: onHero),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(l10n.myAttendanceToday, style: theme.textTheme.labelMedium?.copyWith(color: onHero.withValues(alpha: 0.85))),
                            Text(
                              mark == null ? l10n.notMarked : l10n.attendanceStatus(mark.status),
                              style: theme.textTheme.titleMedium?.copyWith(color: onHero),
                            ),
                          ],
                        ),
                      ),
                      if (mark == null)
                        Text(l10n.tapToMark, style: theme.textTheme.labelLarge?.copyWith(color: onHero))
                      else
                        StatusChip(label: l10n.approvalState(mark.approvalState), tone: approvalStateTone(mark.approvalState)),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _MySection extends StatelessWidget {
  const _MySection({required this.user, required this.me});

  final CurrentUser user;
  final DashboardMe me;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final p = me.pendingApprovals;
    final cards = <Widget>[
      if (!user.isRm)
        HomeCard(
          key: const Key('card.approveAttendance'),
          icon: Icons.fact_check_outlined,
          title: l10n.attendanceToApprove,
          value: '${p.attendance + p.corrections}',
          alert: p.attendance + p.corrections > 0,
          onTap: () => context.go(AppDestination.attendance.path),
        ),
      HomeCard(
        key: const Key('card.approveLeave'),
        icon: Icons.event_note_outlined,
        title: l10n.leaveToApprove,
        value: '${p.leave}',
        alert: p.leave > 0,
        onTap: () => context.go(AppDestination.requests.path),
      ),
      if (!user.isRm)
        HomeCard(
          key: const Key('card.approveAllowances'),
          icon: Icons.currency_rupee,
          title: l10n.allowancesToApprove,
          value: '${p.allowances}',
          alert: p.allowances > 0,
          onTap: () => context.push(AppDestination.allowances.path),
        ),
      if (user.isRm)
        HomeCard(
          key: const Key('card.myTasks'),
          icon: Icons.task_alt,
          title: l10n.myOpenTasks,
          value: '${me.tasksOpen}',
          subtitle: me.tasksOverdue > 0 ? l10n.overdueCount(me.tasksOverdue) : null,
          alert: me.tasksOverdue > 0,
          tone: Tone.good,
          onTap: () => context.push(AppDestination.tasks.path),
        ),
    ];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionHeader(title: l10n.myToDo, icon: Icons.checklist_rtl),
        HomeCardGrid(cards: cards),
      ],
    );
  }
}

class _QuickLinks extends StatelessWidget {
  const _QuickLinks();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    Widget link(String key, IconData icon, String label, String path) =>
        ActionChip(key: Key('quick.$key'), avatar: Icon(icon, size: 18), label: Text(label), onPressed: () => context.push(path));
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: [
        link('report', Icons.table_chart_outlined, l10n.attendanceReport, AppDestination.reports.path),
        link('leave', Icons.event_note_outlined, l10n.leaveAndOdList, AppDestination.requests.path),
        link('allowances', Icons.currency_rupee, l10n.navAllowances, AppDestination.allowances.path),
        link('users', Icons.manage_accounts_outlined, l10n.navUsers, AppDestination.users.path),
      ],
    );
  }
}

class _BusinessUnitSection extends StatelessWidget {
  const _BusinessUnitSection({required this.card});

  final DashboardBusinessUnitsInner card;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final t = card.today;
    final p = card.pendingApprovals;
    final m = card.allowancesThisMonth;
    final pct = t.presentPct.toStringAsFixed(t.presentPct == t.presentPct.roundToDouble() ? 0 : 1);
    final code = card.businessUnit.code;
    return Column(
      key: Key('bu.$code'),
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionHeader(
          title: card.businessUnit.name,
          icon: Icons.business_outlined,
          trailing: StatusChip(label: '$code · ${l10n.peopleCount(t.headcount)}', tone: Tone.neutral),
        ),
        HomeCardGrid(
          cards: [
            HomeCard(
              key: Key('card.$code.today'),
              icon: Icons.groups_outlined,
              title: l10n.presentToday,
              value: '$pct%',
              subtitle: l10n.todaySummary(t.present + t.onDuty, t.absent, t.onLeave, t.notMarked),
              alert: t.notMarked > 0,
              tone: Tone.good,
              footer: AttendanceSplitBar(
                parts: [
                  (t.present + t.onDuty, Colors.green.shade500),
                  (t.halfDay, Colors.orange.shade400),
                  (t.onLeave + t.weeklyOff, scheme.primary.withValues(alpha: 0.6)),
                  (t.absent, scheme.error),
                  (t.notMarked, scheme.outlineVariant),
                ],
              ),
              onTap: () => context.push(AppDestination.reports.path),
            ),
            HomeCard(
              key: Key('card.$code.pending'),
              icon: Icons.pending_actions_outlined,
              title: l10n.pendingApprovals,
              value: '${p.attendance + p.corrections + p.leave + p.allowances}',
              subtitle: l10n.pendingBreakdown(p.attendance + p.corrections, p.leave, p.allowances),
              tone: Tone.warn,
            ),
            HomeCard(
              key: Key('card.$code.allowances'),
              icon: Icons.currency_rupee,
              title: l10n.allowancesThisMonth,
              value: formatRupees(m.approvedPaise),
              subtitle: l10n.requestedAmount(formatRupees(m.requestedPaise)),
              tone: Tone.neutral,
              onTap: () => context.push(AppDestination.allowances.path),
            ),
          ],
        ),
        if (card.tasksToday.isNotEmpty) ...[
          const SizedBox(height: 12),
          Card(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 6),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 8, 16, 4),
                    child: Text(l10n.tasksToday, style: theme.textTheme.titleSmall),
                  ),
                  for (final om in card.tasksToday)
                    ListTile(
                      dense: true,
                      leading: InitialsAvatar(name: om.om.name, radius: 15),
                      title: Text(om.om.name),
                      subtitle: Padding(
                        padding: const EdgeInsets.only(top: 6),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(4),
                          child: LinearProgressIndicator(minHeight: 6, value: om.total == 0 ? 0 : (om.completed + om.notDone) / om.total),
                        ),
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text('${om.completed}/${om.total}', style: theme.textTheme.titleSmall),
                          if (om.notDone > 0) ...[const SizedBox(width: 6), StatusChip(label: l10n.notDoneCount(om.notDone), tone: Tone.warn)],
                        ],
                      ),
                      onTap: () => context.push(AppDestination.tasks.path),
                    ),
                ],
              ),
            ),
          ),
        ],
      ],
    );
  }
}
