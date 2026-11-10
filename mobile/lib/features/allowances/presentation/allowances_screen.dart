import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:hrms_api/hrms_api.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../app/l10n/app_localizations.dart';
import '../../../app/router.dart';
import '../../../core/format.dart';
import '../../../core/labels.dart';
import '../../../core/session.dart';
import '../../../core/widgets/async_view.dart';
import '../../../core/widgets/bu_switcher.dart';
import '../../../core/widgets/depot_selector.dart' show MonthStepper;
import '../../../core/widgets/status_chip.dart';
import '../../attendance/presentation/approvals_tab.dart' show askReason;
import '../../auth/domain/current_user.dart';
import '../../home/presentation/providers/dashboard_provider.dart';
import '../data/allowances_repository.dart';
import 'providers/allowances_providers.dart';
import 'widgets/voice_note.dart';

/// Tabs per role (§6.3, §11 Allowances).
List<String> allowanceTabsFor(UserRole role) => switch (role) {
  UserRole.regionalManager => const ['mine', 'team'],
  UserRole.operationalManager => const ['mine', 'team', 'approvals'],
  UserRole.hr => const ['approvals', 'all'],
  UserRole.director => const ['all'],
};

class AllowancesScreen extends ConsumerWidget {
  const AllowancesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final user = ref.watch(currentUserProvider);
    if (user == null) return const SizedBox.shrink();
    final tabs = allowanceTabsFor(user.role);
    final canRaise = user.isRm || user.isOm;
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
          title: Text(l10n.navAllowances),
          actions: const [BusinessUnitSwitcher()],
          bottom: tabs.length > 1
              ? TabBar(
                  tabs: [for (final t in tabs) Tab(key: Key('allowances.tab.$t'), text: label(t))],
                )
              : null,
        ),
        floatingActionButton: canRaise
            ? FloatingActionButton.extended(
                key: const Key('allowances.new'),
                onPressed: () => context.push(Routes.newAllowance),
                icon: const Icon(Icons.add),
                label: Text(l10n.newAllowance),
              )
            : null,
        body: tabs.length > 1 ? TabBarView(children: [for (final t in tabs) _AllowanceList(scope: t)]) : _AllowanceList(scope: tabs.single),
      ),
    );
  }
}

class _AllowanceList extends ConsumerWidget {
  const _AllowanceList({required this.scope});

  final String scope;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final page = ref.watch(allowancesProvider(scope));
    return RefreshIndicator(
      onRefresh: () => ref.refreshFuture(allowancesProvider(scope).future),
      child: AsyncView(
        value: page,
        onRetry: () => ref.invalidate(allowancesProvider(scope)),
        data: (p) {
          // Approvals are grouped by batch so a team submission is approved in one action (§6.3).
          final groups = <String, List<AllowanceItem>>{};
          for (final a in p.items) {
            groups.putIfAbsent(scope == 'approvals' ? a.batchId : a.id, () => []).add(a);
          }
          return ListView(
            padding: const EdgeInsets.only(bottom: 88),
            children: [
              if (scope == 'all') const _MonthlyTotals(),
              if (p.items.isEmpty) EmptyState(icon: Icons.currency_rupee, message: scope == 'approvals' ? l10n.inboxEmpty : l10n.noAllowances),
              for (final entry in groups.entries) _AllowanceGroup(items: entry.value, scope: scope),
            ],
          );
        },
      ),
    );
  }
}

class _AllowanceGroup extends ConsumerWidget {
  const _AllowanceGroup({required this.items, required this.scope});

