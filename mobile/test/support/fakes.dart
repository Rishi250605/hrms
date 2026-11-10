import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/misc.dart' show Override;
import 'package:flutter_test/flutter_test.dart';
import 'package:hrms_api/hrms_api.dart';
import 'package:hrms_app/app/app.dart';
import 'package:hrms_app/core/errors/api_failure.dart';
import 'package:hrms_app/core/org/org_repository.dart';
import 'package:hrms_app/core/storage/preferences.dart';
import 'package:hrms_app/features/allowances/data/allowances_repository.dart';
import 'package:hrms_app/features/attendance/data/attendance_repository.dart';
import 'package:hrms_app/features/attendance/data/offline/attendance_queue.dart';
import 'package:hrms_app/features/auth/data/auth_repository.dart';
import 'package:hrms_app/features/auth/domain/current_user.dart';
import 'package:hrms_app/features/employees/data/employees_repository.dart';
import 'package:hrms_app/features/home/data/dashboard_repository.dart';
import 'package:hrms_app/features/payslips/data/payslips_repository.dart';
import 'package:hrms_app/features/requests/data/requests_repository.dart';
import 'package:hrms_app/features/roster/data/roster_repository.dart';
import 'package:hrms_app/features/tasks/data/tasks_repository.dart';

// ───────────────────────────── Users ─────────────────────────────

const nls = BuRef(id: 'bu-nls', code: 'NLS', name: 'NLS Enterprises', isPrimary: true);
const bms = BuRef(id: 'bu-bms', code: 'BMS', name: 'BMS Associates');

const rmUser = CurrentUser(
  id: 'u-rm',
  employeeId: 'emp-rm',
  empCode: 'NLS003',
  name: 'Asha Patil',
  phone: '+919000000004',
  role: UserRole.regionalManager,
  businessUnits: [nls],
  reportingToName: 'Arjun Mehta',
  reportingToCode: 'NLS002',
);

const omUser = CurrentUser(
  id: 'u-om',
  employeeId: 'emp-om',
  empCode: 'NLS002',
  name: 'Arjun Mehta',
  phone: '+919000000003',
  role: UserRole.operationalManager,
  businessUnits: [nls, bms],
  reportingToName: 'Priya Nair',
  reportingToCode: 'NLS001',
);

const hrUser = CurrentUser(
  id: 'u-hr',
  employeeId: 'emp-hr',
  empCode: 'NLS001',
  name: 'Priya Nair',
  phone: '+919000000002',
  role: UserRole.hr,
  businessUnits: [nls, bms],
  reportingToName: 'Director',
  reportingToCode: 'DIR001',
);

const directorUser = CurrentUser(id: 'u-dir', employeeId: 'emp-dir', empCode: 'DIR001', name: 'Director', phone: '+919000000001', role: UserRole.director);

// ───────────────────────────── JSON fixtures ─────────────────────────────

const depotJson = {'id': 'd1', 'code': 'PUN', 'name': 'Pune Depot'};
const nlsJson = {'id': 'bu-nls', 'code': 'NLS', 'name': 'NLS Enterprises'};

Map<String, dynamic> person(String id, String name, {String code = 'NLS009', String? role}) => {'employeeId': id, 'empCode': code, 'name': name, 'role': role};

Map<String, dynamic> buCardJson({String code = 'NLS', int notMarked = 2, int pendingAttendance = 1}) => {
  'businessUnit': {'id': 'bu-${code.toLowerCase()}', 'code': code, 'name': '$code Unit'},
  'today': {
    'headcount': 10,
    'present': 6,
    'absent': 1,
    'halfDay': 0,
    'onLeave': 1,
    'onDuty': 0,
    'weeklyOff': 0,
    'notMarked': notMarked,
    'pendingApproval': pendingAttendance,
    'presentPct': 66.7,
  },
  'pendingApprovals': {'attendance': pendingAttendance, 'corrections': 0, 'leave': 2, 'allowances': 3},
  'allowancesThisMonth': {'requestedPaise': 500000, 'approvedPaise': 250000},
  'tasksToday': [
    {'om': person('emp-om', 'Arjun Mehta', code: 'NLS002', role: 'OPERATIONAL_MANAGER'), 'total': 4, 'completed': 2, 'notDone': 1, 'pending': 1},
  ],
};

