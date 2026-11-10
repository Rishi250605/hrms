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
import '../../../core/widgets/depot_selector.dart';
import '../../../core/widgets/status_chip.dart';
import '../../home/presentation/providers/dashboard_provider.dart';
import '../data/offline/attendance_queue.dart';
import 'attendance_screen.dart';
import 'providers/attendance_sync.dart';
import 'widgets/sync_banner.dart';

/// Statuses an RM can set for a driver / loadman, in display order.
const kMarkable = [
  AttendanceStatus.PRESENT,
  AttendanceStatus.ABSENT,
  AttendanceStatus.HALF_DAY,
  AttendanceStatus.ON_LEAVE,
  AttendanceStatus.ON_DUTY,
  AttendanceStatus.WEEKLY_OFF,
  AttendanceStatus.HOLIDAY,
];

/// RM bulk marking of their drivers and loadmen (§4.1): everyone pre-filled from roster / leave, "all present",
/// change exceptions, submit once. Marks are queued on the device and synced, so it works offline.
class TeamAttendanceTab extends ConsumerStatefulWidget {
  const TeamAttendanceTab({super.key});

  @override
  ConsumerState<TeamAttendanceTab> createState() => _TeamAttendanceTabState();
}

class _TeamAttendanceTabState extends ConsumerState<TeamAttendanceTab> {
  /// employeeId → status chosen on screen (overrides everything else).
  final Map<String, AttendanceStatus> _edits = {};
  String? _key;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final date = ref.watch(attendanceDateProvider);
    final bu = ref.watch(selectedBusinessUnitProvider);
    final key = '$bu|$date';
    if (_key != key) {
      _key = key;
      _edits.clear();
    }
    final day = ref.watch(teamAttendanceProvider(date));
    final queued = ref.watch(queuedMarksProvider).value ?? const <QueuedMark>[];
    final queuedFor = {for (final m in queued.where((m) => m.date == date)) m.employeeId: m};

    return Column(
      children: [
        DateStepper(
          date: parseIsoDate(date),
          label: formatDate(date),
          firstDate: DateTime.now().subtract(const Duration(days: 31)),
          lastDate: DateTime.now(),
          onChanged: (d) => ref.read(attendanceDateProvider.notifier).set(isoDate(d)),
        ),
        const SyncBanner(),
        Expanded(
          child: AsyncView(
            value: day,
            onRetry: () => ref.invalidate(teamAttendanceProvider(date)),
            data: (d) {
              AttendanceStatus? current(TeamAttendanceRow r) {
                final edit = _edits[r.employee.id];
                if (edit != null) return edit;
                final q = queuedFor[r.employee.id];
                if (q != null && q.state == QueuedState.pending) return AttendanceStatus.values.firstWhere((s) => s.value == q.status);
                return r.mark?.status ?? r.suggestedStatus;
              }

              // Rows whose on-screen status differs from what the server (or the queue) already has.
              final toSubmit = d.rows.where((r) {
                final c = current(r);
                final q = queuedFor[r.employee.id];
                final saved = q != null && q.state == QueuedState.pending ? q.status : r.mark?.status.value;
                return c != null && c.value != saved;
              }).toList();

              return Column(
                children: [
                  if (!d.editable)
                    MaterialBanner(
                      key: const Key('attendance.closed'),
                      leading: const Icon(Icons.lock_clock),
                      content: Text(l10n.editWindowClosed),
                      actions: const [SizedBox.shrink()],
                    ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(12, 4, 12, 0),
                    child: Row(
                      children: [
                        Expanded(child: Text(l10n.teamAttendanceSummary(d.summary.marked, d.summary.employees))),
                        if (d.editable)
                          TextButton.icon(
                            key: const Key('attendance.allPresent'),
                            onPressed: () => setState(() {
                              for (final r in d.rows) {
                                if (r.mark == null && r.leave == null && !queuedFor.containsKey(r.employee.id)) {
                                  _edits[r.employee.id] = AttendanceStatus.PRESENT;
                                }
                              }
                            }),
                            icon: const Icon(Icons.done_all),
                            label: Text(l10n.allPresent),
                          ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: RefreshIndicator(
                      onRefresh: () async {
                        await ref.read(attendanceSyncProvider.notifier).sync();
                        await ref.refreshFuture(teamAttendanceProvider(date).future);
                      },
                      child: d.rows.isEmpty
                          ? ListView(
                              children: [EmptyState(icon: Icons.groups_outlined, message: l10n.noTeam)],
                            )
                          : ListView.separated(
                              key: const Key('attendance.list'),
                              padding: const EdgeInsets.only(bottom: 96),
                              itemCount: d.rows.length,
                              separatorBuilder: (_, _) => const Divider(height: 1),
                              itemBuilder: (context, i) {
                                final r = d.rows[i];
                                return _AttendanceTile(
                                  row: r,
                                  value: current(r),
                                  queued: queuedFor[r.employee.id],
                                  editable: d.editable,
                                  onChanged: (s) => setState(() => _edits[r.employee.id] = s),
                                  onCorrection: () => context.push(
                                    Uri(
                                      path: Routes.newCorrection,
                                      queryParameters: {'employeeId': r.employee.id, 'employeeName': r.employee.fullName, 'date': date},
                                    ).toString(),
                                  ),
                                );
                              },
                            ),
                    ),
                  ),
                  if (d.editable)
                    SafeArea(
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: FilledButton.icon(
                          key: const Key('attendance.submit'),
                          onPressed: toSubmit.isEmpty
                              ? null
                              : () async {
                                  await ref.read(attendanceSyncProvider.notifier).submit([
                                    for (final r in toSubmit)
                                      (
                                        employeeId: r.employee.id,
                                        employeeName: r.employee.fullName,
                                        businessUnitId: r.businessUnit.id,
                                        date: date,
                                        status: current(r)!,
                                        note: null,
                                      ),
                                  ]);
                                  setState(_edits.clear);
                                  ref.invalidate(teamAttendanceProvider(date));
                                  ref.invalidate(dashboardProvider);
                                  if (context.mounted) showMessage(context, l10n.attendanceSaved(toSubmit.length));
                                },
                          icon: const Icon(Icons.save_outlined),
                          label: Text(l10n.submitMarks(toSubmit.length)),
                        ),
                      ),
                    ),
                ],
              );
            },
          ),
        ),
      ],
    );
  }
}

class _AttendanceTile extends StatelessWidget {
  const _AttendanceTile({
    required this.row,
    required this.value,
    required this.queued,
    required this.editable,
    required this.onChanged,
    required this.onCorrection,
  });

