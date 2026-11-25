import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:hrms_api/hrms_api.dart';
import 'package:intl/intl.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../app/l10n/app_localizations.dart';
import '../../../app/router.dart';
import '../../../core/format.dart';
import '../../../core/session.dart';
import '../../../core/widgets/async_view.dart';
import '../../../core/widgets/bu_switcher.dart';
import '../data/performance_repository.dart';

part 'performance_screens.g.dart';

@riverpod
Future<PerformanceSummary> performanceSummary(Ref ref, String employeeId) => ref.watch(performanceRepositoryProvider).summary(employeeId);

@riverpod
Future<List<PerformancePersonItem>> performancePeople(Ref ref) =>
    ref.watch(performanceRepositoryProvider).people(businessUnitId: ref.watch(selectedBusinessUnitProvider));

@riverpod
Future<List<PerformanceMetricItem>> performanceMetrics(Ref ref) => ref.watch(performanceRepositoryProvider).metrics();

final _number = NumberFormat.decimalPattern('en_IN');

/// "4.5 km/l", "12 count", "1,500".
String formatMetric(num? value, String? unit) => value == null ? '—' : [_number.format(value), if (unit != null && unit.isNotEmpty) unit].join(' ');

/// Monday of the week containing [iso].
String weekStartIso(String iso) {
  final d = parseIsoDate(iso);
  return isoDate(DateTime(d.year, d.month, d.day - (d.weekday - 1)));
}

class StarRating extends StatelessWidget {
  const StarRating({super.key, required this.rating, this.size = 22});

  final int rating;
  final double size;

  @override
  Widget build(BuildContext context) {
    final color = Colors.amber.shade700;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [for (var i = 1; i <= 5; i++) Icon(i <= rating ? Icons.star_rounded : Icons.star_outline_rounded, size: size, color: color)],
    );
  }
}

// ───────────────────────────── My Profile card ─────────────────────────────

/// My Profile: my latest rating and my latest weekly values; opens the full history.
class PerformanceCard extends ConsumerWidget {
  const PerformanceCard({super.key, required this.employeeId});

  final String employeeId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final summary = ref.watch(performanceSummaryProvider(employeeId));
    return Card(
      key: const Key('profile.performance'),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () => context.push(Routes.myPerformance),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: AsyncView(
            value: summary,
            onRetry: () => ref.invalidate(performanceSummaryProvider(employeeId)),
            data: (s) {
              final week = s.weeks.isEmpty ? null : s.weeks.first;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(child: Text(l10n.navPerformance, style: theme.textTheme.titleSmall)),
                      const Icon(Icons.chevron_right),
                    ],
                  ),
                  const SizedBox(height: 8),
                  if (s.latestRating == null)
                    Text(l10n.performanceNotRated, style: theme.textTheme.bodyMedium?.copyWith(color: theme.colorScheme.onSurfaceVariant))
                  else ...[
                    StarRating(rating: s.latestRating!.rating, size: 26),
                    if (s.latestRating!.comment != null) ...[const SizedBox(height: 4), Text(s.latestRating!.comment!)],
                  ],
                  if (week != null) ...[
                    const SizedBox(height: 12),
                    Text(l10n.performanceWeekOf(formatDate(week.weekStart)), style: theme.textTheme.labelMedium),
                    const SizedBox(height: 6),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: [
                        for (final v in week.values.where((v) => v.value != null)) Chip(label: Text('${v.name}: ${formatMetric(v.value, v.unit)}')),
                      ],
                    ),
                  ],
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

// ───────────────────────────── Detail ─────────────────────────────

/// One person's rating history and weekly values; HR / director rate, the director enters weekly values.
class PerformanceDetailScreen extends ConsumerWidget {
  const PerformanceDetailScreen({super.key, required this.employeeId});

