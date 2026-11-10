import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hrms_app/features/auth/domain/current_user.dart';

import '../support/fakes.dart';

void main() {
  testWidgets('My Profile (§3) from the app-bar avatar: employee ID, reporting-to with role, BU chips with the primary, sign out', (tester) async {
    final fakes = Fakes(user: omUser.copyWith(reportingToRole: UserRole.hr));
    await pumpApp(tester, fakes);

    await tester.tap(find.byKey(const Key('appbar.avatar')));
    await tester.pumpAndSettle();
    expect(find.byKey(const Key('profile')), findsOneWidget);
    expect(find.text('NLS002'), findsOneWidget);
    expect(find.text('Priya Nair (NLS001) · HR'), findsOneWidget);
    expect(find.text('NLS Enterprises (NLS) · primary'), findsOneWidget);
    expect(find.text('BMS Associates (BMS)'), findsOneWidget);
    expect(find.text('To change your password, contact your Director.'), findsOneWidget);

    await tester.ensureVisible(find.byKey(const Key('profile.signOut')));
    await tester.tap(find.byKey(const Key('profile.signOut')));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key('signOut.confirm')));
    await tester.pumpAndSettle();
    expect(fakes.auth.logoutCalls, 1);
    expect(find.byKey(const Key('login.empCode')), findsOneWidget);
  });

  testWidgets('the BU switcher filters the home dashboard and remembers the choice per user', (tester) async {
    final fakes = Fakes(user: omUser);
    await pumpApp(tester, fakes);
    expect(fakes.dashboard.requestedBusinessUnits.last, isNull);

    await tester.tap(find.byKey(const Key('buSwitcher')));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key('buSwitcher.BMS')).last);
    await tester.pumpAndSettle();
    expect(fakes.dashboard.requestedBusinessUnits.last, 'bu-bms');
    expect(fakes.preferences.values['bu.u-om'], 'bu-bms');
  });
}
