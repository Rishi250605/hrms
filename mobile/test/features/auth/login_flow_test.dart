import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hrms_app/core/errors/api_failure.dart';

import '../../support/fakes.dart';

void main() {
  testWidgets('employee code + password login lands an RM on their shell; wrong password and lockout show clear messages', (tester) async {
    final fakes = Fakes(user: rmUser);
    fakes.auth.hasSession = false;
    fakes.auth.failures['NLS099'] = const ApiFailure(code: 'ACCOUNT_LOCKED', message: 'locked', statusCode: 423, details: {'minutes': 12});
    await pumpApp(tester, fakes);

    expect(find.byKey(const Key('login.logo')), findsOneWidget);

    // Malformed code is refused locally.
    await tester.enterText(find.byKey(const Key('login.empCode')), '12');
    await tester.enterText(find.byKey(const Key('login.password')), 'x');
    await tester.tap(find.byKey(const Key('login.submit')));
    await tester.pumpAndSettle();
    expect(find.text('Enter your employee ID, e.g. NLS001'), findsOneWidget);
    expect(fakes.auth.logins, isEmpty);

    // Wrong password.
    await tester.enterText(find.byKey(const Key('login.empCode')), 'nls003');
    await tester.enterText(find.byKey(const Key('login.password')), 'wrong');
    await tester.tap(find.byKey(const Key('login.submit')));
    await tester.pumpAndSettle();
    expect(find.text('Invalid employee ID or password'), findsOneWidget);

    // Locked account.
    await tester.enterText(find.byKey(const Key('login.empCode')), 'NLS099');
    await tester.tap(find.byKey(const Key('login.submit')));
    await tester.pumpAndSettle();
    expect(find.text('Account locked, try again in 12 minutes or contact your Director'), findsOneWidget);

    await tester.enterText(find.byKey(const Key('login.empCode')), 'nls003');
    await tester.enterText(find.byKey(const Key('login.password')), 'Secret@123');
    await tester.tap(find.byKey(const Key('login.submit')));
    await tester.pumpAndSettle();
    expect(fakes.auth.logins.last, 'NLS003');

    expect(find.text('Hello, Asha'), findsOneWidget);
    // The app-bar avatar opens My Profile (§3).
    expect(find.byKey(const Key('appbar.avatar')), findsOneWidget);
    expect(find.byKey(const Key('home.regionalManager')), findsOneWidget);
    for (final label in ['Home', 'Attendance', 'Leave & OD', 'Allowances', 'More']) {
      expect(find.descendant(of: find.byKey(const Key('shell.bottomNav')), matching: find.text(label)), findsOneWidget);
    }
    // Single-BU users get no BU switcher.
    expect(find.byKey(const Key('buSwitcher')), findsNothing);

    // More → profile and logout.
    await tester.tap(find.text('More'));
    await tester.pumpAndSettle();
    expect(find.byKey(const Key('more.tasks')), findsOneWidget);
    expect(find.byKey(const Key('more.users')), findsNothing);
    await tester.tap(find.byKey(const Key('more.header')));
    await tester.pumpAndSettle();
    expect(find.text('Arjun Mehta (NLS002)'), findsOneWidget);
    expect(find.text('NLS Enterprises (NLS) · primary'), findsOneWidget);
    await tester.pageBack();
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key('more.logout')));
    await tester.pumpAndSettle();
    expect(fakes.auth.logoutCalls, 0, reason: 'sign out asks first');
    await tester.tap(find.byKey(const Key('signOut.confirm')));
    await tester.pumpAndSettle();
    expect(fakes.auth.logoutCalls, 1);
    expect(find.byKey(const Key('login.empCode')), findsOneWidget);
  });

  testWidgets('a stored session restores straight into the director shell (navigation rail on tablets)', (tester) async {
    final fakes = Fakes(user: directorUser);
    fakes.dashboard.json = dashboardJson(cards: [buCardJson(), buCardJson(code: 'BMS', notMarked: 0, pendingAttendance: 0)]);
    await pumpApp(tester, fakes, size: const Size(1280, 800));

    expect(find.byKey(const Key('home.director')), findsOneWidget);
    expect(find.byKey(const Key('shell.rail')), findsOneWidget);
    for (final label in ['Attendance', 'Reports', 'Users']) {
      expect(find.descendant(of: find.byKey(const Key('shell.rail')), matching: find.text(label)), findsOneWidget);
    }
    expect(find.byKey(const Key('quick.users')), findsOneWidget);
    expect(find.byKey(const Key('bu.NLS')), findsOneWidget);
    expect(find.descendant(of: find.byKey(const Key('card.NLS.allowances')), matching: find.text('₹2,500')), findsOneWidget);
    await tester.scrollUntilVisible(find.byKey(const Key('bu.BMS')), 300, scrollable: find.descendant(of: find.byKey(const Key('home.director')), matching: find.byType(Scrollable)).first);
    expect(find.byKey(const Key('bu.BMS')), findsOneWidget);
  });
}