Map<String, dynamic> dashboardJson({List<Map<String, dynamic>>? cards, Map<String, dynamic>? myMark, int tasksOpen = 0, int tasksOverdue = 0, int unread = 0}) => {
  'date': '2026-11-09',
  'month': '2026-11',
  'businessUnits': cards ?? [buCardJson()],
  'me': {
    'pendingApprovals': {'attendance': 1, 'corrections': 0, 'leave': 2, 'allowances': 3},
    'tasksOpen': tasksOpen,
    'tasksOverdue': tasksOverdue,
    'myAttendanceToday': myMark,
    'unreadNotifications': unread,
  },
};

Map<String, dynamic> employeeListItemJson(String id, String name, {String compliance = 'OK', String category = 'DRIVER', String? role}) => {
  'id': id,
  'empCode': 'NLS-$id',
  'fullName': name,
  'phone': '+919000010001',
  'category': category,
  'role': role,
  'employmentType': 'PERMANENT',
  'status': 'ACTIVE',
  'designation': 'Driver',
  'depot': depotJson,
  'businessUnit': nlsJson,
  'reportingTo': person('emp-rm', 'Asha Patil', code: 'NLS003', role: 'REGIONAL_MANAGER'),
  'compliance': compliance,
};

Map<String, dynamic> employeeDetailJson(String id, String name, {String overall = 'MISSING', bool rosterable = false}) => {
  ...employeeListItemJson(id, name),
  'altPhone': null,
  'dob': null,
  'gender': null,
  'joiningDate': '2025-01-01',
  'exitDate': null,
  'exitReason': null,
  'contractorName': null,
  'uan': null,
  'esicNo': null,
  'aadhaarLast4': null,
  'panMasked': null,
  'hasBankDetails': false,
  'preferredChannel': 'WHATSAPP',
  'hasPhoto': false,
  'hasLogin': false,
  'businessUnits': [
    {...nlsJson, 'isPrimary': true},
  ],
  'currentJob': null,
  'jobs': [
    {
      'id': 'j1',
      'depot': depotJson,
      'designation': 'Driver',
      'grade': null,
      'reportingTo': person('emp-rm', 'Asha Patil', code: 'NLS003', role: 'REGIONAL_MANAGER'),
      'effectiveFrom': '2025-01-01',
      'effectiveTo': null,
      'changeReason': 'Joining',
    },
  ],
  'compliance': {
    'asOf': '2026-11-09',
    'overall': overall,
    'rosterable': rosterable,
    'items': [
      {'type': 'DRIVING_LICENCE', 'state': 'VALID', 'documentId': 'doc1', 'expiryDate': '2030-01-01'},
      {'type': 'MEDICAL_FITNESS', 'state': overall == 'OK' ? 'VALID' : 'MISSING', 'documentId': null, 'expiryDate': null},
    ],
  },
};

Map<String, dynamic> spareJson(String id, String name) => {
  'employee': {'id': id, 'empCode': 'E-$id', 'fullName': name, 'category': 'DRIVER', 'phone': '+919000010009'},
  'designation': 'Driver',
  'compliance': 'OK',
  'dutyMinutesLast7Days': 480,
  'dutiesOnDate': 0,
  'warnings': <Object>[],
};

Map<String, dynamic> dutyJson(String id, {List<Map<String, dynamic>> assignments = const []}) => {
  'id': id,
  'depotId': 'd1',
  'dutyDate': '2026-11-10',
  'status': 'PLANNED',
  'scheduledStart': '2026-11-10T00:30:00.000Z',
  'scheduledEnd': '2026-11-10T08:30:00.000Z',
  'startTime': '06:00',
  'endTime': '14:00',
  'crossesMidnight': false,
  'durationMinutes': 480,
  'route': {'id': 'r1', 'code': 'PUN-NSK', 'name': 'Pune – Nashik'},
  'vehicle': {'id': 'v1', 'regNo': 'MH12AB1001', 'type': 'Bus'},
  'template': null,
  'notes': null,
  'filled': assignments.any((a) => a['role'] == 'DRIVER'),
  'assignments': assignments,
};

