import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hrms_app/app/destinations.dart';
import 'package:hrms_app/app/router.dart';
import 'package:hrms_app/features/auth/domain/current_user.dart';
import 'package:hrms_app/features/auth/domain/session_state.dart';

CurrentUser _user(UserRole role) => CurrentUser(id: 'u1', employeeId: 'e1', empCode: 'NLS001', name: 'Asha Patil', phone: '+919000000004', role: role);

AsyncValue<SessionState> _signedIn(UserRole role) => AsyncData(SessionState.signedIn(_user(role)));

void main() {
  group('sessionRedirect', () {
    test('unknown session goes to splash', () {
      expect(sessionRedirect(const AsyncLoading(), '/home'), '/splash');
      expect(sessionRedirect(const AsyncLoading(), '/splash'), isNull);
    });

    test('server error while restoring goes to splash (retry)', () {
      expect(sessionRedirect(AsyncError<SessionState>(Exception('x'), StackTrace.empty), '/login'), '/splash');
    });

    test('signed out goes to login', () {
      const out = AsyncData<SessionState>(SessionState.signedOut());
      expect(sessionRedirect(out, '/home'), '/login');
      expect(sessionRedirect(out, '/splash'), '/login');
      expect(sessionRedirect(out, '/login'), isNull);
    });

    test('signed in leaves splash/login for home', () {
      expect(sessionRedirect(_signedIn(UserRole.hr), '/login'), '/home');
      expect(sessionRedirect(_signedIn(UserRole.hr), '/splash'), '/home');
    });

    test('signed in user can only open their role destinations (§11)', () {
      final rm = _signedIn(UserRole.regionalManager);
      expect(sessionRedirect(rm, '/attendance'), isNull);
      expect(sessionRedirect(rm, '/allowances/new'), isNull);
      expect(sessionRedirect(rm, '/tasks'), isNull);
      expect(sessionRedirect(rm, '/users'), '/home');
      expect(sessionRedirect(rm, '/payslips/upload'), isNull, reason: 'route allowed; the screen and API are HR-only');
      expect(sessionRedirect(rm, '/documents'), '/home');

      final om = _signedIn(UserRole.operationalManager);
      expect(sessionRedirect(om, '/tasks/new'), isNull);
      expect(sessionRedirect(om, '/employees/abc'), isNull);
      expect(sessionRedirect(om, '/users/new'), '/home');

      final hr = _signedIn(UserRole.hr);
      expect(sessionRedirect(hr, '/documents'), isNull);
      expect(sessionRedirect(hr, '/employees/new'), isNull);
      expect(sessionRedirect(hr, '/users'), '/home');

      final director = _signedIn(UserRole.director);
      expect(sessionRedirect(director, '/users/new'), isNull);
      expect(sessionRedirect(director, '/reports'), isNull);
    });
  });

  group('destinationsFor', () {
    test('every role has home and more, and at most 5 tabs', () {
      for (final role in UserRole.values) {
        final d = destinationsFor(role);
        expect(d.first, AppDestination.home);
        expect(d.last, AppDestination.more);
        expect(d.length, lessThanOrEqualTo(5));
      }
    });

    test('user management is director only; document verification HR only', () {
      for (final role in UserRole.values) {
        expect(allowedDestinationsFor(role).contains(AppDestination.users), role == UserRole.director);
        expect(allowedDestinationsFor(role).contains(AppDestination.documents), role == UserRole.hr);
        expect(allowedDestinationsFor(role).contains(AppDestination.profile), isTrue);
      }
    });
  });
}
