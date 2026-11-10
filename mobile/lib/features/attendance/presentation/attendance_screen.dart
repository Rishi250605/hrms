import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hrms_api/hrms_api.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../app/l10n/app_localizations.dart';
import '../../../core/format.dart';
import '../../../core/session.dart';
import '../../../core/widgets/bu_switcher.dart';
import '../../auth/domain/current_user.dart';
import '../data/attendance_repository.dart';
import 'approvals_tab.dart';
import 'self_tab.dart';
import 'team_tab.dart';

part 'attendance_screen.g.dart';

@Riverpod(keepAlive: true)
class AttendanceDate extends _$AttendanceDate {
  @override
  String build() => todayIso();

  void set(String date) => state = date;
}

@riverpod
Future<TeamAttendanceDay> teamAttendance(Ref ref, String date) =>
    ref.watch(attendanceRepositoryProvider).team(date, businessUnitId: ref.watch(selectedBusinessUnitProvider));

/// My own marks of the last 31 days.
@riverpod
Future<List<AttendanceMarkItem>> myAttendance(Ref ref) {
  final today = todayIso();
  return ref.watch(attendanceRepositoryProvider).mine(addDaysIso(today, -31), today);
}

/// Self-marks and corrections waiting for my decision.
@riverpod
Future<({List<AttendanceMarkItem> marks, List<CorrectionItem> corrections})> attendanceApprovals(Ref ref) async {
  final repo = ref.watch(attendanceRepositoryProvider);
  final bu = ref.watch(selectedBusinessUnitProvider);
  final results = await Future.wait([repo.approvals(businessUnitId: bu), repo.corrections(scope: 'approvals', businessUnitId: bu)]);
  return (marks: results[0] as List<AttendanceMarkItem>, corrections: results[1] as List<CorrectionItem>);
}

enum AttendanceTab { team, mine, approvals }

/// Which tabs a role gets (PHASE-2-FEATURES §4): RMs mark their team and themselves; OM / HR mark
/// themselves and approve their reports; the director only approves (own attendance not tracked, §13.1).
List<AttendanceTab> attendanceTabsFor(UserRole role) => switch (role) {
  UserRole.regionalManager => const [AttendanceTab.team, AttendanceTab.mine],
  UserRole.operationalManager || UserRole.hr => const [AttendanceTab.mine, AttendanceTab.approvals],
  UserRole.director => const [AttendanceTab.approvals],
};

class AttendanceScreen extends ConsumerWidget {
  const AttendanceScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final user = ref.watch(currentUserProvider);
    if (user == null) return const SizedBox.shrink();
    final tabs = attendanceTabsFor(user.role);
    String label(AttendanceTab t) => switch (t) {
      AttendanceTab.team => l10n.tabTeam,
      AttendanceTab.mine => l10n.tabMyAttendance,
      AttendanceTab.approvals => l10n.tabApprovals,
    };
    Widget body(AttendanceTab t) => switch (t) {
      AttendanceTab.team => const TeamAttendanceTab(),
      AttendanceTab.mine => const SelfAttendanceTab(),
      AttendanceTab.approvals => const AttendanceApprovalsTab(),
    };
    return DefaultTabController(
      length: tabs.length,
      child: Scaffold(
        appBar: AppBar(
          title: Text(l10n.navAttendance),
          actions: const [BusinessUnitSwitcher()],
          bottom: tabs.length > 1
              ? TabBar(
                  tabs: [for (final t in tabs) Tab(key: Key('attendance.tab.${t.name}'), text: label(t))],
                )
              : null,
        ),
        body: tabs.length > 1 ? TabBarView(children: [for (final t in tabs) body(t)]) : body(tabs.single),
      ),
    );
  }
}
