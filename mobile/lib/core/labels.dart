import 'package:hrms_api/hrms_api.dart';
import 'package:intl/intl.dart';

import '../app/l10n/app_localizations.dart';
import 'widgets/status_chip.dart';

/// User-facing labels (ARB) for API enum values.
extension EnumLabels on AppLocalizations {
  String category(EmployeeCategory c) => switch (c) {
    EmployeeCategory.DRIVER => catDriver,
    EmployeeCategory.LOADMAN => catLoadman,
    EmployeeCategory.CONDUCTOR => catConductor,
    EmployeeCategory.HELPER => catHelper,
    EmployeeCategory.MECHANIC => catMechanic,
    EmployeeCategory.DEPOT_STAFF => catDepotStaff,
    EmployeeCategory.OFFICE => catOffice,
  };

  String employmentType(EmploymentType t) => switch (t) {
    EmploymentType.PERMANENT => empPermanent,
    EmploymentType.FIXED_TERM => empFixedTerm,
    EmploymentType.CONTRACT => empContract,
  };

  String employeeStatus(EmployeeStatus s) => switch (s) {
    EmployeeStatus.ACTIVE => statusActive,
    EmployeeStatus.ON_NOTICE => statusOnNotice,
    EmployeeStatus.EXITED => statusExited,
    EmployeeStatus.SUSPENDED => statusSuspended,
  };

  String documentType(DocumentType t) => switch (t) {
    DocumentType.DRIVING_LICENCE => docDrivingLicence,
    DocumentType.PSV_BADGE => docPsvBadge,
    DocumentType.MEDICAL_FITNESS => docMedical,
    DocumentType.POLICE_VERIFICATION => docPolice,
    DocumentType.AADHAAR => docAadhaar,
    DocumentType.PAN => docPan,
    DocumentType.TRAINING_CERT => docTraining,
    DocumentType.OTHER => docOther,
  };

  String documentStatus(DocumentStatus s) => switch (s) {
    DocumentStatus.PENDING_VERIFICATION => docStatusPending,
    DocumentStatus.VERIFIED => docStatusVerified,
    DocumentStatus.REJECTED => docStatusRejected,
    DocumentStatus.EXPIRED => docStatusExpired,
  };

  String compliance(ComplianceOverall c) => switch (c) {
    ComplianceOverall.OK => complianceOk,
    ComplianceOverall.EXPIRING => complianceExpiring,
    ComplianceOverall.PENDING_VERIFICATION => compliancePending,
    ComplianceOverall.EXPIRED => complianceExpired,
    ComplianceOverall.MISSING => complianceMissing,
  };

  String complianceState(ComplianceState s) => switch (s) {
    ComplianceState.VALID => stateValid,
    ComplianceState.EXPIRING => stateExpiring,
    ComplianceState.UNVERIFIED => stateUnverified,
    ComplianceState.EXPIRED => stateExpired,
    ComplianceState.REJECTED => stateRejected,
    ComplianceState.MISSING => stateMissing,
  };

  String attendanceStatus(AttendanceStatus s) => switch (s) {
    AttendanceStatus.PRESENT => attPresent,
    AttendanceStatus.ABSENT => attAbsent,
    AttendanceStatus.HALF_DAY => attHalfDay,
    AttendanceStatus.ON_LEAVE => attOnLeave,
    AttendanceStatus.ON_DUTY => attOnDuty,
    AttendanceStatus.WEEKLY_OFF => attWeeklyOff,
    AttendanceStatus.HOLIDAY => attHoliday,
  };

  /// One or two letters for the compact attendance selector.
  String attendanceShort(AttendanceStatus s) => switch (s) {
    AttendanceStatus.PRESENT => attPresentShort,
    AttendanceStatus.ABSENT => attAbsentShort,
    AttendanceStatus.HALF_DAY => attHalfDayShort,
    AttendanceStatus.ON_LEAVE => attOnLeaveShort,
    AttendanceStatus.ON_DUTY => attOnDutyShort,
    AttendanceStatus.WEEKLY_OFF => attWeeklyOffShort,
    AttendanceStatus.HOLIDAY => attHolidayShort,
  };

