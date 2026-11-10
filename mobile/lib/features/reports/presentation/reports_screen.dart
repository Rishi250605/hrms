import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hrms_api/hrms_api.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../app/l10n/app_localizations.dart';
import '../../../core/session.dart';
import '../../../core/widgets/async_view.dart';
import '../../../core/widgets/bu_switcher.dart';
import '../../../core/widgets/depot_selector.dart' show MonthStepper;
import '../../payslips/presentation/payslips_screen.dart' show monthLabel;
import '../data/reports_repository.dart';

part 'reports_screen.g.dart';

@riverpod
Future<AttendanceReport> attendanceReport(Ref ref, ReportFilter filter) => ref.watch(reportsRepositoryProvider).attendance(filter);

/// Colour per muster code (§9.1): P / A / HD / L / OD / WO / H.
Color? musterColor(String code) => switch (code.replaceAll(RegExp(r'[*!]$'), '')) {
  'P' => Colors.green.withValues(alpha: 0.25),
  'A' => Colors.red.withValues(alpha: 0.25),
  'HD' => Colors.orange.withValues(alpha: 0.25),
  'L' => Colors.blue.withValues(alpha: 0.2),
  'OD' => Colors.purple.withValues(alpha: 0.2),
  'WO' || 'H' => Colors.grey.withValues(alpha: 0.25),
  _ => null,
};

/// Attendance report (§9.1): monthly muster grid or per-employee summary, Excel / PDF download.
class ReportsScreen extends ConsumerStatefulWidget {
  const ReportsScreen({super.key});

  @override
  ConsumerState<ReportsScreen> createState() => _ReportsScreenState();
}

class _ReportsScreenState extends ConsumerState<ReportsScreen> {
  String _month = MonthStepper.current();
  ReportGroup? _group;
  bool _summary = false;
  bool _exporting = false;

  ReportFilter _filter(String? bu) {
    final start = DateTime.parse('$_month-01');
    final end = DateTime(start.year, start.month + 1, 0);
    String iso(DateTime d) => '${d.year}-${d.month.toString().padLeft(2, '0')}-${d.day.toString().padLeft(2, '0')}';
    return ReportFilter(from: iso(start), to: iso(end), businessUnitId: bu, group: _group);
  }

  Future<void> _export(ReportFilter f, String format) async {
    setState(() => _exporting = true);
    try {
      final file = await ref.read(reportsRepositoryProvider).export(f, format);
      await launchUrl(Uri.parse(file.url), mode: LaunchMode.externalApplication);
    } catch (e) {
      if (mounted) showFailure(context, e);
    } finally {
      if (mounted) setState(() => _exporting = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final filter = _filter(ref.watch(selectedBusinessUnitProvider));
    final report = ref.watch(attendanceReportProvider(filter));
    String groupLabel(ReportGroup? g) => switch (g) {
      null => l10n.everyone,
      ReportGroup.DRIVER => l10n.catDriver,
      ReportGroup.LOADMAN => l10n.catLoadman,
      ReportGroup.REGIONAL_MANAGER => l10n.roleRegionalManager,
      ReportGroup.OPERATIONAL_MANAGER => l10n.roleOperationalManager,
      ReportGroup.HR => l10n.roleHr,
    };
    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.attendanceReport),
        actions: [
          const BusinessUnitSwitcher(),
          PopupMenuButton<String>(
            key: const Key('report.download'),
            enabled: !_exporting,
            icon: _exporting ? const SizedBox.square(dimension: 20, child: CircularProgressIndicator(strokeWidth: 2)) : const Icon(Icons.download),
            tooltip: l10n.download,
            onSelected: (f) => _export(filter, f),
            itemBuilder: (_) => [
              PopupMenuItem(value: 'xlsx', key: const Key('report.xlsx'), child: Text(l10n.downloadExcel)),
              PopupMenuItem(value: 'pdf', key: const Key('report.pdf'), child: Text(l10n.downloadPdf)),
            ],
          ),
        ],
      ),
      body: Column(
        children: [
          Wrap(
            crossAxisAlignment: WrapCrossAlignment.center,
            spacing: 8,
            children: [
              MonthStepper(month: _month, label: monthLabel(_month), onChanged: (m) => setState(() => _month = m)),
              DropdownButton<ReportGroup?>(
                key: const Key('report.group'),
                value: _group,
                items: [
                  for (final g in <ReportGroup?>[null, ...ReportGroup.values]) DropdownMenuItem(value: g, child: Text(groupLabel(g))),
                ],
                onChanged: (g) => setState(() => _group = g),
              ),
              SegmentedButton<bool>(
                key: const Key('report.view'),
                segments: [
                  ButtonSegment(value: false, label: Text(l10n.muster)),
                  ButtonSegment(value: true, label: Text(l10n.summary)),
                ],
                selected: {_summary},
                onSelectionChanged: (s) => setState(() => _summary = s.first),
              ),
            ],
          ),
          const Divider(height: 1),
          Expanded(
            child: AsyncView(
              value: report,
              onRetry: () => ref.invalidate(attendanceReportProvider(filter)),
              data: (r) => r.rows.isEmpty
                  ? EmptyState(icon: Icons.table_chart_outlined, message: l10n.noReportRows)
                  : (_summary ? _SummaryTable(report: r) : _MusterGrid(report: r)),
            ),
          ),
        ],
      ),
    );
  }
}

