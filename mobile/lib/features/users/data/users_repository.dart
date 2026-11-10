import 'package:hrms_api/hrms_api.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/api/api_providers.dart';
import '../../../core/api/guard.dart';

part 'users_repository.g.dart';

/// Director user management (PHASE-2-FEATURES §3): create logins, reset passwords, unlock, deactivate.
class UsersRepository {
  UsersRepository(this._api);

  final HrmsApi _api;

  UsersApi get _u => _api.getUsersApi();

  Future<UserList> list({String? q, Role? role, String? businessUnitId, bool includeInactive = true, String? cursor}) =>
      guardApi(() async => (await _u.listUsers(q: q, role: role, businessUnitId: businessUnitId, includeInactive: includeInactive, cursor: cursor)).data!);

  Future<UserItem> create(UserCreateBody body) => guardApi(() async => (await _u.createUser(userCreateBody: body)).data!);

  Future<UserItem> setActive(String id, bool active) => guardApi(
    () async => (await _u.updateUser(
      id: id,
      userUpdateBody: UserUpdateBody(isActive: active),
    )).data!,
  );

  Future<UserItem> resetPassword(String id, String password) => guardApi(
    () async => (await _u.resetUserPassword(
      id: id,
      resetPasswordBody: ResetPasswordBody(password: password),
    )).data!,
  );

  Future<UserItem> unlock(String id) => guardApi(() async => (await _u.unlockUser(id: id)).data!);
}

@Riverpod(keepAlive: true)
UsersRepository usersRepository(Ref ref) => UsersRepository(ref.watch(hrmsApiProvider));
