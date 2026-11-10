import 'package:flutter/material.dart';

import '../features/auth/domain/current_user.dart';
import 'l10n/app_localizations.dart';

/// Top-level screens of the role shell. Which ones a user sees in the navigation bar, and which other
/// screens they may open, depends on their role (PHASE-2-FEATURES §1, §11). Hiding destinations is
/// convenience only — the API enforces access.
enum AppDestination {
  home('/home', Icons.home_outlined, Icons.home),
  attendance('/attendance', Icons.fact_check_outlined, Icons.fact_check),
  requests('/requests', Icons.event_note_outlined, Icons.event_note),
  allowances('/allowances', Icons.currency_rupee_outlined, Icons.currency_rupee),
  payslips('/payslips', Icons.receipt_long_outlined, Icons.receipt_long),
  tasks('/tasks', Icons.task_alt_outlined, Icons.task_alt),
  reports('/reports', Icons.insights_outlined, Icons.insights),
  users('/users', Icons.manage_accounts_outlined, Icons.manage_accounts),
  employees('/employees', Icons.badge_outlined, Icons.badge),
  documents('/documents', Icons.verified_outlined, Icons.verified),
  roster('/roster', Icons.calendar_view_day_outlined, Icons.calendar_view_day),
  fleet('/fleet', Icons.local_shipping_outlined, Icons.local_shipping),
  notifications('/notifications', Icons.notifications_outlined, Icons.notifications),
  profile('/profile', Icons.person_outline, Icons.person),
  more('/more', Icons.menu, Icons.menu_open);

  const AppDestination(this.path, this.icon, this.selectedIcon);

  final String path;
  final IconData icon;
  final IconData selectedIcon;

  String label(AppLocalizations l10n) => switch (this) {
    home => l10n.navHome,
    attendance => l10n.navAttendance,
    requests => l10n.navLeave,
    allowances => l10n.navAllowances,
    payslips => l10n.navPayslips,
    tasks => l10n.navTasks,
    reports => l10n.navReports,
    users => l10n.navUsers,
    employees => l10n.navEmployees,
    documents => l10n.navDocuments,
    roster => l10n.navRoster,
    fleet => l10n.navFleet,
    notifications => l10n.navNotifications,
    profile => l10n.profileTitle,
    more => l10n.navMore,
  };
}

/// Navigation-bar destinations per role, in display order (max 5 for phone layouts).
List<AppDestination> destinationsFor(UserRole role) => switch (role) {
  UserRole.director => const [AppDestination.home, AppDestination.attendance, AppDestination.reports, AppDestination.users, AppDestination.more],
  UserRole.hr => const [AppDestination.home, AppDestination.attendance, AppDestination.requests, AppDestination.payslips, AppDestination.more],
  UserRole.operationalManager => const [AppDestination.home, AppDestination.attendance, AppDestination.requests, AppDestination.tasks, AppDestination.more],
  UserRole.regionalManager => const [AppDestination.home, AppDestination.attendance, AppDestination.requests, AppDestination.allowances, AppDestination.more],
};

/// Screens a role may open from the More menu or from links, beyond its navigation bar.
List<AppDestination> secondaryDestinationsFor(UserRole role) => switch (role) {
  UserRole.director => const [
    AppDestination.requests,
    AppDestination.allowances,
    AppDestination.payslips,
    AppDestination.tasks,
    AppDestination.employees,
    AppDestination.roster,
    AppDestination.fleet,
    AppDestination.notifications,
    AppDestination.profile,
  ],
  UserRole.hr => const [
    AppDestination.allowances,
    AppDestination.tasks,
    AppDestination.reports,
    AppDestination.employees,
    AppDestination.documents,
    AppDestination.roster,
    AppDestination.fleet,
    AppDestination.notifications,
    AppDestination.profile,
  ],
  UserRole.operationalManager => const [
    AppDestination.allowances,
    AppDestination.payslips,
    AppDestination.reports,
    AppDestination.employees,
    AppDestination.roster,
    AppDestination.fleet,
    AppDestination.notifications,
    AppDestination.profile,
  ],
  UserRole.regionalManager => const [
    AppDestination.tasks,
    AppDestination.payslips,
    AppDestination.reports,
    AppDestination.employees,
    AppDestination.roster,
    AppDestination.notifications,
    AppDestination.profile,
  ],
};

List<AppDestination> allowedDestinationsFor(UserRole role) => [...destinationsFor(role), ...secondaryDestinationsFor(role)];

String roleLabel(AppLocalizations l10n, UserRole role) => switch (role) {
  UserRole.director => l10n.roleDirector,
  UserRole.hr => l10n.roleHr,
  UserRole.operationalManager => l10n.roleOperationalManager,
  UserRole.regionalManager => l10n.roleRegionalManager,
};