  String approvalState(ApprovalState s) => switch (s) {
    ApprovalState.PENDING_APPROVAL => apprPending,
    ApprovalState.APPROVED => apprApproved,
    ApprovalState.REJECTED => apprRejected,
  };

  String requestStatus(RequestStatus s) => switch (s) {
    RequestStatus.PENDING => apprPending,
    RequestStatus.APPROVED => apprApproved,
    RequestStatus.REJECTED => apprRejected,
    RequestStatus.CANCELLED => apprCancelled,
  };

  String leaveKind(LeaveKind k) => switch (k) {
    LeaveKind.LEAVE => kindLeave,
    LeaveKind.OD => kindOd,
  };

  String taskStatus(TaskStatus s, {bool overdue = false}) => switch (s) {
    TaskStatus.PENDING => overdue ? taskOverdue : taskPending,
    TaskStatus.COMPLETED => taskCompleted,
    TaskStatus.NOT_DONE => taskNotDone,
  };

  String assignmentRole(AssignmentRole r) => switch (r) {
    AssignmentRole.DRIVER => roleDriver,
    AssignmentRole.CO_DRIVER => roleCoDriver,
    AssignmentRole.CONDUCTOR => roleConductor,
    AssignmentRole.HELPER => roleHelper,
  };

  String apiRole(Role r) => switch (r) {
    Role.DIRECTOR => roleDirector,
    Role.HR => roleHr,
    Role.OPERATIONAL_MANAGER => roleOperationalManager,
    Role.REGIONAL_MANAGER => roleRegionalManager,
  };

  /// "Regional manager" for logins, "Driver" for records.
  String personKind(Role? role, String category) =>
      role != null ? apiRole(role) : this.category(EmployeeCategory.values.firstWhere((c) => c.value == category, orElse: () => EmployeeCategory.OFFICE));
}

Tone complianceTone(ComplianceOverall c) => switch (c) {
  ComplianceOverall.OK => Tone.good,
  ComplianceOverall.EXPIRING => Tone.warn,
  ComplianceOverall.PENDING_VERIFICATION => Tone.info,
  ComplianceOverall.EXPIRED || ComplianceOverall.MISSING => Tone.bad,
};

Tone complianceStateTone(ComplianceState s) => switch (s) {
  ComplianceState.VALID => Tone.good,
  ComplianceState.EXPIRING => Tone.warn,
  ComplianceState.UNVERIFIED => Tone.info,
  _ => Tone.bad,
};

Tone documentStatusTone(DocumentStatus s) => switch (s) {
  DocumentStatus.VERIFIED => Tone.good,
  DocumentStatus.PENDING_VERIFICATION => Tone.info,
  _ => Tone.bad,
};

Tone requestTone(RequestStatus s) => switch (s) {
  RequestStatus.APPROVED => Tone.good,
  RequestStatus.PENDING => Tone.info,
  RequestStatus.REJECTED => Tone.bad,
  RequestStatus.CANCELLED => Tone.neutral,
};

Tone approvalStateTone(ApprovalState s) => switch (s) {
  ApprovalState.APPROVED => Tone.good,
  ApprovalState.PENDING_APPROVAL => Tone.info,
  ApprovalState.REJECTED => Tone.bad,
};

Tone taskTone(TaskStatus s, {bool overdue = false}) => switch (s) {
  TaskStatus.PENDING => overdue ? Tone.bad : Tone.info,
  TaskStatus.COMPLETED => Tone.good,
  TaskStatus.NOT_DONE => Tone.warn,
};

/// Money is integer paise in the API (CLAUDE.md §5); formatted only here.
String formatRupees(int paise) {
  final f = NumberFormat.currency(locale: 'en_IN', symbol: '₹', decimalDigits: paise % 100 == 0 ? 0 : 2);
  return f.format(paise / 100);
}

/// "₹1,250.50" or "1250.5" typed by a user → paise; null if not a positive amount.
int? parseRupees(String raw) {
  final cleaned = raw.replaceAll(RegExp(r'[₹,\s]'), '');
  final value = double.tryParse(cleaned);
  if (value == null || value <= 0) return null;
  return (value * 100).round();
}
