import 'package:hrms_api/hrms_api.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/api/api_providers.dart';
import '../../../core/api/guard.dart';

part 'allowances_repository.g.dart';

/// Allowance requests (PHASE-2-FEATURES §6). Voice notes and receipts are uploaded first via
/// EmployeesRepository.upload (purpose VOICE_NOTE / RECEIPT) and referenced by key.
class AllowancesRepository {
  AllowancesRepository(this._api);

  final HrmsApi _api;

  AllowancesApi get _a => _api.getAllowancesApi();

  Future<List<AllowanceTypeItem>> types() => guardApi(() async => (await _a.listAllowanceTypes()).data!.items);

  /// [scope]: mine | team | approvals | all.
  Future<AllowancePage> list({required String scope, String? businessUnitId, String? cursor, RequestStatus? status}) =>
      guardApi(() async => (await _a.listAllowances(scope: scope, businessUnitId: businessUnitId, cursor: cursor, status: status)).data!);

  Future<List<AllowanceItem>> create(AllowanceCreateBody body) => guardApi(() async => (await _a.createAllowance(allowanceCreateBody: body)).data!.items);

  Future<AllowanceItem> approve(String id, {int? approvedAmountPaise, String? comment}) => guardApi(
    () async => (await _a.approveAllowance(
      id: id,
      allowanceApproveBody: AllowanceApproveBody(approvedAmountPaise: approvedAmountPaise, comment: comment),
    )).data!,
  );

  Future<AllowanceItem> reject(String id, String reason) => guardApi(
    () async => (await _a.rejectAllowance(
      id: id,
      rejectReasonBody: RejectReasonBody(reason: reason),
    )).data!,
  );

  Future<BatchApproveResult> approveBatch(String batchId) => guardApi(() async => (await _a.approveAllowanceBatch(batchId: batchId)).data!);

  Future<AllowanceFiles> files(String id) => guardApi(() async => (await _a.getAllowanceFiles(id: id)).data!);

  Future<AllowanceSummary> summary(String month, {String? businessUnitId}) =>
      guardApi(() async => (await _a.allowanceMonthlySummary(month: month, businessUnitId: businessUnitId)).data!);
}

@Riverpod(keepAlive: true)
AllowancesRepository allowancesRepository(Ref ref) => AllowancesRepository(ref.watch(hrmsApiProvider));
