import 'package:hrms_api/hrms_api.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/api/api_providers.dart';
import '../../../core/api/guard.dart';

part 'roster_repository.g.dart';

/// Roster day view, duties, assignments, spares and copy (CLAUDE.md §8), plus fleet master data.
class RosterRepository {
  RosterRepository(this._api);

  final HrmsApi _api;

  RosterApi get _roster => _api.getRosterApi();
  FleetApi get _fleet => _api.getFleetApi();

  Future<RosterDay> day(String depotId, String date) => guardApi(() async => (await _roster.getRoster(depotId: depotId, date: date)).data!);

  Future<DutyItem> createDuty(DutyCreateBody body) => guardApi(() async => (await _roster.createDuty(dutyCreateBody: body)).data!);

  Future<DutyItem> updateDuty(String id, DutyUpdateBody body) => guardApi(() async => (await _roster.updateDuty(id: id, dutyUpdateBody: body)).data!);

  Future<AssignmentResult> assign(String dutyId, String employeeId, AssignmentRole role, {bool isSpare = false}) => guardApi(
    () async => (await _roster.assignToDuty(
      id: dutyId,
      assignmentCreateBody: AssignmentCreateBody(employeeId: employeeId, role: role, isSpare: isSpare),
    )).data!,
  );

  Future<void> unassign(String assignmentId) => guardApi(() => _roster.removeDutyAssignment(id: assignmentId));

  Future<List<SpareItem>> spares(String depotId, String date, {AssignmentRole role = AssignmentRole.DRIVER, String? dutyId}) =>
      guardApi(() async => (await _roster.getRosterSpares(depotId: depotId, date: date, role: role, dutyId: dutyId)).data!.items);

  Future<RosterCopyResult> copy(String depotId, String fromDate, String toDate, {int days = 1}) => guardApi(
    () async => (await _roster.copyRoster(
      rosterCopyBody: RosterCopyBody(depotId: depotId, fromDate: fromDate, toDate: toDate, days: days),
    )).data!,
  );

  Future<List<DutyTemplateItem>> templates(String depotId) => guardApi(() async => (await _fleet.listDutyTemplates(depotId: depotId)).data!.items);
  Future<List<VehicleItem>> vehicles(String depotId) => guardApi(() async => (await _fleet.listVehicles(depotId: depotId)).data!.items);
  Future<List<RouteItem>> routes(String depotId) => guardApi(() async => (await _fleet.listRoutes(depotId: depotId)).data!.items);

  Future<VehicleItem> createVehicle(VehicleCreateBody body) => guardApi(() async => (await _fleet.createVehicle(vehicleCreateBody: body)).data!);
  Future<VehicleItem> updateVehicle(String id, VehicleUpdateBody body) =>
      guardApi(() async => (await _fleet.updateVehicle(id: id, vehicleUpdateBody: body)).data!);
  Future<RouteItem> createRoute(RouteCreateBody body) => guardApi(() async => (await _fleet.createRoute(routeCreateBody: body)).data!);
  Future<DutyTemplateItem> createTemplate(DutyTemplateCreateBody body) =>
      guardApi(() async => (await _fleet.createDutyTemplate(dutyTemplateCreateBody: body)).data!);
}

@Riverpod(keepAlive: true)
RosterRepository rosterRepository(Ref ref) => RosterRepository(ref.watch(hrmsApiProvider));
