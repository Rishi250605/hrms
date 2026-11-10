import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:hrms_api/hrms_api.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/api/api_providers.dart';
import '../../../core/api/guard.dart';

part 'employees_repository.g.dart';

/// Filters of the employee list.
class EmployeeFilter {
  const EmployeeFilter({this.q = '', this.compliance, this.depotId, this.businessUnitId, this.role, this.staffOnly, this.reportingToEmployeeId});

  final String q;
  final ComplianceOverall? compliance;
  final String? depotId;
  final String? businessUnitId;
  final Role? role;
  final bool? staffOnly;
  final String? reportingToEmployeeId;

  EmployeeFilter copyWith({
    String? q,
    ComplianceOverall? compliance,
    bool clearCompliance = false,
    String? depotId,
    String? businessUnitId,
    bool clearBusinessUnit = false,
  }) => EmployeeFilter(
    q: q ?? this.q,
    compliance: clearCompliance ? null : (compliance ?? this.compliance),
    depotId: depotId ?? this.depotId,
    businessUnitId: clearBusinessUnit ? null : (businessUnitId ?? this.businessUnitId),
    role: role,
    staffOnly: staffOnly,
    reportingToEmployeeId: reportingToEmployeeId,
  );

  @override
  bool operator ==(Object other) =>
      other is EmployeeFilter &&
      other.q == q &&
      other.compliance == compliance &&
      other.depotId == depotId &&
      other.businessUnitId == businessUnitId &&
      other.role == role &&
      other.staffOnly == staffOnly &&
      other.reportingToEmployeeId == reportingToEmployeeId;

  @override
  int get hashCode => Object.hash(q, compliance, depotId, businessUnitId, role, staffOnly, reportingToEmployeeId);
}

/// A file picked on the device, ready to upload.
class PickedUpload {
  const PickedUpload({required this.bytes, required this.contentType});

  final Uint8List bytes;
  final String contentType;
}

/// Employees, job history, documents and uploads (CLAUDE.md §8). Screens use this through providers.
class EmployeesRepository {
  EmployeesRepository(this._api, this._uploadDio);

  final HrmsApi _api;

  /// Plain Dio for PUTs to presigned storage URLs (not our API: no auth header).
  final Dio _uploadDio;

  EmployeesApi get _employees => _api.getEmployeesApi();
  DocumentsApi get _documents => _api.getDocumentsApi();

  Future<EmployeePage> list(EmployeeFilter filter, {String? cursor}) => guardApi(() async {
    final res = await _employees.listEmployees(
      q: filter.q.isEmpty ? null : filter.q,
      compliance: filter.compliance,
      depotId: filter.depotId,
      businessUnitId: filter.businessUnitId,
      role: filter.role,
      staffOnly: filter.staffOnly,
      reportingToEmployeeId: filter.reportingToEmployeeId,
      cursor: cursor,
    );
    return res.data!;
  });

  Future<EmployeeDetail> get(String id) => guardApi(() async => (await _employees.getEmployee(id: id)).data!);

  Future<EmployeeDetail> create(EmployeeCreateBody body) => guardApi(() async => (await _employees.createEmployee(employeeCreateBody: body)).data!);

  Future<EmployeeDetail> changeJob(String id, JobChangeBody body) =>
      guardApi(() async => (await _employees.changeEmployeeJob(id: id, jobChangeBody: body)).data!);

  Future<EmployeeDetail> exit(String id, ExitBody body) => guardApi(() async => (await _employees.exitEmployee(id: id, exitBody: body)).data!);

  Future<List<DocumentItem>> documents(String employeeId) => guardApi(() async => (await _employees.listEmployeeDocuments(id: employeeId)).data!.items);

  /// Presigns, uploads the bytes straight to storage, and returns the object key.
  /// [employeeId] is the subject for documents / photos; voice notes and receipts belong to the uploader (null).
  Future<String> upload(String? employeeId, PickedUpload file, PresignBodyPurposeEnum purpose) => guardApi(() async {
    final presign = (await _api.getDocumentsApi().presignUpload(
      presignBody: PresignBody(
        employeeId: employeeId,
        purpose: purpose,
        contentType: PresignBodyContentTypeEnum.values.firstWhere((c) => c.value == file.contentType),
        sizeBytes: file.bytes.length,
      ),
    )).data!;
    await _uploadDio.put<void>(
      presign.url,
      data: Stream.fromIterable([file.bytes]),
      options: Options(headers: {...presign.headers, Headers.contentLengthHeader: file.bytes.length}),
    );
    return presign.key;
  });

  Future<DocumentItem> createDocument(String employeeId, DocumentCreateBody body) =>
      guardApi(() async => (await _employees.createEmployeeDocument(id: employeeId, documentCreateBody: body)).data!);

  Future<DocumentPage> verificationQueue({String? cursor}) => guardApi(() async {
    return (await _documents.listDocuments(status: DocumentStatus.PENDING_VERIFICATION, cursor: cursor)).data!;
  });

  Future<List<DocumentWithEmployee>> expiring({int withinDays = 30}) =>
      guardApi(() async => (await _documents.listExpiringDocuments(withinDays: withinDays)).data!.items);

  Future<SignedUrlResponse> fileUrl(String documentId) => guardApi(() async => (await _documents.getDocumentFileUrl(id: documentId)).data!);

  Future<DocumentWithEmployee> verify(String documentId, {String? expiryDate}) => guardApi(
    () async => (await _documents.verifyDocument(
      id: documentId,
      documentVerifyBody: DocumentVerifyBody(expiryDate: expiryDate),
    )).data!,
  );

  Future<DocumentWithEmployee> reject(String documentId, String reason) => guardApi(
    () async => (await _documents.rejectDocument(
      id: documentId,
      documentRejectBody: DocumentRejectBody(reason: reason),
    )).data!,
  );

  Future<List<DepotItem>> depots() => guardApi(() async => (await _api.getOrgApi().listDepots()).data!.items);

  /// Logins of a role in a business unit (e.g. the RMs a new driver can report to).
  Future<List<UserItem>> managersOf(Role role, String businessUnitId) =>
      guardApi(() async => (await _api.getUsersApi().listUsers(role: role, businessUnitId: businessUnitId)).data!.items);

  /// Next free employee code for a business unit (e.g. NLS010).
  Future<String> nextEmpCode(String businessUnitId) => guardApi(() async => (await _employees.suggestEmpCode(businessUnitId: businessUnitId)).data!.empCode);
}

@Riverpod(keepAlive: true)
EmployeesRepository employeesRepository(Ref ref) => EmployeesRepository(ref.watch(hrmsApiProvider), Dio());
