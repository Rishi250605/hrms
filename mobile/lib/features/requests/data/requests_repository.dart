import 'package:hrms_api/hrms_api.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/api/api_providers.dart';
import '../../../core/api/guard.dart';

part 'requests_repository.g.dart';

/// Leave and OD requests (PHASE-2-FEATURES §5).
class RequestsRepository {
  RequestsRepository(this._api);

  final HrmsApi _api;

  LeaveApi get _leave => _api.getLeaveApi();

  /// [scope]: mine | team | approvals | all.
  Future<LeaveRequestPage> list({required String scope, String? businessUnitId, RequestStatus? status, String? cursor}) =>
      guardApi(() async => (await _leave.listLeaveRequests(scope: scope, businessUnitId: businessUnitId, status: status, cursor: cursor)).data!);

  Future<LeaveRequestItem> create(LeaveRequestCreateBody body) => guardApi(() async => (await _leave.createLeaveRequest(leaveRequestCreateBody: body)).data!);

  Future<LeaveRequestItem> approve(String id) => guardApi(() async => (await _leave.approveLeaveRequest(id: id)).data!);

  Future<LeaveRequestItem> reject(String id, String reason) => guardApi(
    () async => (await _leave.rejectLeaveRequest(
      id: id,
      rejectReasonBody: RejectReasonBody(reason: reason),
    )).data!,
  );

  Future<LeaveRequestItem> cancel(String id) => guardApi(() async => (await _leave.cancelLeaveRequest(id: id)).data!);

  Future<List<LeaveTypeItem>> leaveTypes() => guardApi(() async => (await _leave.listLeaveTypes()).data!.items);

  Future<LeaveBalanceList> balances(String employeeId) => guardApi(() async => (await _leave.getLeaveBalances(employeeId: employeeId)).data!);
}

@Riverpod(keepAlive: true)
RequestsRepository requestsRepository(Ref ref) => RequestsRepository(ref.watch(hrmsApiProvider));
