import 'package:freezed_annotation/freezed_annotation.dart';

part 'current_user.freezed.dart';

/// The four login roles (PHASE-2-FEATURES §1). Drivers and loadmen are records, not users.
enum UserRole { director, hr, operationalManager, regionalManager }

/// A business unit the user belongs to (the director belongs to all, implicitly).
@freezed
abstract class BuRef with _$BuRef {
  const factory BuRef({required String id, required String code, required String name, @Default(false) bool isPrimary}) = _BuRef;
}

/// The signed-in manager as returned by `GET /me`.
@freezed
abstract class CurrentUser with _$CurrentUser {
  const CurrentUser._();

  const factory CurrentUser({
    required String id,
    required String employeeId,
    required String empCode,
    required String name,
    required String phone,
    String? email,
    required UserRole role,
    @Default(<BuRef>[]) List<BuRef> businessUnits,
    String? reportingToName,
    String? reportingToCode,
    UserRole? reportingToRole,
  }) = _CurrentUser;

  bool get isDirector => role == UserRole.director;
  bool get isHr => role == UserRole.hr;
  bool get isOm => role == UserRole.operationalManager;
  bool get isRm => role == UserRole.regionalManager;

  /// HR and the director see everything in their business units.
  bool get seesAll => isDirector || isHr;

  String get firstName => name.split(' ').first;
}
