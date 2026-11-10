import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../features/allowances/presentation/allowance_form_screen.dart';
import '../features/allowances/presentation/allowances_screen.dart';
import '../features/attendance/presentation/attendance_screen.dart';
import '../features/auth/domain/session_state.dart';
import '../features/auth/presentation/login_screen.dart';
import '../features/auth/presentation/providers/session_controller.dart';
import '../features/auth/presentation/splash_screen.dart';
import '../features/documents/presentation/verification_queue_screen.dart';
import '../features/employees/presentation/employee_profile_screen.dart';
import '../features/employees/presentation/employees_screen.dart';
import '../features/employees/presentation/onboarding_wizard_screen.dart';
import '../features/home/presentation/home_screen.dart';
import '../features/notifications/presentation/notifications_screen.dart';
import '../features/payslips/presentation/payslip_upload_screen.dart';
import '../features/payslips/presentation/payslips_screen.dart';
import '../features/reports/presentation/reports_screen.dart';
import '../features/requests/presentation/correction_form_screen.dart';
import '../features/requests/presentation/leave_form_screen.dart';
import '../features/requests/presentation/requests_screen.dart';
import '../features/roster/presentation/fleet_screen.dart';
import '../features/roster/presentation/roster_screen.dart';
import '../features/settings/presentation/more_screen.dart';
import '../features/tasks/presentation/task_form_screen.dart';
import '../features/tasks/presentation/tasks_screen.dart';
import '../features/users/presentation/user_form_screen.dart';
import '../features/users/presentation/users_screen.dart';
import 'destinations.dart';
import 'role_shell.dart';

part 'router.g.dart';

abstract final class Routes {
  static const splash = '/splash';
  static const login = '/login';
  static const home = '/home';
  static String employee(String id) => '/employees/$id';
  static const newEmployee = '/employees/new';
  static const newLeave = '/requests/new';
  static const newCorrection = '/attendance/correction';
  static const newAllowance = '/allowances/new';
  static const uploadPayslips = '/payslips/upload';
  static const newTask = '/tasks/new';
  static const newUser = '/users/new';
}

/// Pure redirect rule (unit-tested):
///  - session unknown / server unreachable → splash
///  - signed out                            → login
///  - signed in                             → never splash/login, and only the screens allowed for the role
String? sessionRedirect(AsyncValue<SessionState> session, String location) {
  final value = session.value;
  if (session.hasError || value == null) {
    return location == Routes.splash ? null : Routes.splash;
  }
  switch (value) {
    case SignedOut():
      return location == Routes.login ? null : Routes.login;
    case SignedIn(:final user):
      if (location == Routes.splash || location == Routes.login) return Routes.home;
      final allowed = allowedDestinationsFor(user.role).any((d) => location == d.path || location.startsWith('${d.path}/'));
      return allowed ? null : Routes.home;
  }
}

Page<void> _page(Widget child) => NoTransitionPage(child: child);

@Riverpod(keepAlive: true)
GoRouter router(Ref ref) {
  final refresh = ValueNotifier<int>(0);
  ref.listen(sessionControllerProvider, (_, _) => refresh.value++);

  final router = GoRouter(
    initialLocation: Routes.splash,
    refreshListenable: refresh,
    redirect: (context, state) => sessionRedirect(ref.read(sessionControllerProvider), state.matchedLocation),
    routes: [
      GoRoute(path: Routes.splash, builder: (_, _) => const SplashScreen()),
      GoRoute(path: Routes.login, builder: (_, _) => const LoginScreen()),
      ShellRoute(
        builder: (context, state, child) => _ShellHost(location: state.matchedLocation, child: child),
        routes: [
          GoRoute(path: AppDestination.home.path, pageBuilder: (_, _) => _page(const HomeScreen())),
          GoRoute(
            path: AppDestination.attendance.path,
            pageBuilder: (_, _) => _page(const AttendanceScreen()),
            routes: [
              GoRoute(
                path: 'correction',
                builder: (_, state) => CorrectionFormScreen(
                  employeeId: state.uri.queryParameters['employeeId'],
                  employeeName: state.uri.queryParameters['employeeName'],
                  date: state.uri.queryParameters['date'],
                ),
              ),
            ],
          ),
          GoRoute(
            path: AppDestination.requests.path,
            pageBuilder: (_, _) => _page(const RequestsScreen()),
            routes: [
              GoRoute(
                path: 'new',
                builder: (_, state) =>
                    LeaveFormScreen(employeeId: state.uri.queryParameters['employeeId'], employeeName: state.uri.queryParameters['employeeName']),
              ),
            ],
          ),
          GoRoute(
            path: AppDestination.allowances.path,
            pageBuilder: (_, _) => _page(const AllowancesScreen()),
            routes: [GoRoute(path: 'new', builder: (_, _) => const AllowanceFormScreen())],
          ),
          GoRoute(
            path: AppDestination.payslips.path,
            pageBuilder: (_, state) => _page(PayslipsScreen(period: state.uri.queryParameters['period'])),
            routes: [GoRoute(path: 'upload', builder: (_, _) => const PayslipUploadScreen())],
          ),
          GoRoute(
            path: AppDestination.tasks.path,
            pageBuilder: (_, state) => _page(TasksScreen(openTaskId: state.uri.queryParameters['open'])),
            routes: [GoRoute(path: 'new', builder: (_, _) => const TaskFormScreen())],
          ),
          GoRoute(path: AppDestination.reports.path, pageBuilder: (_, _) => _page(const ReportsScreen())),
          GoRoute(
            path: AppDestination.users.path,
            pageBuilder: (_, _) => _page(const UsersScreen()),
            routes: [GoRoute(path: 'new', builder: (_, _) => const UserFormScreen())],
          ),
          GoRoute(
            path: AppDestination.employees.path,
            pageBuilder: (_, _) => _page(const EmployeesScreen()),
            routes: [
              GoRoute(path: 'new', builder: (_, _) => const OnboardingWizardScreen()),
              GoRoute(
                path: ':id',
                builder: (_, state) => EmployeeProfileScreen(employeeId: state.pathParameters['id']!),
              ),
            ],
          ),
          GoRoute(path: AppDestination.documents.path, pageBuilder: (_, _) => _page(const VerificationQueueScreen())),
          GoRoute(path: AppDestination.roster.path, pageBuilder: (_, _) => _page(const RosterScreen())),
          GoRoute(path: AppDestination.fleet.path, pageBuilder: (_, _) => _page(const FleetScreen())),
          GoRoute(path: AppDestination.notifications.path, pageBuilder: (_, _) => _page(const NotificationsScreen())),
          GoRoute(path: AppDestination.profile.path, pageBuilder: (_, _) => _page(const ProfileScreen())),
          GoRoute(path: AppDestination.more.path, pageBuilder: (_, _) => _page(const MoreScreen())),
        ],
      ),
    ],
  );
  ref.onDispose(() {
    router.dispose();
    refresh.dispose();
  });
  return router;
}

class _ShellHost extends ConsumerWidget {
  const _ShellHost({required this.location, required this.child});

  final String location;
  final Widget child;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final session = ref.watch(sessionControllerProvider).value;
    // The redirect guarantees a signed-in session here; this guard covers the frame before it runs.
    if (session is! SignedIn) return const SizedBox.shrink();
    return AppShell(user: session.user, location: location, child: child);
  }
}