Map<String, dynamic> allowanceJson(
  String id, {
  String batchId = 'b1',
  String beneficiary = 'Driver One',
  int amount = 30000,
  int? approved,
  String status = 'PENDING',
  bool canDecide = false,
  bool hasVoiceNote = false,
}) => {
  'id': id,
  'batchId': batchId,
  'beneficiary': person('emp-$id', beneficiary),
  'raisedBy': person('emp-rm', 'Asha Patil', code: 'NLS003', role: 'REGIONAL_MANAGER'),
  'businessUnit': nlsJson,
  'allowanceType': {'id': 'at-batta', 'code': 'BATTA', 'name': 'Batta'},
  'requestedAmountPaise': amount,
  'approvedAmountPaise': approved,
  'fromDate': '2026-11-09',
  'toDate': '2026-11-09',
  'comment': 'Night run',
  'hasVoiceNote': hasVoiceNote,
  'hasReceipt': false,
  'status': status,
  'approver': person('emp-om', 'Arjun Mehta', code: 'NLS002', role: 'OPERATIONAL_MANAGER'),
  'decidedAt': null,
  'decidedByName': null,
  'decisionComment': null,
  'rejectionReason': null,
  'canDecide': canDecide,
  'createdAt': '2026-11-09T05:00:00.000Z',
};

Map<String, dynamic> taskJson(String id, {String status = 'PENDING', bool overdue = false, bool canSubmit = false, bool canReopen = false, String title = 'Check tyres'}) => {
  'id': id,
  'groupId': 'g1',
  'date': '2026-11-09',
  'businessUnit': nlsJson,
  'title': title,
  'details': null,
  'priority': 'NORMAL',
  'allottedBy': person('emp-om', 'Arjun Mehta', code: 'NLS002', role: 'OPERATIONAL_MANAGER'),
  'assignee': person('emp-rm', 'Asha Patil', code: 'NLS003', role: 'REGIONAL_MANAGER'),
  'status': status,
  'overdue': overdue,
  'reason': null,
  'comment': null,
  'submittedAt': null,
  'reopenedAt': null,
  'reopenComment': null,
  'reopenCount': 0,
  'canSubmit': canSubmit,
  'canReopen': canReopen,
  'createdAt': '2026-11-09T05:00:00.000Z',
};

Map<String, dynamic> payslipJson(String id, String employeeId, String name, {String period = '2026-10', String? role, String category = 'DRIVER'}) => {
  'id': id,
  'employee': {'employeeId': employeeId, 'empCode': 'NLS-$employeeId', 'name': name, 'role': role, 'category': category},
  'businessUnit': nlsJson,
  'period': period,
  'version': 1,
  'sizeBytes': 12345,
  'uploadedAt': '2026-11-05T05:00:00.000Z',
};

Map<String, dynamic> teamRowJson(String id, String name, {Map<String, dynamic>? leave, String suggested = 'PRESENT', String category = 'DRIVER'}) => {
  'employee': {'id': id, 'empCode': 'NLS-$id', 'fullName': name, 'category': category, 'role': null},
  'designation': 'Driver',
  'depot': depotJson,
  'businessUnit': nlsJson,
  'duties': <Object>[],
  'leave': leave,
  'mark': null,
  'suggestedStatus': suggested,
};

Map<String, dynamic> emptyTeamDay({String date = '2026-11-09', List<Map<String, dynamic>> rows = const []}) => {
  'date': date,
  'editable': true,
  'editableUntil': '2026-11-10T18:29:59.000Z',
  'summary': {'employees': rows.length, 'marked': 0, 'pending': rows.length},
  'rows': rows,
};

// ───────────────────────────── Fakes ─────────────────────────────

/// Base for partial fakes: unimplemented members throw.
mixin Unimplemented {
  @override
  dynamic noSuchMethod(Invocation invocation) => throw UnimplementedError(invocation.memberName.toString());
}

class FakeAuthRepository implements AuthRepository {
  FakeAuthRepository({required this.user, this.hasSession = false});

  final CurrentUser user;
  bool hasSession;
  final logins = <String>[];
  int logoutCalls = 0;

  /// Code → failure to throw (e.g. a locked account).
  final failures = <String, ApiFailure>{};

  @override
  Future<void> login(String empCode, String password) async {
    final code = empCode.trim().toUpperCase();
    logins.add(code);
    final failure = failures[code];
    if (failure != null) throw failure;
    if (code != user.empCode || password != 'Secret@123') {
      throw const ApiFailure(code: 'INVALID_CREDENTIALS', message: 'Invalid employee code or password', statusCode: 401);
    }
    hasSession = true;
  }

  @override
  Future<bool> hasStoredSession() async => hasSession;

  @override
  Future<CurrentUser> fetchCurrentUser() async => user;

  @override
  Future<void> logout() async {
    logoutCalls++;
    hasSession = false;
  }

  @override
  Future<void> clearLocalSession() async => hasSession = false;
}

class FakeDashboardRepository implements DashboardRepository {
  FakeDashboardRepository({Map<String, dynamic>? dashboard}) : json = dashboard ?? dashboardJson();

