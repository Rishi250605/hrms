import 'package:hrms_api/hrms_api.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/api/api_providers.dart';
import '../../../core/api/guard.dart';
import 'offline/attendance_queue.dart';
import 'offline/offline_db.dart';

part 'attendance_repository.g.dart';

/// Attendance (PHASE-2-FEATURES §4): RM team marking, self-marking with approval, corrections.
class AttendanceRepository {
  AttendanceRepository(this._api);

  final HrmsApi _api;

  AttendanceApi get _a => _api.getAttendanceApi();

  Future<TeamAttendanceDay> team(String date, {String? businessUnitId}) =>
      guardApi(() async => (await _a.getTeamAttendance(date: date, businessUnitId: businessUnitId)).data!);

  Future<BulkAttendanceResult> bulk(List<BulkMark> marks) =>
      guardApi(() async => (await _a.markTeamAttendance(bulkAttendanceBody: BulkAttendanceBody(marks: marks))).data!);

  Future<AttendanceMarkItem> markSelf(String date, SelfMarkBodyStatusEnum status, {String? note}) => guardApi(
    () async => (await _a.markSelfAttendance(
      selfMarkBody: SelfMarkBody(date: date, status: status, note: note),
    )).data!,
  );

  Future<List<AttendanceMarkItem>> mine(String from, String to) => guardApi(() async => (await _a.listSelfAttendance(from: from, to: to)).data!.items);

  Future<List<AttendanceMarkItem>> approvals({String? businessUnitId, ApprovalState state = ApprovalState.PENDING_APPROVAL}) =>
      guardApi(() async => (await _a.listAttendanceApprovals(state: state, businessUnitId: businessUnitId)).data!.items);

  Future<AttendanceMarkItem> approve(String id) => guardApi(() async => (await _a.approveAttendance(id: id)).data!);

  Future<AttendanceMarkItem> reject(String id, String reason) => guardApi(
    () async => (await _a.rejectAttendance(
      id: id,
      rejectReasonBody: RejectReasonBody(reason: reason),
    )).data!,
  );

  Future<BulkApproveResult> approveMany(List<String> ids) =>
      guardApi(() async => (await _a.bulkApproveAttendance(bulkApproveBody: BulkApproveBody(ids: ids))).data!);

  Future<CorrectionItem> correction(CorrectionBody body) => guardApi(() async => (await _a.requestAttendanceCorrection(correctionBody: body)).data!);

  Future<List<CorrectionItem>> corrections({required String scope, String? businessUnitId}) =>
      guardApi(() async => (await _a.listAttendanceCorrections(scope: scope, businessUnitId: businessUnitId)).data!.items);

  Future<CorrectionItem> approveCorrection(String id) => guardApi(() async => (await _a.approveAttendanceCorrection(id: id)).data!);

  Future<CorrectionItem> rejectCorrection(String id, String reason) => guardApi(
    () async => (await _a.rejectAttendanceCorrection(
      id: id,
      rejectReasonBody: RejectReasonBody(reason: reason),
    )).data!,
  );
}

@Riverpod(keepAlive: true)
AttendanceRepository attendanceRepository(Ref ref) => AttendanceRepository(ref.watch(hrmsApiProvider));

@Riverpod(keepAlive: true)
OfflineDb offlineDb(Ref ref) {
  final db = OfflineDb.open();
  ref.onDispose(db.close);
  return db;
}

@Riverpod(keepAlive: true)
AttendanceQueue attendanceQueue(Ref ref) => DriftAttendanceQueue(ref.watch(offlineDbProvider));
