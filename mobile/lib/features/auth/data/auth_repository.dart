import 'package:hrms_api/hrms_api.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/api/api_providers.dart';
import '../../../core/api/auth_interceptor.dart';
import '../../../core/errors/api_failure.dart';
import '../../../core/storage/token_storage.dart';
import '../domain/current_user.dart';

part 'auth_repository.g.dart';

/// Login (employee code + password), session and profile calls. Translates transport errors into [ApiFailure].
class AuthRepository {
  AuthRepository(this._api, this._storage);

  final HrmsApi _api;
  final TokenStorage _storage;

  /// Signs in and stores the session tokens.
  Future<void> login(String empCode, String password) => _guard(() async {
    final res = await _api.getAuthApi().login(
      loginBody: LoginBody(empCode: empCode.trim().toUpperCase(), password: password),
      extra: AuthInterceptor.skipAuth().extra,
    );
    final pair = res.data!;
    await _storage.write(StoredTokens(accessToken: pair.accessToken, refreshToken: pair.refreshToken));
  });

  Future<bool> hasStoredSession() async => (await _storage.read()) != null;

  Future<CurrentUser> fetchCurrentUser() => _guard(() async {
    final me = (await _api.getUsersApi().getMe()).data!;
    return CurrentUser(
      id: me.id,
      employeeId: me.employeeId,
      empCode: me.empCode,
      name: me.name,
      phone: me.phone,
      email: me.email,
      role: mapRole(me.role),
      businessUnits: [for (final b in me.businessUnits) BuRef(id: b.id, code: b.code, name: b.name, isPrimary: b.isPrimary)],
      reportingToName: me.reportingTo?.name,
      reportingToCode: me.reportingTo?.empCode,
      reportingToRole: me.reportingTo?.role == null ? null : mapRole(me.reportingTo!.role!),
    );
  });

  /// Revokes the session on the server (best effort) and always clears local tokens.
  Future<void> logout() async {
    final tokens = await _storage.read();
    await _storage.clear();
    if (tokens == null) return;
    try {
      await _api.getAuthApi().logout(
        logoutBody: LogoutBody(refreshToken: tokens.refreshToken),
        extra: AuthInterceptor.skipAuth().extra,
      );
    } catch (_) {
      // Offline logout is fine: the refresh token expires server-side.
    }
  }

  Future<void> clearLocalSession() => _storage.clear();

  static UserRole mapRole(Role role) => switch (role) {
    Role.DIRECTOR => UserRole.director,
    Role.HR => UserRole.hr,
    Role.OPERATIONAL_MANAGER => UserRole.operationalManager,
    Role.REGIONAL_MANAGER => UserRole.regionalManager,
  };

  static Role apiRole(UserRole role) => switch (role) {
    UserRole.director => Role.DIRECTOR,
    UserRole.hr => Role.HR,
    UserRole.operationalManager => Role.OPERATIONAL_MANAGER,
    UserRole.regionalManager => Role.REGIONAL_MANAGER,
  };

  Future<T> _guard<T>(Future<T> Function() body) async {
    try {
      return await body();
    } catch (e) {
      throw ApiFailure.fromObject(e);
    }
  }
}

@Riverpod(keepAlive: true)
AuthRepository authRepository(Ref ref) => AuthRepository(ref.watch(hrmsApiProvider), ref.watch(tokenStorageProvider));