  Map<String, dynamic> json;
  final requestedBusinessUnits = <String?>[];

  @override
  Future<Dashboard> dashboard({String? businessUnitId}) async {
    requestedBusinessUnits.add(businessUnitId);
    return Dashboard.fromJson(json);
  }

  @override
  Future<NotificationPage> notifications({String? cursor, String? businessUnitId}) async =>
      NotificationPage.fromJson({'items': <Object>[], 'nextCursor': null, 'unreadCount': 0});

  @override
  Future<void> markRead(String id) async {}

  @override
  Future<void> markAllRead() async {}
}

class FakeOrgRepository implements OrgRepository {
  @override
  Future<List<BusinessUnitItem>> businessUnits() async => [
    BusinessUnitItem.fromJson({...nlsJson, 'isActive': true}),
    BusinessUnitItem.fromJson({'id': 'bu-bms', 'code': 'BMS', 'name': 'BMS Associates', 'isActive': true}),
  ];

  @override
  Future<List<DepotItem>> depots({String? businessUnitId}) async => [
    DepotItem.fromJson({
      ...depotJson,
      'regionId': 'r1',
      'regionName': 'West',
      'businessUnitId': 'bu-nls',
      'businessUnitCode': 'NLS',
      'address': null,
      'state': 'MH',
      'lat': null,
      'lng': null,
    }),
  ];
}

class FakeEmployeesRepository with Unimplemented implements EmployeesRepository {
  FakeEmployeesRepository({List<Map<String, dynamic>>? employees})
    : employees = employees ?? [employeeListItemJson('e1', 'Ramesh Pawar'), employeeListItemJson('e2', 'Vijay More', compliance: 'MISSING')];

  final List<Map<String, dynamic>> employees;
  final listFilters = <EmployeeFilter>[];
  final created = <EmployeeCreateBody>[];
  final uploads = <(String?, PresignBodyPurposeEnum)>[];
  final createdDocuments = <DocumentCreateBody>[];
  final verified = <String>[];
  final rejected = <String, String>{};
  List<Map<String, dynamic>> queue = [];

  @override
  Future<EmployeePage> list(EmployeeFilter filter, {String? cursor}) async {
    listFilters.add(filter);
    final items = employees
        .where((e) => filter.compliance == null || e['compliance'] == filter.compliance!.value)
        .where((e) => filter.role == null || e['role'] == filter.role!.value)
        .where((e) => filter.staffOnly != true || e['role'] == null)
        .where((e) => filter.q.isEmpty || (e['fullName'] as String).toLowerCase().contains(filter.q.toLowerCase()))
        .toList();
    return EmployeePage.fromJson({'items': items, 'nextCursor': null});
  }

  @override
  Future<EmployeeDetail> get(String id) async {
    final e = employees.firstWhere((x) => x['id'] == id);
    return EmployeeDetail.fromJson(employeeDetailJson(id, e['fullName'] as String));
  }

  @override
  Future<EmployeeDetail> create(EmployeeCreateBody body) async {
    created.add(body);
    employees.add(employeeListItemJson('new', body.fullName));
    return EmployeeDetail.fromJson(employeeDetailJson('new', body.fullName));
  }

  @override
  Future<List<DocumentItem>> documents(String employeeId) async => [];

  @override
  Future<String> upload(String? employeeId, PickedUpload file, PresignBodyPurposeEnum purpose) async {
    uploads.add((employeeId, purpose));
    final owner = employeeId ?? 'me';
    return 'employees/$owner/${purpose.value.toLowerCase().replaceAll('_', '-')}/x';
  }

  @override
  Future<DocumentItem> createDocument(String employeeId, DocumentCreateBody body) async {
    createdDocuments.add(body);
    return DocumentItem.fromJson({
      'id': 'doc-new',
      'employeeId': employeeId,
      'type': body.type.value,
      'number': body.number,
      'licenceClass': null,
      'issueDate': null,
      'expiryDate': body.expiryDate,
      'status': 'PENDING_VERIFICATION',
      'hasFile': true,
      'verifiedAt': null,
      'verifiedByName': null,
      'rejectionReason': null,
      'createdAt': '2026-11-09T05:00:00.000Z',
      'daysToExpiry': null,
    });
  }

  @override
  Future<DocumentPage> verificationQueue({String? cursor}) async => DocumentPage.fromJson({'items': queue, 'nextCursor': null});

  @override
  Future<SignedUrlResponse> fileUrl(String documentId) async => throw const ApiFailure(code: 'NOT_FOUND', message: 'No file', statusCode: 404);