  final String employeeId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final summary = ref.watch(performanceSummaryProvider(employeeId));
    final s = summary.value;
    return Scaffold(
      appBar: AppBar(title: Text(s == null ? l10n.navPerformance : s.person.name)),
      floatingActionButton: s == null || !(s.canRate || s.canEnterMetrics)
          ? null
          : FloatingActionButton.extended(
              key: const Key('performance.actions'),
              onPressed: () => _actions(context, ref, s),
              icon: const Icon(Icons.edit_outlined),
              label: Text(s.canRate ? l10n.performanceRate : l10n.performanceEnterWeek),
            ),
      body: RefreshIndicator(
        onRefresh: () => ref.refresh(performanceSummaryProvider(employeeId).future),
        child: AsyncView(
          value: summary,
          onRetry: () => ref.invalidate(performanceSummaryProvider(employeeId)),
          data: (s) => ListView(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 96),
            children: [
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('${s.person.empCode} · ${s.businessUnit.code}', style: theme.textTheme.bodySmall),
                      const SizedBox(height: 8),
                      if (s.latestRating == null)
                        Text(l10n.performanceNotRated)
                      else ...[
                        StarRating(key: const Key('performance.latest'), rating: s.latestRating!.rating, size: 32),
                        if (s.latestRating!.comment != null) ...[const SizedBox(height: 6), Text(s.latestRating!.comment!)],
                        const SizedBox(height: 4),
                        Text(
                          l10n.performanceRatedBy(s.latestRating!.ratedBy.name, formatDateTime(s.latestRating!.createdAt)),
                          style: theme.textTheme.bodySmall?.copyWith(color: theme.colorScheme.onSurfaceVariant),
                        ),
                      ],
                      if (s.canRate && s.canEnterMetrics) ...[
                        const SizedBox(height: 12),
                        OutlinedButton.icon(
                          key: const Key('performance.enterWeek'),
                          onPressed: () => showWeekSheet(context, s),
                          icon: const Icon(Icons.edit_calendar_outlined),
                          label: Text(l10n.performanceEnterWeek),
                        ),
                      ],
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Text(l10n.performanceWeekly, style: theme.textTheme.titleMedium),
              const SizedBox(height: 8),
              if (s.weeks.isEmpty)
                Text(l10n.performanceNoWeeks, style: theme.textTheme.bodyMedium?.copyWith(color: theme.colorScheme.onSurfaceVariant))
              else
                for (final w in s.weeks)
                  Card(
                    key: Key('performance.week.${w.weekStart}'),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                            child: Text(l10n.performanceWeekOf(formatDate(w.weekStart)), style: theme.textTheme.titleSmall),
                          ),
                          for (final v in w.values)
                            ListTile(
                              dense: true,
                              title: Text(v.name),
                              trailing: Text(formatMetric(v.value, v.unit), style: theme.textTheme.bodyLarge),
                            ),
                        ],
                      ),
                    ),
                  ),
              const SizedBox(height: 16),
              if (s.ratings.length > 1 || (s.ratings.isNotEmpty && s.latestRating == null)) ...[
                Text(l10n.performanceHistory, style: theme.textTheme.titleMedium),
                const SizedBox(height: 8),
                Card(
                  child: Column(
                    children: [
                      for (final r in s.ratings)
                        ListTile(
                          title: StarRating(rating: r.rating, size: 18),
                          subtitle: Text([if (r.comment != null) r.comment!, l10n.performanceRatedBy(r.ratedBy.name, formatDateTime(r.createdAt))].join('\n')),
                          isThreeLine: r.comment != null,
                        ),
                    ],
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  void _actions(BuildContext context, WidgetRef ref, PerformanceSummary s) {
    if (s.canRate) {
      showRateDialog(context, s);
    } else {
      showWeekSheet(context, s);
    }
  }
}

Future<void> showRateDialog(BuildContext context, PerformanceSummary s) =>
    showDialog<void>(context: context, builder: (_) => _RateDialog(summary: s));

class _RateDialog extends ConsumerStatefulWidget {
  const _RateDialog({required this.summary});

  final PerformanceSummary summary;

  @override
  ConsumerState<_RateDialog> createState() => _RateDialogState();
}

class _RateDialogState extends ConsumerState<_RateDialog> {
  int _rating = 0;
  final _comment = TextEditingController();
  bool _busy = false;

  @override
  void dispose() {
    _comment.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    final l10n = AppLocalizations.of(context);
    if (_rating == 0) {
      showMessage(context, l10n.performanceSelectRating, error: true);
      return;
    }
    setState(() => _busy = true);
    try {
      final id = widget.summary.person.employeeId;
      final text = _comment.text.trim();
      await ref.read(performanceRepositoryProvider).rate(id, _rating, text.isEmpty ? null : text);
      ref.invalidate(performanceSummaryProvider(id));
      ref.invalidate(performancePeopleProvider);
      if (mounted) {
        Navigator.pop(context);
        showMessage(context, l10n.performanceRated);
      }
    } catch (e) {
      if (mounted) {
        setState(() => _busy = false);
        showFailure(context, e);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return AlertDialog(
      title: Text(l10n.performanceRateTitle(widget.summary.person.name)),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              for (var i = 1; i <= 5; i++)
                IconButton(
                  key: Key('rate.star.$i'),
                  onPressed: _busy ? null : () => setState(() => _rating = i),
                  icon: Icon(i <= _rating ? Icons.star_rounded : Icons.star_outline_rounded, size: 36, color: Colors.amber.shade700),
                ),
            ],
          ),
          const SizedBox(height: 8),
          TextField(
            key: const Key('rate.comment'),
            controller: _comment,
            maxLength: 1000,
            minLines: 2,
            maxLines: 4,
            decoration: InputDecoration(labelText: l10n.performanceCommentOptional),
          ),
        ],
      ),
      actions: [
        TextButton(onPressed: _busy ? null : () => Navigator.pop(context), child: Text(l10n.cancel)),
        TextButton(key: const Key('rate.save'), onPressed: _busy ? null : _save, child: Text(l10n.save)),
      ],
    );
  }
}

Future<void> showWeekSheet(BuildContext context, PerformanceSummary s) => showModalBottomSheet<void>(
  context: context,
  isScrollControlled: true,
  showDragHandle: true,
  builder: (_) => _WeekSheet(summary: s),
);

class _WeekSheet extends ConsumerStatefulWidget {
  const _WeekSheet({required this.summary});

