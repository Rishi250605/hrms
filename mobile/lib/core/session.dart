import 'dart:async';

import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../features/auth/domain/current_user.dart';
import '../features/auth/domain/session_state.dart';
import '../features/auth/presentation/providers/session_controller.dart';
import 'org/org_repository.dart';
import 'storage/preferences.dart';

part 'session.g.dart';

/// The signed-in manager, or null.
@riverpod
CurrentUser? currentUser(Ref ref) {
  final session = ref.watch(sessionControllerProvider).value;
  return session is SignedIn ? session.user : null;
}

/// Business units the user can switch between: their memberships, or every active BU for the director.
@Riverpod(keepAlive: true)
Future<List<BuRef>> businessUnitChoices(Ref ref) async {
  final user = ref.watch(currentUserProvider);
  if (user == null) return const [];
  if (!user.isDirector) return user.businessUnits;
  final all = await ref.watch(orgRepositoryProvider).businessUnits();
  return [for (final b in all.where((b) => b.isActive)) BuRef(id: b.id, code: b.code, name: b.name)];
}

/// The business unit the screens are filtered to (PHASE-2-FEATURES §2.4). `null` = all of mine.
/// Remembered per user on the device.
@Riverpod(keepAlive: true)
class SelectedBusinessUnit extends _$SelectedBusinessUnit {
  @override
  String? build() {
    final user = ref.watch(currentUserProvider);
    if (user == null) return null;
    // Single-BU users are always on their BU; others start on "All" until the saved choice loads.
    if (!user.isDirector && user.businessUnits.length == 1) return user.businessUnits.first.id;
    unawaited(_restore(user));
    return null;
  }

  Future<void> _restore(CurrentUser user) async {
    final saved = await ref.read(preferencesProvider).read('bu.${user.id}');
    if (saved == null || !ref.mounted) return;
    final choices = await ref.read(businessUnitChoicesProvider.future);
    if (ref.mounted && choices.any((b) => b.id == saved)) state = saved;
  }

  void select(String? businessUnitId) {
    state = businessUnitId;
    final user = ref.read(currentUserProvider);
    if (user != null) unawaited(ref.read(preferencesProvider).write('bu.${user.id}', businessUnitId));
  }
}

/// Depot the manager is working on (roster, fleet). Defaults to the first depot of the selected BU.
@Riverpod(keepAlive: true)
class SelectedDepot extends _$SelectedDepot {
  @override
  String? build() {
    final depots = ref.watch(depotsProvider).value ?? const [];
    return depots.isEmpty ? null : depots.first.id;
  }

  void select(String depotId) => state = depotId;
}
