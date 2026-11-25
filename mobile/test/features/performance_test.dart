import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hrms_app/core/format.dart';
import 'package:hrms_app/features/performance/presentation/performance_screens.dart';

import '../support/fakes.dart';

void main() {
  test('weekStartIso is the Monday of the week; metric formatting', () {
    expect(weekStartIso('2026-11-25'), '2026-11-23'); // Wednesday
    expect(weekStartIso('2026-11-23'), '2026-11-23'); // Monday
    expect(weekStartIso('2026-11-29'), '2026-11-23'); // Sunday
    expect(formatMetric(4.5, 'km/l'), '4.5 km/l');
    expect(formatMetric(1500, null), '1,500');
    expect(formatMetric(null, 'count'), '—');
  });

  testWidgets('My Profile shows my latest rating and weekly values; the details list the history', (tester) async {
    final fakes = Fakes(user: omUser);
    fakes.performance.summaries['emp-om'] = performanceJson(
      'emp-om',
      'Arjun Mehta',
      ratings: [ratingJson(4, comment: 'Strong month'), ratingJson(2, comment: 'Slow start')],
      weeks: {
        '2026-11-16': {'MILEAGE': 4.5, 'EMPLOYEE_COUNT': 12},
      },
    );
    await pumpApp(tester, fakes);

    await tester.tap(find.byKey(const Key('appbar.avatar')));
    await tester.pumpAndSettle();
    await tester.ensureVisible(find.byKey(const Key('profile.performance')));
    expect(find.text('Strong month'), findsOneWidget);
    expect(find.text('Mileage: 4.5 km/l'), findsOneWidget);
    expect(find.text('Employee count: 12 count'), findsOneWidget);

    await tester.tap(find.byKey(const Key('profile.performance')));
    await tester.pumpAndSettle();
    expect(find.byKey(const Key('performance.latest')), findsOneWidget);
    expect(find.byKey(const Key('performance.week.2026-11-16')), findsOneWidget);
    await tester.scrollUntilVisible(find.text('Rating history'), 200);
    expect(find.textContaining('Slow start'), findsOneWidget);
    expect(find.byKey(const Key('performance.actions')), findsNothing); // cannot rate myself
  });

  testWidgets('the director rates an OM and enters weekly values', (tester) async {
    final fakes = Fakes(user: directorUser);
    fakes.performance.peopleJson = [
      {
        'person': person('emp-om', 'Arjun Mehta', code: 'NLS002', role: 'OPERATIONAL_MANAGER'),
        'businessUnit': nlsJson,
        'latestRating': null,
        'lastWeekStart': null,
        'canRate': true,
        'canEnterMetrics': true,
      },
    ];
    fakes.performance.summaries['emp-om'] = performanceJson('emp-om', 'Arjun Mehta', canRate: true, canEnterMetrics: true);
    await pumpApp(tester, fakes);

    await tester.tap(find.text('More'));
    await tester.pumpAndSettle();
    await tester.ensureVisible(find.byKey(const Key('more.performance')));
    await tester.tap(find.byKey(const Key('more.performance')));
    await tester.pumpAndSettle();
    expect(find.text('Not rated yet'), findsOneWidget);
    await tester.tap(find.byKey(const Key('performance.person.NLS002')));
    await tester.pumpAndSettle();

    await tester.tap(find.byKey(const Key('performance.actions')));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key('rate.star.4')));
    await tester.enterText(find.byKey(const Key('rate.comment')), 'Good work');
    await tester.tap(find.byKey(const Key('rate.save')));
    await tester.pumpAndSettle();
    expect(fakes.performance.rated, [('emp-om', 4, 'Good work')]);
    expect(find.text('Good work'), findsOneWidget);
    await tester.pump(const Duration(seconds: 6)); // let the "Rating saved" snackbar go
    await tester.pumpAndSettle();

    await tester.tap(find.byKey(const Key('performance.enterWeek')));
    await tester.pumpAndSettle();
    await tester.enterText(find.byKey(const Key('week.metric.MILEAGE')), '4.2');
    await tester.enterText(find.byKey(const Key('week.metric.MAINTENANCE')), '1500');
    await tester.ensureVisible(find.byKey(const Key('week.save')));
    await tester.tap(find.byKey(const Key('week.save')));
    await tester.pumpAndSettle();
    final put = fakes.performance.weeksPut.single;
    expect(put.$1, 'emp-om');
    expect(put.$2, weekStartIso(todayIso()));
    expect(put.$3, {'m-mileage': 4.2, 'm-maint': 1500});
  });
}
