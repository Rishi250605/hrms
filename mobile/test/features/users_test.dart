import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hrms_api/hrms_api.dart';
import 'package:hrms_app/features/users/data/users_repository.dart';

import '../support/fakes.dart';

class _FakeUsers with Unimplemented implements UsersRepository {
  final created = <UserCreateBody>[];

  @override
  Future<UserList> list({String? q, Role? role, String? businessUnitId, bool includeInactive = true, String? cursor}) async =>
      UserList.fromJson({'items': <Object>[], 'nextCursor': null});

  @override
  Future<UserItem> create(UserCreateBody body) async {
    created.add(body);
    throw UnimplementedError('stop after capturing the body');
  }
}

void main() {
  testWidgets('the director creates a login: the base depot of the primary business unit is sent', (tester) async {
    final fakes = Fakes(user: directorUser);
    final users = _FakeUsers();
    await pumpApp(tester, fakes, extra: [usersRepositoryProvider.overrideWithValue(users)]);

    await tester.tap(find.text('Users').last);
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key('users.new')));
    await tester.pumpAndSettle();

    await tester.tap(find.byType(DropdownButtonFormField<Role>));
    await tester.pumpAndSettle();
    await tester.tap(find.text('HR').last);
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key('user.bu.NLS')));
    await tester.pumpAndSettle();
    await tester.enterText(find.byKey(const Key('user.code')), 'NLS010');
    await tester.enterText(find.byKey(const Key('user.name')), 'Meera Iyer');
    await tester.enterText(find.byKey(const Key('user.phone')), '9876543210');
    await tester.enterText(find.byKey(const Key('user.password')), 'Secret@123');
    await tester.ensureVisible(find.byKey(const Key('user.save')));
    await tester.tap(find.byKey(const Key('user.save')));
    await tester.pumpAndSettle();

    final body = users.created.single;
    expect(body.depotId, 'd1'); // the only NLS depot, picked automatically
    expect(body.primaryBusinessUnitId, 'bu-nls');
    expect(body.role, Role.HR);
  });
}
