import 'package:hrms_api/hrms_api.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/format.dart';
import '../../data/roster_repository.dart';

part 'roster_providers.g.dart';

/// Business date shown on the roster screen (defaults to tomorrow: managers build the next day's roster).
@Riverpod(keepAlive: true)
class RosterDate extends _$RosterDate {
  @override
  String build() => addDaysIso(todayIso(), 1);

  void set(String date) => state = date;
}

@riverpod
Future<RosterDay> rosterDay(Ref ref, String depotId, String date) => ref.watch(rosterRepositoryProvider).day(depotId, date);

@riverpod
Future<List<SpareItem>> spares(Ref ref, String depotId, String date, String dutyId, AssignmentRole role) =>
    ref.watch(rosterRepositoryProvider).spares(depotId, date, role: role, dutyId: dutyId);

class FleetData {
  const FleetData({required this.templates, required this.vehicles, required this.routes});

  final List<DutyTemplateItem> templates;
  final List<VehicleItem> vehicles;
  final List<RouteItem> routes;
}

@riverpod
Future<FleetData> fleetData(Ref ref, String depotId) async {
  final repo = ref.watch(rosterRepositoryProvider);
  final results = await Future.wait([repo.templates(depotId), repo.vehicles(depotId), repo.routes(depotId)]);
  return FleetData(templates: results[0] as List<DutyTemplateItem>, vehicles: results[1] as List<VehicleItem>, routes: results[2] as List<RouteItem>);
}