  @override
  Future<DocumentWithEmployee> verify(String documentId, {String? expiryDate}) async {
    verified.add(documentId);
    final d = queue.firstWhere((q) => q['id'] == documentId);
    queue.remove(d);
    return DocumentWithEmployee.fromJson({...d, 'status': 'VERIFIED'});
  }

  @override
  Future<DocumentWithEmployee> reject(String documentId, String reason) async {
    rejected[documentId] = reason;
    final d = queue.firstWhere((q) => q['id'] == documentId);
    queue.remove(d);
    return DocumentWithEmployee.fromJson({...d, 'status': 'REJECTED'});
  }

  @override
  Future<List<DepotItem>> depots() => FakeOrgRepository().depots();

  @override
  Future<List<UserItem>> managersOf(Role role, String businessUnitId) async => [
    UserItem.fromJson({
      'id': 'u-rm',
      'employeeId': 'emp-rm',
      'empCode': 'NLS003',
      'name': 'Asha Patil',
      'phone': '+919000000004',
      'email': null,
      'role': 'REGIONAL_MANAGER',
      'isActive': true,
      'hasPassword': true,
      'lockedUntil': null,
      'lastLoginAt': null,
      'reportingTo': null,
      'businessUnits': [
        {...nlsJson, 'isPrimary': true},
      ],
    }),
  ];

  @override
  Future<String> nextEmpCode(String businessUnitId) async => 'NLS010';
}

class FakeRosterRepository with Unimplemented implements RosterRepository {
  FakeRosterRepository();

  List<Map<String, dynamic>> duties = [dutyJson('duty1')];
  final assigned = <String>[];

  /// employeeId → failure to throw when assigning them.
  final failures = <String, ApiFailure>{};

  @override
  Future<RosterDay> day(String depotId, String date) async {
    final active = duties.where((d) => d['status'] != 'CANCELLED').toList();
    final filled = active.where((d) => d['filled'] == true).length;
    return RosterDay.fromJson({
      'date': date,
      'depot': depotJson,
      'summary': {'duties': active.length, 'filled': filled, 'unfilled': active.length - filled, 'cancelled': 0},
      'duties': duties,
    });
  }

  @override
  Future<List<SpareItem>> spares(String depotId, String date, {AssignmentRole role = AssignmentRole.DRIVER, String? dutyId}) async => [
    SpareItem.fromJson(spareJson('s1', 'Santosh Patil')),
  ];

  @override
  Future<AssignmentResult> assign(String dutyId, String employeeId, AssignmentRole role, {bool isSpare = false}) async {
    final failure = failures[employeeId];
    if (failure != null) throw failure;
    assigned.add(employeeId);
    final a = {
      'id': 'a-$employeeId',
      'dutyId': dutyId,
      'role': role.value,
      'isSpare': isSpare,
      'warnings': <Object>[],
      'employee': {'id': employeeId, 'empCode': 'E', 'fullName': 'Assigned $employeeId', 'category': 'DRIVER', 'phone': '+919000010009'},
    };
    final i = duties.indexWhere((d) => d['id'] == dutyId);
    duties[i] = dutyJson(dutyId, assignments: [...(duties[i]['assignments'] as List).cast<Map<String, dynamic>>(), a]);
    return AssignmentResult.fromJson({'assignment': a, 'warnings': <Object>[], 'duty': duties[i]});
  }
}

class FakeAttendanceRepository with Unimplemented implements AttendanceRepository {
  FakeAttendanceRepository({required this.dayJson});

  Map<String, dynamic> dayJson;
  bool offline = false;
  final sent = <List<BulkMark>>[];
  final selfMarks = <SelfMarkBodyStatusEnum>[];
  List<Map<String, dynamic>> approvalItems = [];
  final approved = <String>[];

  /// employeeId → error code to reject with.
  final rejectFor = <String, String>{};

  @override
  Future<TeamAttendanceDay> team(String date, {String? businessUnitId}) async => TeamAttendanceDay.fromJson(dayJson);