class _MusterGrid extends StatelessWidget {
  const _MusterGrid({required this.report});

  final AttendanceReport report;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    const nameW = 150.0;
    const cellW = 34.0;
    const rowH = 36.0;
    Widget cell(String text, {Color? color, double w = cellW, bool bold = false, Alignment align = Alignment.center}) => Container(
      width: w,
      height: rowH,
      alignment: align,
      padding: const EdgeInsets.symmetric(horizontal: 4),
      decoration: BoxDecoration(
        color: color,
        border: Border.all(color: theme.dividerColor, width: 0.5),
      ),
      child: Text(
        text,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(fontSize: 12, fontWeight: bold ? FontWeight.w600 : null),
      ),
    );
    return SingleChildScrollView(
      key: const Key('report.muster'),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                cell('', w: nameW),
                for (final d in report.days) cell(d.substring(8), bold: true),
              ],
            ),
            for (final row in report.rows)
              Row(
                children: [
                  Tooltip(
                    message: row.employee.empCode,
                    child: cell(row.employee.name, w: nameW, align: Alignment.centerLeft),
                  ),
                  for (final c in row.codes) cell(c, color: musterColor(c)),
                ],
              ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Text(report.legend.map((l) => '${l.code} = ${l.label}').join('   '), style: theme.textTheme.bodySmall),
            ),
          ],
        ),
      ),
    );
  }
}

class _SummaryTable extends StatelessWidget {
  const _SummaryTable({required this.report});

  final AttendanceReport report;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return SingleChildScrollView(
      key: const Key('report.summary'),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
          columnSpacing: 16,
          columns: [
            DataColumn(label: Text(l10n.name)),
            DataColumn(label: Text(l10n.attPresentShort), numeric: true),
            DataColumn(label: Text(l10n.attAbsentShort), numeric: true),
            DataColumn(label: Text(l10n.attHalfDayShort), numeric: true),
            DataColumn(label: Text(l10n.attOnLeaveShort), numeric: true),
            DataColumn(label: Text(l10n.attOnDutyShort), numeric: true),
            DataColumn(label: Text(l10n.attWeeklyOffShort), numeric: true),
            DataColumn(label: Text(l10n.pendingApproval), numeric: true),
            DataColumn(label: Text(l10n.notMarked), numeric: true),
          ],
          rows: [
            for (final r in report.rows)
              DataRow(
                cells: [
                  DataCell(Text('${r.employee.name}\n${r.employee.empCode}')),
                  for (final v in [
                    r.summary.present,
                    r.summary.absent,
                    r.summary.halfDay,
                    r.summary.leave,
                    r.summary.onDuty,
                    r.summary.weeklyOff + r.summary.holiday,
                    r.summary.pending,
                    r.summary.notMarked,
                  ])
                    DataCell(Text('$v')),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
