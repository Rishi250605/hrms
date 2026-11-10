import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:hrms_api/hrms_api.dart';
import 'package:intl/intl.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../app/l10n/app_localizations.dart';
import '../../../app/router.dart';
import '../../../core/format.dart';
import '../../../core/labels.dart';
import '../../../core/session.dart';
import '../../../core/widgets/async_view.dart';
import '../../../core/widgets/bu_switcher.dart';
import '../../../core/widgets/depot_selector.dart' show MonthStepper;
import '../data/payslips_repository.dart';

part 'payslips_screen.g.dart';

@riverpod
Future<PayslipPage> payslips(Ref ref, String scope, String period) =>
    ref.watch(payslipsRepositoryProvider).list(scope: scope, period: period, businessUnitId: scope == 'mine' ? null : ref.watch(selectedBusinessUnitProvider));

String monthLabel(String period) => DateFormat('MMMM yyyy').format(DateTime.parse('$period-01'));

/// Opens a payslip PDF via a short-lived signed URL (the device's PDF viewer; download / share from there).
Future<void> openPayslip(BuildContext context, WidgetRef ref, String id, {int? version}) async {
  try {
    final url = await ref.read(payslipsRepositoryProvider).download(id, version: version);
    await launchUrl(Uri.parse(url.url), mode: LaunchMode.externalApplication);
  } catch (e) {
    if (context.mounted) showFailure(context, e);
  }
}

/// Payslips (§7.3): month picker, my payslip, my team (RM: drivers / loadmen; OM: RMs), all (HR / director).
class PayslipsScreen extends ConsumerStatefulWidget {
  const PayslipsScreen({super.key, this.period});

  final String? period;

  @override
  ConsumerState<PayslipsScreen> createState() => _PayslipsScreenState();
}

class _PayslipsScreenState extends ConsumerState<PayslipsScreen> {
  late String _period = widget.period ?? MonthStepper.shift(MonthStepper.current(), -1);
  final _search = TextEditingController();
  String _q = '';

  @override
  void dispose() {
    _search.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final user = ref.watch(currentUserProvider);
    if (user == null) return const SizedBox.shrink();
    final otherScope = user.seesAll ? 'all' : 'team';
    final mine = user.isDirector ? null : ref.watch(payslipsProvider('mine', _period));
    final others = ref.watch(payslipsProvider(otherScope, _period));
    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.navPayslips),
        actions: [
          const BusinessUnitSwitcher(),
          if (user.isHr)
            IconButton(
              key: const Key('payslips.upload'),
              tooltip: l10n.uploadPayslips,
              onPressed: () => context.push(Routes.uploadPayslips),
              icon: const Icon(Icons.upload_file),
            ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(48),
          child: MonthStepper(month: _period, label: monthLabel(_period), onChanged: (m) => setState(() => _period = m)),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          ref.invalidate(payslipsProvider);
        },
        child: ListView(
          padding: const EdgeInsets.all(12),
          children: [
            if (mine != null) ...[
              Text(l10n.myPayslip, style: Theme.of(context).textTheme.titleSmall),
              AsyncView(
                value: mine,
                onRetry: () => ref.invalidate(payslipsProvider('mine', _period)),
                data: (p) => p.items.isEmpty
                    ? Card(
                        child: ListTile(
                          key: const Key('payslips.mine.none'),
                          leading: const Icon(Icons.hourglass_empty),
                          title: Text(l10n.payslipNotYet(monthLabel(_period))),
                        ),
                      )
                    : Card(
                        child: ListTile(
                          key: const Key('payslips.mine'),
                          leading: const Icon(Icons.picture_as_pdf_outlined),
                          title: Text(monthLabel(_period)),
                          subtitle: Text(l10n.uploadedOn(formatDateTime(p.items.first.uploadedAt))),
                          trailing: TextButton.icon(
                            onPressed: () => openPayslip(context, ref, p.items.first.id),
                            icon: const Icon(Icons.open_in_new),
                            label: Text(l10n.view),
                          ),
                        ),
                      ),
              ),
              const SizedBox(height: 16),
            ],
            Row(
              children: [
                Expanded(child: Text(user.seesAll ? l10n.allPayslips : l10n.myTeam, style: Theme.of(context).textTheme.titleSmall)),
                if (user.seesAll)
                  SizedBox(
                    width: 180,
                    child: TextField(
                      controller: _search,
                      decoration: InputDecoration(isDense: true, prefixIcon: const Icon(Icons.search), hintText: l10n.search),
                      onChanged: (v) => setState(() => _q = v.trim().toLowerCase()),
                    ),
                  ),
              ],
            ),
            AsyncView(
              value: others,
              onRetry: () => ref.invalidate(payslipsProvider(otherScope, _period)),
              data: (p) {
                final items = p.items
                    .where((s) => _q.isEmpty || s.employee.name.toLowerCase().contains(_q) || s.employee.empCode.toLowerCase().contains(_q))
                    .toList();
                if (items.isEmpty) {
                  return Padding(
                    padding: const EdgeInsets.all(24),
                    child: Text(l10n.noPayslips, textAlign: TextAlign.center),
                  );
                }
                return Column(
                  children: [
                    for (final s in items)
                      ListTile(
                        key: Key('payslip.${s.id}'),
                        title: Text(s.employee.name),
                        subtitle: Text(
                          '${s.employee.empCode} · ${l10n.personKind(s.employee.role, s.employee.category)} · ${s.businessUnit.code}${s.version > 1 ? ' · v${s.version}' : ''}',
                        ),
                        trailing: IconButton(tooltip: l10n.view, icon: const Icon(Icons.open_in_new), onPressed: () => openPayslip(context, ref, s.id)),
                        onLongPress: user.seesAll
                            ? () => showModalBottomSheet<void>(
                                context: context,
                                builder: (_) => _VersionsSheet(item: s),
                              )
                            : null,
                      ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _VersionsSheet extends ConsumerWidget {
  const _VersionsSheet({required this.item});

  final PayslipItem item;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    return FutureBuilder(
      future: ref.read(payslipsRepositoryProvider).versions(item.id),
      builder: (context, snap) => SafeArea(
        child: ListView(
          shrinkWrap: true,
          children: [
            ListTile(title: Text('${item.employee.name} · ${monthLabel(item.period)}'), subtitle: Text(l10n.versions)),
            if (!snap.hasData) const LinearProgressIndicator(),
            for (final v in snap.data ?? const <PayslipVersionListItemsInner>[])
              ListTile(
                title: Text('v${v.version} · ${v.originalName}'),
                subtitle: Text('${formatDateTime(v.uploadedAt)}${v.uploadedByName != null ? ' · ${v.uploadedByName}' : ''}'),
                trailing: IconButton(
                  icon: const Icon(Icons.open_in_new),
                  onPressed: () => openPayslip(context, ref, item.id, version: v.version),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