  @override
  Future<BulkAttendanceResult> bulk(List<BulkMark> marks) async {
    if (offline) throw const ApiFailure(code: ApiFailure.networkError, message: 'offline');
    sent.add(marks);
    final results = [
      for (final m in marks)
        {
          'clientMutationId': m.clientMutationId,
          'employeeId': m.employeeId,
          'date': m.date,
          'outcome': rejectFor.containsKey(m.employeeId) ? 'REJECTED' : 'APPLIED',
          'error': rejectFor.containsKey(m.employeeId) ? {'code': rejectFor[m.employeeId], 'message': 'Rejected: ${rejectFor[m.employeeId]}'} : null,
          'mark': null,
        },
    ];
    return BulkAttendanceResult.fromJson({
      'applied': results.where((r) => r['outcome'] == 'APPLIED').length,
      'duplicates': 0,
      'rejected': results.where((r) => r['outcome'] == 'REJECTED').length,
      'results': results,
    });
  }

  @override
  Future<List<AttendanceMarkItem>> mine(String from, String to) async => [];

  @override
  Future<AttendanceMarkItem> markSelf(String date, SelfMarkBodyStatusEnum status, {String? note}) async {
    selfMarks.add(status);
    return AttendanceMarkItem.fromJson(markJson('self', date: date, status: status.value, state: 'PENDING_APPROVAL'));
  }

  @override
  Future<List<AttendanceMarkItem>> approvals({String? businessUnitId, ApprovalState state = ApprovalState.PENDING_APPROVAL}) async =>
      [for (final m in approvalItems) AttendanceMarkItem.fromJson(m)];

  @override
  Future<List<CorrectionItem>> corrections({required String scope, String? businessUnitId}) async => [];

  @override
  Future<BulkApproveResult> approveMany(List<String> ids) async {
    approved.addAll(ids);
    approvalItems.removeWhere((m) => ids.contains(m['id']));
    return BulkApproveResult.fromJson({'approved': ids, 'skipped': <Object>[]});
  }

  @override
  Future<AttendanceMarkItem> approve(String id) async {
    approved.add(id);
    final m = approvalItems.firstWhere((x) => x['id'] == id);
    approvalItems.remove(m);
    return AttendanceMarkItem.fromJson({...m, 'approvalState': 'APPROVED'});
  }
}

Map<String, dynamic> markJson(String id, {String date = '2026-11-09', String status = 'PRESENT', String state = 'PENDING_APPROVAL', String name = 'Asha Patil', bool canDecide = false}) => {
  'id': id,
  'employee': {'id': 'emp-$id', 'empCode': 'NLS003', 'fullName': name, 'category': 'OFFICE', 'role': 'REGIONAL_MANAGER'},
  'businessUnit': nlsJson,
  'date': date,
  'status': status,
  'approvalState': state,
  'source': 'SELF',
  'note': null,
  'markedAt': '2026-11-09T04:00:00.000Z',
  'markedByName': name,
  'approver': null,
  'decidedAt': null,
  'decidedByName': null,
  'rejectionReason': null,
  'canDecide': canDecide,
  'clientMutationId': null,
};

/// In-memory queue with the same semantics as the drift one (used in widget tests).
class MemoryAttendanceQueue implements AttendanceQueue {
  final List<QueuedMark> items = [];
  final _changes = StreamController<List<QueuedMark>>.broadcast();

  void _emit() => _changes.add(List.of(items));

  @override
  Future<void> enqueue(List<QueuedMark> marks) async {
    for (final m in marks) {
      items.removeWhere((x) => x.employeeId == m.employeeId && x.date == m.date);
      items.add(m);
    }
    _emit();
  }

  @override
  Future<List<QueuedMark>> pending({int limit = 500}) async => items.where((m) => m.state == QueuedState.pending).take(limit).toList();

  @override
  Stream<List<QueuedMark>> watchAll() async* {
    yield List.of(items);
    yield* _changes.stream;
  }

  @override
  Future<void> remove(List<String> clientMutationIds) async {
    items.removeWhere((m) => clientMutationIds.contains(m.clientMutationId));
    _emit();
  }

  @override
  Future<void> markFailed(String clientMutationId, String code, String message) async {
    final i = items.indexWhere((m) => m.clientMutationId == clientMutationId);
    if (i < 0) return;
    final m = items[i];
    items[i] = QueuedMark(
      clientMutationId: m.clientMutationId,
      employeeId: m.employeeId,
      employeeName: m.employeeName,
      depotId: m.depotId,
      date: m.date,
      status: m.status,
      state: QueuedState.failed,
      errorCode: code,
      errorMessage: message,
      createdAt: m.createdAt,
    );
    _emit();
  }

  @override
  Future<void> discardFailed() async {
    items.removeWhere((m) => m.state == QueuedState.failed);
    _emit();
  }
}

class FakeRequestsRepository with Unimplemented implements RequestsRepository {
  final created = <LeaveRequestCreateBody>[];
  List<Map<String, dynamic>> items = [];