  final TeamAttendanceRow row;
  final AttendanceStatus? value;
  final QueuedMark? queued;
  final bool editable;
  final ValueChanged<AttendanceStatus> onChanged;
  final VoidCallback onCorrection;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final r = row;
    final info = [
      r.employee.empCode,
      l10n.category(r.employee.category),
      for (final duty in r.duties) '${duty.startTime}–${duty.endTime}${duty.routeCode != null ? ' ${duty.routeCode}' : ''}',
    ].join(' · ');
    final leaveLabel = r.leave == null
        ? null
        : (r.leave!.kind == TeamAttendanceRowLeaveKindEnum.OD ? l10n.kindOd : '${l10n.onLeave}${r.leave!.code != null ? ' ${r.leave!.code}' : ''}');
    return Padding(
      key: Key('att.${r.employee.id}'),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(r.employee.fullName, style: Theme.of(context).textTheme.titleSmall),
                    Text(info, style: Theme.of(context).textTheme.bodySmall),
                  ],
                ),
              ),
              if (leaveLabel != null)
                Padding(
                  padding: const EdgeInsets.only(left: 4),
                  child: StatusChip(label: leaveLabel, tone: Tone.info),
                ),
              if (queued?.state == QueuedState.pending)
                Padding(
                  padding: const EdgeInsets.only(left: 4),
                  child: StatusChip(key: Key('att.pending.${r.employee.id}'), label: l10n.pendingSync, tone: Tone.warn, icon: Icons.cloud_upload_outlined),
                ),
              if (queued?.state == QueuedState.failed)
                Padding(
                  padding: const EdgeInsets.only(left: 4),
                  child: StatusChip(label: l10n.syncFailed, tone: Tone.bad, icon: Icons.error_outline),
                ),
              if (!editable) IconButton(tooltip: l10n.requestCorrection, onPressed: onCorrection, icon: const Icon(Icons.edit_calendar_outlined)),
            ],
          ),
          const SizedBox(height: 6),
          if (editable)
            Wrap(
              spacing: 6,
              runSpacing: 4,
              children: [
                for (final s in kMarkable)
                  ChoiceChip(
                    key: Key('att.${r.employee.id}.${s.value}'),
                    visualDensity: VisualDensity.compact,
                    label: Text(l10n.attendanceShort(s)),
                    tooltip: l10n.attendanceStatus(s),
                    selected: value == s,
                    onSelected: (_) => onChanged(s),
                  ),
              ],
            )
          else
            Text(value == null ? l10n.notMarked : l10n.attendanceStatus(value!)),
        ],
      ),
    );
  }
}
