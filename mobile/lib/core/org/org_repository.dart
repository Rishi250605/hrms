import 'package:hrms_api/hrms_api.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../api/api_providers.dart';
import '../api/guard.dart';
import '../session.dart';

part 'org_repository.g.dart';

/// Business units and depots.
class OrgRepository {
  OrgRepository(this._api);

  final HrmsApi _api;

  Future<List<BusinessUnitItem>> businessUnits() => guardApi(() async => (await _api.getOrgApi().listBusinessUnits()).data!.items);

  Future<List<DepotItem>> depots({String? businessUnitId}) =>
      guardApi(() async => (await _api.getOrgApi().listDepots(businessUnitId: businessUnitId)).data!.items);

  Future<List<RegionItem>> regions() => guardApi(() async => (await _api.getOrgApi().listRegions()).data!.items);

  Future<RegionItem> createRegion({required String code, required String name}) =>
      guardApi(() async => (await _api.getOrgApi().createRegion(regionCreateBody: RegionCreateBody(code: code, name: name))).data!);

  Future<DepotItem> createDepot({required String regionId, required String businessUnitId, required String code, required String name, required String state}) =>
      guardApi(
        () async => (await _api.getOrgApi().createDepot(
          depotCreateBody: DepotCreateBody(regionId: regionId, businessUnitId: businessUnitId, code: code, name: name, state: state),
        )).data!,
      );
}

@Riverpod(keepAlive: true)
OrgRepository orgRepository(Ref ref) => OrgRepository(ref.watch(hrmsApiProvider));

/// Depots of the selected business unit (all of mine when none is selected).
@riverpod
Future<List<DepotItem>> depots(Ref ref) {
  ref.watch(currentUserProvider);
  return ref.watch(orgRepositoryProvider).depots(businessUnitId: ref.watch(selectedBusinessUnitProvider));
}

/// Every depot of my business units (no BU filter), e.g. for picking a new user's base depot.
@riverpod
Future<List<DepotItem>> allDepots(Ref ref) {
  ref.watch(currentUserProvider);
  return ref.watch(orgRepositoryProvider).depots();
}

@riverpod
Future<List<RegionItem>> regions(Ref ref) => ref.watch(orgRepositoryProvider).regions();