  @override
  Future<LeaveRequestPage> list({required String scope, String? businessUnitId, RequestStatus? status, String? cursor}) async =>
      LeaveRequestPage.fromJson({'items': items, 'nextCursor': null});

  @override
  Future<List<LeaveTypeItem>> leaveTypes() async => [
    LeaveTypeItem.fromJson({
      'id': 'lt-cl',
      'code': 'CL',
      'name': 'Casual leave',
      'paid': true,
      'accrualRule': {'type': 'MONTHLY'},
      'carryForwardMax': 0,
      'encashable': false,
      'isActive': true,
      'tracksBalance': true,
    }),
  ];

  @override
  Future<LeaveBalanceList> balances(String employeeId) async => LeaveBalanceList.fromJson({
    'employeeId': employeeId,
    'year': 2026,
    'items': [
      {
        'leaveTypeId': 'lt-cl',
        'leaveTypeCode': 'CL',
        'leaveTypeName': 'Casual leave',
        'year': 2026,
        'tracksBalance': true,
        'annualQuota': 8,
        'opening': 0,
        'accrued': 6,
        'used': 1,
        'encashed': 0,
        'closing': 5,
        'pending': 1,
        'available': 4,
      },
    ],
  });

  @override
  Future<LeaveRequestItem> create(LeaveRequestCreateBody body) async {
    created.add(body);
    final approved = body.autoApprove ?? false;
    return LeaveRequestItem.fromJson({
      'id': 'lr1',
      'kind': body.kind.value,
      'employee': person(body.subjectEmployeeId ?? 'emp-rm', 'Someone'),
      'businessUnit': nlsJson,
      'leaveType': body.leaveTypeId == null ? null : {'id': body.leaveTypeId, 'code': 'CL', 'name': 'Casual leave'},
      'fromDate': body.fromDate,
      'toDate': body.toDate,
      'fromHalf': body.fromHalf ?? false,
      'toHalf': body.toHalf ?? false,
      'days': 1,
      'reason': body.reason,
      'odLocation': body.odLocation,
      'odPurpose': body.odPurpose,
      'odFromTime': null,
      'odToTime': null,
      'status': approved ? 'APPROVED' : 'PENDING',
      'raisedByName': 'Asha Patil',
      'approver': null,
      'decidedAt': null,
      'decidedByName': null,
      'rejectionReason': null,
      'canDecide': false,
      'canCancel': !approved,
      'warnings': <Object>[],
      'createdAt': '2026-11-09T05:00:00.000Z',
    });
  }
}

class FakeAllowancesRepository with Unimplemented implements AllowancesRepository {
  final created = <AllowanceCreateBody>[];
  final approvedBatches = <String>[];
  final approvals = <(String, int?, String?)>[];
  Map<String, List<Map<String, dynamic>>> byScope = {};

  @override
  Future<List<AllowanceTypeItem>> types() async => [
    AllowanceTypeItem.fromJson({'id': 'at-batta', 'code': 'BATTA', 'name': 'Batta', 'maxAmountPaise': null, 'isActive': true}),
    AllowanceTypeItem.fromJson({'id': 'at-food', 'code': 'FOOD', 'name': 'Food', 'maxAmountPaise': 50000, 'isActive': true}),
  ];

  @override
  Future<AllowancePage> list({required String scope, String? businessUnitId, String? cursor, RequestStatus? status}) async =>
      AllowancePage.fromJson({'items': byScope[scope] ?? <Object>[], 'nextCursor': null});

  @override
  Future<List<AllowanceItem>> create(AllowanceCreateBody body) async {
    created.add(body);
    final ids = body.beneficiaryEmployeeIds ?? ['self'];
    return [for (final id in ids) AllowanceItem.fromJson(allowanceJson(id, amount: body.amountPaise))];
  }

  @override
  Future<BatchApproveResult> approveBatch(String batchId) async {
    approvedBatches.add(batchId);
    final items = byScope['approvals'] ?? [];
    final ids = items.where((a) => a['batchId'] == batchId).map((a) => a['id'] as String).toList();
    items.removeWhere((a) => a['batchId'] == batchId);
    return BatchApproveResult.fromJson({'approved': ids, 'skipped': <Object>[]});
  }

  @override
  Future<AllowanceItem> approve(String id, {int? approvedAmountPaise, String? comment}) async {
    approvals.add((id, approvedAmountPaise, comment));
    byScope['approvals']?.removeWhere((a) => a['id'] == id);
    return AllowanceItem.fromJson(allowanceJson(id, status: 'APPROVED', approved: approvedAmountPaise ?? 30000));
  }