  final PerformanceSummary summary;

  @override
  ConsumerState<_WeekSheet> createState() => _WeekSheetState();
}

class _WeekSheetState extends ConsumerState<_WeekSheet> {
  final _form = GlobalKey<FormState>();
  late String _week = weekStartIso(todayIso());
  final _controllers = <String, TextEditingController>{};
  bool _busy = false;

  @override
  void dispose() {
    for (final c in _controllers.values) {
      c.dispose();
    }
    super.dispose();
  }

  num? _existing(String metricId) {
    for (final w in widget.summary.weeks) {
      if (w.weekStart != _week) continue;
      for (final v in w.values) {
        if (v.metricId == metricId) return v.value;
      }
    }
    return null;
  }

  void _load(List<PerformanceMetricItem> metrics) {
    for (final m in metrics) {
      final v = _existing(m.id);
      (_controllers[m.id] ??= TextEditingController()).text = v == null ? '' : v.toString().replaceFirst(RegExp(r'\.0$'), '');
    }
  }

  Future<void> _save(List<PerformanceMetricItem> metrics) async {
    if (!_form.currentState!.validate()) return;
    final l10n = AppLocalizations.of(context);
    setState(() => _busy = true);
    try {
      final values = <String, num?>{
        for (final m in metrics)
          if (_controllers[m.id]!.text.trim().isNotEmpty || _existing(m.id) != null) m.id: num.tryParse(_controllers[m.id]!.text.trim()),
      };
      if (values.isNotEmpty) {
        final id = widget.summary.person.employeeId;
        await ref.read(performanceRepositoryProvider).putWeek(id, _week, values);
        ref.invalidate(performanceSummaryProvider(id));
        ref.invalidate(performancePeopleProvider);
      }
      if (mounted) {
        Navigator.pop(context);
        showMessage(context, l10n.performanceWeekSaved);
      }
    } catch (e) {
      if (mounted) {
        setState(() => _busy = false);
        showFailure(context, e);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final metrics = ref.watch(performanceMetricsProvider);
    final thisWeek = weekStartIso(todayIso());
    final weeks = [for (var i = 0; i < 8; i++) addDaysIso(thisWeek, -7 * i)];
    return Padding(
      padding: EdgeInsets.fromLTRB(16, 0, 16, 16 + MediaQuery.viewInsetsOf(context).bottom),
      child: AsyncView(
        value: metrics,
        onRetry: () => ref.invalidate(performanceMetricsProvider),
        data: (all) {
          final active = all.where((m) => m.isActive).toList();
          if (active.any((m) => !_controllers.containsKey(m.id))) _load(active);
          return Form(
            key: _form,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('${l10n.performanceEnterWeek} · ${widget.summary.person.name}', style: Theme.of(context).textTheme.titleMedium),
                  const SizedBox(height: 12),
                  DropdownButtonFormField<String>(
                    key: const Key('week.select'),
                    initialValue: _week,
                    items: [for (final w in weeks) DropdownMenuItem(value: w, child: Text(l10n.performanceWeekOf(formatDate(w))))],
                    onChanged: _busy
                        ? null
                        : (w) => setState(() {
                            _week = w!;
                            _load(active);
                          }),
                  ),
                  const SizedBox(height: 12),
                  for (final m in active) ...[
                    TextFormField(
                      key: Key('week.metric.${m.code}'),
                      controller: _controllers[m.id],
                      keyboardType: const TextInputType.numberWithOptions(decimal: true),
                      inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[0-9.]'))],
                      decoration: InputDecoration(labelText: m.name, suffixText: m.unit),
                      validator: (v) {
                        final t = (v ?? '').trim();
                        if (t.isEmpty) return null;
                        final n = num.tryParse(t);
                        return n == null || n < 0 ? l10n.performanceInvalidNumber : null;
                      },
                    ),
                    const SizedBox(height: 12),
                  ],
                  FilledButton(key: const Key('week.save'), onPressed: _busy ? null : () => _save(active), child: Text(l10n.save)),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

// ───────────────────────────── HR / director list ─────────────────────────────

/// HR / director: RMs, OMs and HRs with their latest rating; the director also manages the metrics.
class PerformancePeopleScreen extends ConsumerWidget {
  const PerformancePeopleScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final user = ref.watch(currentUserProvider);
    final people = ref.watch(performancePeopleProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.navPerformance),
        actions: [
          if (user?.isDirector ?? false)
            IconButton(
              key: const Key('performance.metrics'),
              tooltip: l10n.performanceMetrics,
              icon: const Icon(Icons.tune),
              onPressed: () => context.push(Routes.performanceMetrics),
            ),
          const BusinessUnitSwitcher(),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () => ref.refresh(performancePeopleProvider.future),
        child: AsyncView(
          value: people,
          onRetry: () => ref.invalidate(performancePeopleProvider),
          data: (items) => items.isEmpty
              ? ListView(children: [EmptyState(icon: Icons.star_outline, message: l10n.performanceNoPeople)])
              : ListView.separated(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  itemCount: items.length,
                  separatorBuilder: (_, _) => const Divider(height: 1),
                  itemBuilder: (_, i) {
                    final p = items[i];
                    return ListTile(
                      key: Key('performance.person.${p.person.empCode}'),
                      title: Text(p.person.name),
                      subtitle: Text(
                        [
                          '${p.person.empCode} · ${p.businessUnit.code}',
                          if (p.lastWeekStart != null) l10n.performanceLastWeek(formatDate(p.lastWeekStart!)),
                        ].join('\n'),
                      ),
                      isThreeLine: p.lastWeekStart != null,
                      trailing: p.latestRating == null ? Text(l10n.performanceNotRated) : StarRating(rating: p.latestRating!.rating, size: 18),
                      onTap: () => context.push(Routes.performanceOf(p.person.employeeId)),
                    );
                  },
                ),
        ),
      ),
    );
  }
}

/// Director: add, rename and deactivate weekly metrics.
class PerformanceMetricsScreen extends ConsumerWidget {
  const PerformanceMetricsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final metrics = ref.watch(performanceMetricsProvider);
    return Scaffold(
      appBar: AppBar(title: Text(l10n.performanceMetrics)),
      floatingActionButton: FloatingActionButton.extended(
        key: const Key('metrics.add'),
        onPressed: () => _edit(context, ref, null),
        icon: const Icon(Icons.add),
        label: Text(l10n.performanceAddMetric),
      ),
      body: AsyncView(
        value: metrics,
        onRetry: () => ref.invalidate(performanceMetricsProvider),
        data: (items) => ListView(
          padding: const EdgeInsets.only(bottom: 96),
          children: [
            for (final m in items)
              SwitchListTile(
                key: Key('metric.${m.code}'),
                title: Text(m.name),
                subtitle: Text([m.code, if (m.unit != null) m.unit!].join(' · ')),
                value: m.isActive,
                secondary: IconButton(icon: const Icon(Icons.edit_outlined), onPressed: () => _edit(context, ref, m)),
                onChanged: (v) async {
                  try {
                    await ref.read(performanceRepositoryProvider).updateMetric(m.id, isActive: v);
                    ref.invalidate(performanceMetricsProvider);
                  } catch (e) {
                    if (context.mounted) showFailure(context, e);
                  }
                },
              ),
          ],
        ),
      ),
    );
  }

  Future<void> _edit(BuildContext context, WidgetRef ref, PerformanceMetricItem? m) async {
    final l10n = AppLocalizations.of(context);
    final code = TextEditingController();
    final name = TextEditingController(text: m?.name);
    final unit = TextEditingController(text: m?.unit);
    final form = GlobalKey<FormState>();
    final ok = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(m == null ? l10n.performanceAddMetric : m.name),
        content: Form(
          key: form,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (m == null)
                TextFormField(
                  key: const Key('metric.code'),
                  controller: code,
                  textCapitalization: TextCapitalization.characters,
                  inputFormatters: [FilteringTextInputFormatter.allow(RegExp('[A-Za-z0-9_]')), LengthLimitingTextInputFormatter(30)],
                  decoration: InputDecoration(labelText: l10n.performanceMetricCode),
                  validator: (v) => (v ?? '').trim().length < 2 ? l10n.required : null,
                ),
              TextFormField(
                key: const Key('metric.name'),
                controller: name,
                decoration: InputDecoration(labelText: l10n.performanceMetricName),
                validator: (v) => (v ?? '').trim().length < 2 ? l10n.required : null,
              ),
              TextFormField(key: const Key('metric.unit'), controller: unit, decoration: InputDecoration(labelText: l10n.performanceMetricUnit)),
            ],
          ),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx, false), child: Text(l10n.cancel)),
          TextButton(
            key: const Key('metric.save'),
            onPressed: () {
              if (form.currentState!.validate()) Navigator.pop(ctx, true);
            },
            child: Text(l10n.save),
          ),
        ],
      ),
    );
    if (ok != true) return;
    final repo = ref.read(performanceRepositoryProvider);
    final u = unit.text.trim();
    try {
      if (m == null) {
        await repo.createMetric(code.text.trim().toUpperCase(), name.text.trim(), u.isEmpty ? null : u);
      } else {
        await repo.updateMetric(m.id, name: name.text.trim(), unit: u.isEmpty ? null : u);
      }
      ref.invalidate(performanceMetricsProvider);
    } catch (e) {
      if (context.mounted) showFailure(context, e);
    }
  }
}