  final List<AllowanceItem> items;
  final String scope;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final first = items.first;
    final batch = items.length > 1 && items.every((a) => a.canDecide);
    return Card(
      key: Key('allowance.group.${first.batchId}'),
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      child: Column(
        children: [
          if (items.length > 1)
            ListTile(
              dense: true,
              title: Text(l10n.batchTitle(first.raisedBy.name, items.length)),
              subtitle: Text('${first.allowanceType.name} · ${formatRupees(items.fold(0, (s, a) => s + a.requestedAmountPaise))}'),
              trailing: batch
                  ? TextButton(
                      key: Key('allowance.batchApprove.${first.batchId}'),
                      onPressed: () async {
                        try {
                          final r = await ref.read(allowancesRepositoryProvider).approveBatch(first.batchId);
                          ref.invalidate(allowancesProvider);
                          ref.invalidate(dashboardProvider);
                          if (context.mounted) showMessage(context, l10n.approvedCount(r.approved.length));
                        } catch (e) {
                          if (context.mounted) showFailure(context, e);
                        }
                      },
                      child: Text(l10n.approveAll(items.length)),
                    )
                  : null,
            ),
          for (final a in items)
            ListTile(
              key: Key('allowance.${a.id}'),
              title: Text(
                scope == 'mine' && a.beneficiary.employeeId == a.raisedBy.employeeId ? a.allowanceType.name : '${a.beneficiary.name} · ${a.allowanceType.name}',
              ),
              subtitle: Text(
                [
                  a.fromDate == a.toDate ? formatDate(a.fromDate) : '${formatDate(a.fromDate)} – ${formatDate(a.toDate)}',
                  if (a.hasVoiceNote) '🎤',
                  if (a.hasReceipt) '🧾',
                ].join(' · '),
              ),
              trailing: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(formatRupees(a.approvedAmountPaise ?? a.requestedAmountPaise), style: Theme.of(context).textTheme.titleSmall),
                  StatusChip(label: l10n.requestStatus(a.status), tone: requestTone(a.status)),
                ],
              ),
              onTap: () => showModalBottomSheet<void>(
                context: context,
                isScrollControlled: true,
                builder: (_) => AllowanceDetailSheet(item: a),
              ),
            ),
        ],
      ),
    );
  }
}

class _MonthlyTotals extends ConsumerStatefulWidget {
  const _MonthlyTotals();

  @override
  ConsumerState<_MonthlyTotals> createState() => _MonthlyTotalsState();
}