  @override
  Future<AllowanceFiles> files(String id) async => AllowanceFiles.fromJson({'voiceNote': null, 'receipt': null});

  @override
  Future<AllowanceSummary> summary(String month, {String? businessUnitId}) async => AllowanceSummary.fromJson({
    'month': month,
    'items': [
      {'businessUnit': nlsJson, 'requests': 4, 'pending': 1, 'requestedPaise': 120000, 'approvedPaise': 90000},
    ],
  });
}

class FakePayslipsRepository with Unimplemented implements PayslipsRepository {
  Map<String, List<Map<String, dynamic>>> byScope = {};
  final scopes = <String>[];

  @override
  Future<PayslipPage> list({required String scope, String? period, String? businessUnitId, String? q, String? cursor}) async {
    scopes.add('$scope:$period');
    return PayslipPage.fromJson({'items': byScope[scope] ?? <Object>[], 'nextCursor': null});
  }
}

class FakeTasksRepository with Unimplemented implements TasksRepository {
  Map<String, List<Map<String, dynamic>>> byQuery = {};
  final submitted = <(String, bool, String?)>[];
  final createdBodies = <TaskCreateBody>[];

  @override
  Future<TaskPage> list({required String scope, String? state, String? date, String? businessUnitId, TaskStatus? status, String? cursor}) async =>
      TaskPage.fromJson({'items': byQuery['$scope:${state ?? ''}'] ?? byQuery[scope] ?? <Object>[], 'nextCursor': null});

  @override
  Future<TaskItem> submit(String id, {required bool completed, String? reason, String? comment}) async {
    submitted.add((id, completed, reason));
    for (final l in byQuery.values) {
      l.removeWhere((t) => t['id'] == id);
    }
    return TaskItem.fromJson(taskJson(id, status: completed ? 'COMPLETED' : 'NOT_DONE'));
  }

  @override
  Future<List<TaskItem>> create(TaskCreateBody body) async {
    createdBodies.add(body);
    return [for (final a in body.assigneeEmployeeIds) TaskItem.fromJson(taskJson('t-$a', title: body.title))];
  }
}

// ───────────────────────────── App harness ─────────────────────────────

class Fakes {
  Fakes({required CurrentUser user, Map<String, dynamic>? teamDay})
    : auth = FakeAuthRepository(user: user, hasSession: true),
      attendance = FakeAttendanceRepository(dayJson: teamDay ?? emptyTeamDay());

  final FakeAuthRepository auth;
  final dashboard = FakeDashboardRepository();
  final org = FakeOrgRepository();
  final employees = FakeEmployeesRepository();
  final roster = FakeRosterRepository();
  final FakeAttendanceRepository attendance;
  final queue = MemoryAttendanceQueue();
  final requests = FakeRequestsRepository();
  final allowances = FakeAllowancesRepository();
  final payslips = FakePayslipsRepository();
  final tasks = FakeTasksRepository();
  final preferences = MemoryPreferences();

  List<Override> get overrides => [
    authRepositoryProvider.overrideWithValue(auth),
    dashboardRepositoryProvider.overrideWithValue(dashboard),
    orgRepositoryProvider.overrideWithValue(org),
    employeesRepositoryProvider.overrideWithValue(employees),
    rosterRepositoryProvider.overrideWithValue(roster),
    attendanceRepositoryProvider.overrideWithValue(attendance),
    attendanceQueueProvider.overrideWithValue(queue),
    requestsRepositoryProvider.overrideWithValue(requests),
    allowancesRepositoryProvider.overrideWithValue(allowances),
    payslipsRepositoryProvider.overrideWithValue(payslips),
    tasksRepositoryProvider.overrideWithValue(tasks),
    preferencesProvider.overrideWithValue(preferences),
  ];
}

/// Pumps the whole app signed in as the fakes' user, on a phone-sized screen by default.
Future<void> pumpApp(WidgetTester tester, Fakes fakes, {Size size = const Size(420, 900), List<Override> extra = const []}) async {
  tester.view.physicalSize = size;
  tester.view.devicePixelRatio = 1.0;
  addTearDown(tester.view.reset);
  await tester.pumpWidget(ProviderScope(overrides: [...fakes.overrides, ...extra], retry: (_, _) => null, child: const HrmsApp()));
  await tester.pumpAndSettle();
}