class _MonthlyTotalsState extends ConsumerState<_MonthlyTotals> {
  String _month = MonthStepper.current();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final summary = ref.watch(allowanceSummaryProvider(_month));
    return Card(
      key: const Key('allowances.totals'),
      margin: const EdgeInsets.all(12),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(child: Text(l10n.monthlyTotals, style: Theme.of(context).textTheme.titleSmall)),
                MonthStepper(month: _month, onChanged: (m) => setState(() => _month = m)),
              ],
            ),
            AsyncView(
              value: summary,
              onRetry: () => ref.invalidate(allowanceSummaryProvider(_month)),
              data: (s) => Column(
                children: [
                  for (final b in s.items)
                    ListTile(
                      dense: true,
                      contentPadding: EdgeInsets.zero,
                      title: Text(b.businessUnit.code),
                      subtitle: Text(l10n.requestsPending(b.requests, b.pending)),
                      trailing: Text('${formatRupees(b.approvedPaise)} / ${formatRupees(b.requestedPaise)}'),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Details, voice note playback, receipt, and approve (optionally a different amount) / reject.
class AllowanceDetailSheet extends ConsumerStatefulWidget {
  const AllowanceDetailSheet({super.key, required this.item});

  final AllowanceItem item;

  @override
  ConsumerState<AllowanceDetailSheet> createState() => _AllowanceDetailSheetState();
}

class _AllowanceDetailSheetState extends ConsumerState<AllowanceDetailSheet> {
  AllowanceFiles? _files;
  late final _amount = TextEditingController(
    text: (widget.item.requestedAmountPaise / 100).toStringAsFixed(widget.item.requestedAmountPaise % 100 == 0 ? 0 : 2),
  );
  final _comment = TextEditingController();
  bool _busy = false;
  String? _error;

  @override
  void initState() {
    super.initState();
    if (widget.item.hasVoiceNote || widget.item.hasReceipt) _loadFiles();
  }

  @override
  void dispose() {
    _amount.dispose();
    _comment.dispose();
    super.dispose();
  }

  Future<void> _loadFiles() async {
    try {
      final f = await ref.read(allowancesRepositoryProvider).files(widget.item.id);
      if (mounted) setState(() => _files = f);
    } catch (_) {}
  }

  Future<void> _decide(Future<Object?> Function() action, String done) async {
    setState(() => _busy = true);
    try {
      await action();
      ref.invalidate(allowancesProvider);
      ref.invalidate(dashboardProvider);
      if (mounted) {
        Navigator.pop(context);
        showMessage(context, done);
      }
    } catch (e) {
      if (mounted) {
        setState(() => _busy = false);
        showFailure(context, e);
      }
    }
  }

  Future<void> _approve() async {
    final l10n = AppLocalizations.of(context);
    final paise = parseRupees(_amount.text);
    if (paise == null) return setState(() => _error = l10n.amountInvalid);
    final changed = paise != widget.item.requestedAmountPaise;
    if (changed && _comment.text.trim().isEmpty) return setState(() => _error = l10n.commentForChangedAmount);
    await _decide(
      () => ref
          .read(allowancesRepositoryProvider)
          .approve(widget.item.id, approvedAmountPaise: changed ? paise : null, comment: _comment.text.trim().isEmpty ? null : _comment.text.trim()),
      l10n.approvedMessage,
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final a = widget.item;
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.fromLTRB(16, 16, 16, 16 + MediaQuery.viewInsetsOf(context).bottom),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(child: Text('${a.allowanceType.name} · ${a.beneficiary.name}', style: theme.textTheme.titleMedium)),
                  StatusChip(label: l10n.requestStatus(a.status), tone: requestTone(a.status)),
                ],
              ),
              const SizedBox(height: 8),
              Text('${l10n.requestedAmountLabel}: ${formatRupees(a.requestedAmountPaise)}'),
              if (a.approvedAmountPaise != null)
                Text('${l10n.approvedAmountLabel}: ${formatRupees(a.approvedAmountPaise!)}', key: const Key('allowance.approvedAmount')),
              Text('${l10n.dates}: ${formatDate(a.fromDate)}${a.toDate != a.fromDate ? ' – ${formatDate(a.toDate)}' : ''}'),
              Text('${l10n.raisedByLabel}: ${a.raisedBy.name} · ${a.businessUnit.code}'),
              if (a.approver != null) Text('${l10n.approver}: ${a.approver!.name}'),
              if (a.comment != null) Padding(padding: const EdgeInsets.only(top: 8), child: Text(a.comment!)),
              if (a.decisionComment != null) Text('${l10n.comment}: ${a.decisionComment}'),
              if (a.rejectionReason != null) Text(l10n.rejectedBecause(a.rejectionReason!), style: TextStyle(color: theme.colorScheme.error)),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                children: [
                  if (_files?.voiceNote != null) VoiceNotePlayer(url: _files!.voiceNote!.url),
                  if (_files?.receipt != null)
                    OutlinedButton.icon(
                      onPressed: () => launchUrl(Uri.parse(_files!.receipt!.url), mode: LaunchMode.externalApplication),
                      icon: const Icon(Icons.receipt_long_outlined),
                      label: Text(l10n.viewReceipt),
                    ),
                ],
              ),
              if (a.canDecide) ...[
                const Divider(height: 24),
                TextField(
                  key: const Key('allowance.amount'),
                  controller: _amount,
                  keyboardType: const TextInputType.numberWithOptions(decimal: true),
                  decoration: InputDecoration(labelText: l10n.amountToApprove, prefixText: '₹ '),
                ),
                TextField(
                  key: const Key('allowance.comment'),
                  controller: _comment,
                  decoration: InputDecoration(labelText: l10n.comment),
                ),
                if (_error != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Text(_error!, style: TextStyle(color: theme.colorScheme.error)),
                  ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    OutlinedButton(
                      key: const Key('allowance.reject'),
                      onPressed: _busy
                          ? null
                          : () async {
                              final reason = await askReason(context);
                              if (reason != null) await _decide(() => ref.read(allowancesRepositoryProvider).reject(a.id, reason), l10n.rejectedMessage);
                            },
                      child: Text(l10n.reject),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: FilledButton(key: const Key('allowance.approve'), onPressed: _busy ? null : _approve, child: Text(l10n.approve)),
                    ),
                  ],
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
