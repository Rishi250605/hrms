// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Transport HRMS';

  @override
  String get retry => 'Retry';

  @override
  String get cancel => 'Cancel';

  @override
  String get logout => 'Sign out';

  @override
  String get loadingSession => 'Signing you in…';

  @override
  String get sessionLoadFailed =>
      'Could not reach the server. Check your connection and try again.';

  @override
  String get loginTitle => 'Sign in';

  @override
  String get loginSubtitle =>
      'Manager app for attendance, leave, allowances, payslips and tasks';

  @override
  String get phoneLabel => 'Mobile number';

  @override
  String get phoneHint => '98765 43210';

  @override
  String get phoneInvalid => 'Enter a valid 10-digit mobile number';

  @override
  String get sendOtp => 'Send OTP';

  @override
  String otpSentTo(String phone) {
    return 'Enter the 6-digit OTP sent to $phone';
  }

  @override
  String get otpLabel => 'OTP';

  @override
  String get otpInvalid => 'Enter the 6-digit OTP';

  @override
  String get verify => 'Verify and sign in';

  @override
  String get changeNumber => 'Change number';

  @override
  String get resendOtp => 'Resend OTP';

  @override
  String resendIn(int seconds) {
    return 'Resend in ${seconds}s';
  }

  @override
  String get errorNetwork =>
      'No connection to the server. Check your network and try again.';

  @override
  String get errorUnknown => 'Something went wrong. Please try again.';

  @override
  String get errorSessionExpired =>
      'Your session has expired. Please sign in again.';

  @override
  String get navHome => 'Home';

  @override
  String get navRoster => 'Roster';

  @override
  String get navAttendance => 'Attendance';

  @override
  String get navRequests => 'Requests';

  @override
  String get navApprovals => 'Approvals';

  @override
  String get navDepots => 'Depots';

  @override
  String get navReports => 'Reports';

  @override
  String get navEmployees => 'Employees';

  @override
  String get navPayroll => 'Payroll';

  @override
  String get navMore => 'More';

  @override
  String get roleOperationalManager => 'Operational manager';

  @override
  String get roleRegionalManager => 'Regional manager';

  @override
  String get roleOperationalHead => 'Operational head';

  @override
  String get roleHr => 'HR';

  @override
  String homeGreeting(String name) {
    return 'Hello, $name';
  }

  @override
  String comingInPhase(int phase) {
    return 'Available in phase $phase';
  }

  @override
  String featureComingSoonTitle(String feature) {
    return '$feature is on the way';
  }

  @override
  String get omCardDuties => 'Today\'s duties';

  @override
  String get omCardAttendance => 'Mark attendance';

  @override
  String get omCardExpiring => 'Expiring documents in my depots';

  @override
  String get omCardMyRequests => 'Requests I raised';

  @override
  String get rmCardApprovals => 'Approvals inbox';

  @override
  String get rmCardNoShows => 'No-shows and unfilled duties';

  @override
  String get rmCardExpiryRisk => 'Expiry risk by depot';

  @override
  String get headCardAttendance => 'Attendance %';

  @override
  String get headCardOt => 'OT hours and cost';

  @override
  String get headCardUnfilled => 'Duties unfilled';

  @override
  String get headCardIdleVehicles => 'Vehicles idle for lack of drivers';

  @override
  String get headCardApprovals => 'Approvals needing your sign-off';

  @override
  String get hrCardVerify => 'Documents to verify';

  @override
  String get hrCardJoinersLeavers => 'Joiners and leavers';

  @override
  String get hrCardPayroll => 'Payroll run status';

  @override
  String get hrCardExpiring => 'Expiring documents (company-wide)';

  @override
  String get profileTitle => 'My profile';

  @override
  String get superAdmin => 'Super admin';

  @override
  String get scopeTitle => 'My data scope';

  @override
  String get scopeCompanyWide => 'Company-wide access';

  @override
  String get scopeRegions => 'Regions';

  @override
  String get scopeDepots => 'Depots';

  @override
  String get scopeNone =>
      'No depots or regions assigned yet. Ask HR to set your scope.';

  @override
  String get navDocuments => 'Verify';

  @override
  String get navFleet => 'Fleet';

  @override
  String get navNotifications => 'Notifications';

  @override
  String get ok => 'OK';

  @override
  String get save => 'Save';

  @override
  String get saved => 'Saved';

  @override
  String get next => 'Next';

  @override
  String get back => 'Back';

  @override
  String get remove => 'Remove';

  @override
  String get dismiss => 'Dismiss';

  @override
  String get none => 'None';

  @override
  String get optional => 'Optional';

  @override
  String get required => 'Required';

  @override
  String get invalidValue => 'Invalid value';

  @override
  String get reason => 'Reason';

  @override
  String get comment => 'Comment';

  @override
  String get date => 'Date';

  @override
  String get today => 'Today';

  @override
  String get thisMonth => 'This month';

  @override
  String get depot => 'Depot';

  @override
  String get employee => 'Employee';

  @override
  String get moreActions => 'More';

  @override
  String get filterAll => 'All';

  @override
  String get cancelled => 'Cancelled';

  @override
  String get catDriver => 'Driver';

  @override
  String get catConductor => 'Conductor';

  @override
  String get catHelper => 'Helper';

  @override
  String get catMechanic => 'Mechanic';

  @override
  String get catDepotStaff => 'Depot staff';

  @override
  String get catOffice => 'Office';

  @override
  String get empPermanent => 'Permanent';

  @override
  String get empFixedTerm => 'Fixed term';

  @override
  String get empContract => 'Contract';

  @override
  String get statusActive => 'Active';

  @override
  String get statusOnNotice => 'On notice';

  @override
  String get statusExited => 'Exited';

  @override
  String get statusSuspended => 'Suspended';

  @override
  String get docDrivingLicence => 'Driving licence';

  @override
  String get docPsvBadge => 'PSV badge';

  @override
  String get docMedical => 'Medical fitness';

  @override
  String get docPolice => 'Police verification';

  @override
  String get docAadhaar => 'Aadhaar';

  @override
  String get docPan => 'PAN';

  @override
  String get docTraining => 'Training certificate';

  @override
  String get docOther => 'Other';

  @override
  String get docStatusPending => 'Pending verification';

  @override
  String get docStatusVerified => 'Verified';

  @override
  String get docStatusRejected => 'Rejected';

  @override
  String get docStatusExpired => 'Expired';

  @override
  String get complianceOk => 'Documents OK';

  @override
  String get complianceExpiring => 'Expiring';

  @override
  String get compliancePending => 'Pending verification';

  @override
  String get complianceExpired => 'Expired';

  @override
  String get complianceMissing => 'Missing';

  @override
  String get stateValid => 'Valid';

  @override
  String get stateExpiring => 'Expiring';

  @override
  String get stateUnverified => 'Unverified';

  @override
  String get stateExpired => 'Expired';

  @override
  String get stateRejected => 'Rejected';

  @override
  String get stateMissing => 'Missing';

  @override
  String get attPresent => 'Present';

  @override
  String get attAbsent => 'Absent';

  @override
  String get attHalfDay => 'Half day';

  @override
  String get attOnLeave => 'On leave';

  @override
  String get attWeeklyOff => 'Weekly off';

  @override
  String get attHoliday => 'Holiday';

  @override
  String get attOutstation => 'On duty (outstation)';

  @override
  String get attPresentShort => 'P';

  @override
  String get attAbsentShort => 'A';

  @override
  String get attHalfDayShort => '½';

  @override
  String get attOnLeaveShort => 'L';

  @override
  String get attWeeklyOffShort => 'WO';

  @override
  String get attHolidayShort => 'H';

  @override
  String get attOutstationShort => 'OD';

  @override
  String get apprPending => 'Pending';

  @override
  String get apprApproved => 'Approved';

  @override
  String get apprRejected => 'Rejected';

  @override
  String get apprCancelled => 'Withdrawn';

  @override
  String get entityLeave => 'Leave';

  @override
  String get entityCorrection => 'Attendance correction';

  @override
  String get entityAdvance => 'Advance';

  @override
  String get entitySwap => 'Duty swap';

  @override
  String get entityRecovery => 'Recovery';

  @override
  String get entityPolicyException => 'Policy exception';

  @override
  String get roleDriver => 'Driver';

  @override
  String get roleCoDriver => 'Co-driver';

  @override
  String get roleConductor => 'Conductor';

  @override
  String get roleHelper => 'Helper';

  @override
  String get employeesSearchHint => 'Name, employee code or phone';

  @override
  String get employeesEmpty => 'No employees match.';

  @override
  String get employeesSelectHint => 'Select an employee to see their profile.';

  @override
  String get employeeProfile => 'Employee';

  @override
  String employeeCreated(String name) {
    return '$name added';
  }

  @override
  String get complianceTitle => 'Required documents';

  @override
  String get noRequiredDocuments =>
      'No documents are required for this category.';

  @override
  String get notRosterable =>
      'Cannot be rostered until every required document is valid.';

  @override
  String get documentsTitle => 'Documents';

  @override
  String get noDocuments => 'No documents yet.';

  @override
  String validUntil(String date) {
    return 'Valid until $date';
  }

  @override
  String rejectedBecause(String reason) {
    return 'Rejected: $reason';
  }

  @override
  String get viewFile => 'View file';

  @override
  String get jobHistory => 'Job history';

  @override
  String jobFromOpen(String from) {
    return 'From $from';
  }

  @override
  String jobRange(String from, String to) {
    return '$from – $to';
  }

  @override
  String reportsTo(String name) {
    return 'Reports to $name';
  }

  @override
  String get personalDetails => 'Personal details';

  @override
  String get joiningDate => 'Joining date';

  @override
  String get exitDate => 'Exit date';

  @override
  String get employmentTypeLabel => 'Employment type';

  @override
  String get contractor => 'Contractor';

  @override
  String get aadhaarLast4 => 'Aadhaar (last 4 digits)';

  @override
  String get aadhaarHelper => 'Only the last 4 digits are stored.';

  @override
  String get aadhaarLast4Invalid => 'Enter the last 4 digits';

  @override
  String get addDocument => 'Add document';

  @override
  String get raiseLeave => 'Raise leave';

  @override
  String get documentSaved => 'Document saved. HR will verify it.';

  @override
  String get changeJob => 'Transfer / change job';

  @override
  String get recordExit => 'Record exit';

  @override
  String get effectiveFrom => 'Effective from';

  @override
  String get depotUnchanged => 'Depot (leave empty to keep)';

  @override
  String get designation => 'Designation';

  @override
  String get grade => 'Grade';

  @override
  String get lastWorkingDay => 'Last working day';

  @override
  String get documentTypeLabel => 'Document type';

  @override
  String get documentNumber => 'Document number';

  @override
  String get licenceClass => 'Licence class';

  @override
  String get issueDate => 'Issue date';

  @override
  String get expiryDate => 'Expiry date';

  @override
  String get takePhoto => 'Take photo';

  @override
  String get chooseFile => 'Choose photo';

  @override
  String get photoRequired => 'Take or choose a photo of the document.';

  @override
  String get saveForVerification => 'Save for verification';

  @override
  String get onboardTitle => 'Onboard employee';

  @override
  String get stepPersonal => 'Personal';

  @override
  String get stepJob => 'Job';

  @override
  String get stepStatutory => 'Statutory and bank';

  @override
  String get stepReview => 'Review';

  @override
  String get empCode => 'Employee ID';

  @override
  String get fullName => 'Full name';

  @override
  String get categoryLabel => 'Category';

  @override
  String get dob => 'Date of birth';

  @override
  String get gender => 'Gender';

  @override
  String get genderMale => 'Male';

  @override
  String get genderFemale => 'Female';

  @override
  String get genderOther => 'Other';

  @override
  String get channelWhatsapp => 'WhatsApp';

  @override
  String get channelSms => 'SMS';

  @override
  String get reportingManager => 'Reporting manager';

  @override
  String get bankAccount => 'Bank account number';

  @override
  String get createEmployee => 'Create employee';

  @override
  String get verifyQueueTitle => 'Documents to verify';

  @override
  String get verifyQueueEmpty => 'Nothing to verify. 🎉';

  @override
  String get verifyDocument => 'Verify';

  @override
  String get reject => 'Reject';

  @override
  String get rejectDocument => 'Reject document';

  @override
  String get rejectReason => 'Why is it rejected? (the manager will see this)';

  @override
  String get noFile => 'No file attached';

  @override
  String get openFile => 'Open file';

  @override
  String unfilledCount(int count) {
    return '$count unfilled';
  }

  @override
  String filledCount(int count) {
    return '$count filled';
  }

  @override
  String dutiesCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count duties',
      one: '1 duty',
    );
    return '$_temp0';
  }

  @override
  String expiredCount(int count) {
    return '$count expired';
  }

  @override
  String get allFilled => 'All filled';

  @override
  String get pendingToday => 'Pending today';

  @override
  String get pendingApproval => 'Pending approval';

  @override
  String get noShowsUnfilled => 'No-shows / unfilled today';

  @override
  String get depotComparison => 'Depots';

  @override
  String get unfilled => 'Unfilled';

  @override
  String get noShows => 'No-shows';

  @override
  String get attendancePendingShort => 'Unmarked';

  @override
  String get expiring => 'Expiring';

  @override
  String get expired => 'Expired';

  @override
  String get markAllRead => 'Mark all read';

  @override
  String get noNotifications => 'No notifications.';

  @override
  String get addDuty => 'Add duty';

  @override
  String get copyPreviousDay => 'Copy previous day';

  @override
  String get copyDone => 'Roster copied';

  @override
  String copySummary(int duties, int crew, int existing) {
    return '$duties duties and $crew crew assignments copied. $existing duties were already there.';
  }

  @override
  String get copySkipped => 'Not copied:';

  @override
  String get noDuties =>
      'No duties for this day. Add one or copy the previous day.';

  @override
  String get noVehicle => 'No vehicle';

  @override
  String get duty => 'Duty';

  @override
  String get crew => 'Crew';

  @override
  String get noCrew => 'No one assigned yet.';

  @override
  String assignRole(String role) {
    return 'Assign $role';
  }

  @override
  String get cancelDuty => 'Cancel duty';

  @override
  String assignedWithWarnings(String name) {
    return '$name assigned, with warnings';
  }

  @override
  String documentsBlock(String name) {
    return '$name cannot be rostered: documents are not valid on this date.';
  }

  @override
  String get trySpares => 'Available spares:';

  @override
  String get suggestedSpares => 'Suggested spares';

  @override
  String get noSpares => 'No spares available.';

  @override
  String get allEmployees => 'All employees';

  @override
  String hoursLast7Days(String hours) {
    return '$hours h in last 7 days';
  }

  @override
  String get dutyTemplate => 'Template';

  @override
  String get customTimes => 'Custom times';

  @override
  String get start => 'Start';

  @override
  String get end => 'End';

  @override
  String get endsNextDay => 'Ends the next day.';

  @override
  String get route => 'Route';

  @override
  String get vehicle => 'Vehicle';

  @override
  String get vehicles => 'Vehicles';

  @override
  String get routes => 'Routes';

  @override
  String get dutyTemplates => 'Templates';

  @override
  String get addVehicle => 'Add vehicle';

  @override
  String get addRoute => 'Add route';

  @override
  String get addTemplate => 'Add template';

  @override
  String get regNo => 'Registration number';

  @override
  String get vehicleType => 'Type (bus, truck, …)';

  @override
  String get capacity => 'Capacity';

  @override
  String get code => 'Code';

  @override
  String get name => 'Name';

  @override
  String get origin => 'From';

  @override
  String get destination => 'To';

  @override
  String minutes(int count) {
    return '$count min';
  }

  @override
  String get allPresent => 'All present';

  @override
  String attendanceSummary(int marked, int total, int rostered) {
    return '$marked of $total marked · $rostered rostered';
  }

  @override
  String submitMarks(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Submit $count marks',
      one: 'Submit 1 mark',
      zero: 'Nothing to submit',
    );
    return '$_temp0';
  }

  @override
  String attendanceSaved(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count marks saved',
      one: '1 mark saved',
    );
    return '$_temp0';
  }

  @override
  String get editWindowClosed =>
      'The edit window for this day has closed. Request a correction to change a mark.';

  @override
  String get noTeam => 'No employees at this depot on this date.';

  @override
  String get onLeave => 'Leave';

  @override
  String get pendingSync => 'Pending sync';

  @override
  String get syncFailed => 'Not accepted';

  @override
  String get requestCorrection => 'Request correction';

  @override
  String get notMarked => 'Not marked';

  @override
  String offlinePending(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Offline: $count marks saved on this phone, waiting to sync',
      one: 'Offline: 1 mark saved on this phone, waiting to sync',
    );
    return '$_temp0';
  }

  @override
  String syncingPending(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Sending $count marks…',
      one: 'Sending 1 mark…',
    );
    return '$_temp0';
  }

  @override
  String syncRejected(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count marks were not accepted:',
      one: '1 mark was not accepted:',
    );
    return '$_temp0';
  }

  @override
  String get myRequests => 'My requests';

  @override
  String get newRequest => 'New request';

  @override
  String get noRequests => 'You have not raised any requests.';

  @override
  String get leaveRequest => 'Leave request';

  @override
  String get attendanceCorrection => 'Attendance correction';

  @override
  String get leaveType => 'Leave type';

  @override
  String get fromDate => 'From';

  @override
  String get toDate => 'To';

  @override
  String get startsMidday => 'Starts at mid-day (half day)';

  @override
  String get endsMidday => 'Ends at mid-day (half day)';

  @override
  String leaveDays(String days) {
    return '$days day(s)';
  }

  @override
  String leaveAvailable(String available, String pending) {
    return 'Available: $available day(s) ($pending pending)';
  }

  @override
  String get noBalanceKept => 'No balance is kept for this leave type.';

  @override
  String get submitForApproval => 'Submit for approval';

  @override
  String get leaveSubmitted => 'Leave submitted for approval';

  @override
  String get leaveApproved => 'Leave recorded (no approval step applied)';

  @override
  String get correctTo => 'Correct to';

  @override
  String get correctionSubmitted => 'Correction submitted for approval';

  @override
  String get approvalsInbox => 'Approvals';

  @override
  String get inboxEmpty => 'Nothing waiting for you.';

  @override
  String get approve => 'Approve';

  @override
  String get approvedMessage => 'Approved';

  @override
  String get rejectedMessage => 'Rejected';

  @override
  String raisedBy(String name) {
    return 'by $name';
  }

  @override
  String stepOf(int step, int total) {
    return 'step $step of $total';
  }

  @override
  String get escalated => 'escalated';

  @override
  String get withdraw => 'Withdraw request';

  @override
  String get roleDirector => 'Director';

  @override
  String get catLoadman => 'Loadman';

  @override
  String get attOnDuty => 'On duty (OD)';

  @override
  String get attOnDutyShort => 'OD';

  @override
  String get kindLeave => 'Leave';

  @override
  String get kindOd => 'On duty (OD)';

  @override
  String get taskPending => 'Pending';

  @override
  String get taskOverdue => 'Overdue';

  @override
  String get taskCompleted => 'Completed';

  @override
  String get taskNotDone => 'Not done';

  @override
  String get navLeave => 'Leave & OD';

  @override
  String get navAllowances => 'Allowances';

  @override
  String get navPayslips => 'Payslips';

  @override
  String get navTasks => 'Tasks';

  @override
  String get navUsers => 'Users';

  @override
  String get loginInvalid => 'Invalid employee ID or password';

  @override
  String loginLocked(int minutes) {
    return 'Account locked, try again in $minutes minutes or contact your Director';
  }

  @override
  String get loginDisabled =>
      'Your login is deactivated. Contact your Director.';

  @override
  String get empCodeInvalid => 'Enter your employee ID, e.g. NLS001';

  @override
  String get password => 'Password';

  @override
  String get showPassword => 'Show password';

  @override
  String get hidePassword => 'Hide password';

  @override
  String get passwordRequired => 'Enter your password';

  @override
  String get signIn => 'Sign in';

  @override
  String get forgotPasswordHint => 'Forgot password? Contact your Director.';

  @override
  String get businessUnit => 'Business unit';

  @override
  String get businessUnits => 'Business units';

  @override
  String get allBusinessUnits => 'All business units';

  @override
  String get primary => 'primary';

  @override
  String get chooseEmployees => 'Choose people';

  @override
  String selectedCount(int count) {
    return 'Done ($count)';
  }

  @override
  String get myAttendanceToday => 'My attendance today';

  @override
  String get tapToMark => 'Tap to mark';

  @override
  String get attendanceToApprove => 'Attendance to approve';

  @override
  String get leaveToApprove => 'Leave / OD to approve';

  @override
  String get allowancesToApprove => 'Allowances to approve';

  @override
  String get myOpenTasks => 'My open tasks';

  @override
  String overdueCount(int count) {
    return '$count overdue';
  }

  @override
  String get myToDo => 'For me';

  @override
  String get attendanceReport => 'Attendance report';

  @override
  String get leaveAndOdList => 'Leave & OD list';

  @override
  String get presentToday => 'Present today';

  @override
  String todaySummary(int present, int absent, int leave, int notMarked) {
    return '$present present · $absent absent · $leave on leave · $notMarked not marked';
  }

  @override
  String get pendingApprovals => 'Pending approvals';

  @override
  String pendingBreakdown(int attendance, int leave, int allowances) {
    return 'Attendance $attendance · Leave $leave · Allowances $allowances';
  }

  @override
  String get allowancesThisMonth => 'Allowances approved this month';

  @override
  String requestedAmount(String amount) {
    return 'Requested $amount';
  }

  @override
  String get tasksToday => 'Today\'s tasks per operational manager';

  @override
  String notDoneCount(int count) {
    return '$count not done';
  }

  @override
  String headcountAsOf(int count, String date) {
    return '$count people · $date';
  }

  @override
  String get tabTeam => 'Team';

  @override
  String get tabMine => 'Mine';

  @override
  String get tabMyAttendance => 'My attendance';

  @override
  String get tabApprovals => 'Approvals';

  @override
  String get tabAllotted => 'Allotted';

  @override
  String get tabCompleted => 'Completed';

  @override
  String teamAttendanceSummary(int marked, int total) {
    return '$marked of $total marked';
  }

  @override
  String get selfMarkSent => 'Sent to your reporting manager for approval';

  @override
  String todayDate(String date) {
    return 'Today, $date';
  }

  @override
  String approvedBy(String name) {
    return 'Approved by $name';
  }

  @override
  String get last31Days => 'Last 31 days';

  @override
  String get noMarksYet => 'No attendance marked yet.';

  @override
  String approveAll(int count) {
    return 'Approve all ($count)';
  }

  @override
  String approvedCount(int count) {
    return '$count approved';
  }

  @override
  String get corrections => 'Corrections';

  @override
  String get requestType => 'Type';

  @override
  String get dates => 'Dates';

  @override
  String get odLocation => 'Location / place of duty';

  @override
  String get odPurpose => 'Purpose';

  @override
  String get time => 'Time';

  @override
  String get raisedByLabel => 'Raised by';

  @override
  String get approver => 'Approver';

  @override
  String get forTeamMember => 'For a driver / loadman in my team';

  @override
  String get approveNow => 'Approve now (I am their approver)';

  @override
  String get saveAndApprove => 'Save and approve';

  @override
  String get newAllowance => 'New allowance';

  @override
  String get noAllowances => 'No allowance requests.';

  @override
  String batchTitle(String name, int count) {
    return '$name · $count people';
  }

  @override
  String get monthlyTotals => 'Monthly totals (approved / requested)';

  @override
  String requestsPending(int count, int pending) {
    return '$count requests · $pending pending';
  }

  @override
  String get amountInvalid => 'Enter an amount greater than 0';

  @override
  String get commentForChangedAmount =>
      'Add a comment explaining the changed amount';

  @override
  String get requestedAmountLabel => 'Requested';

  @override
  String get approvedAmountLabel => 'Approved';

  @override
  String get viewReceipt => 'View receipt';

  @override
  String get amountToApprove => 'Amount to approve';

  @override
  String allowanceSubmitted(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count allowances sent for approval',
      one: 'Allowance sent for approval',
    );
    return '$_temp0';
  }

  @override
  String get forMyself => 'Myself';

  @override
  String get forMyTeam => 'My team';

  @override
  String get allowanceType => 'Allowance type';

  @override
  String get amount => 'Amount';

  @override
  String get amountPerPerson => 'Amount per person';

  @override
  String maxAmount(String amount) {
    return 'Up to $amount';
  }

  @override
  String batchTotal(String amount) {
    return 'Total $amount';
  }

  @override
  String get commentOrVoice => 'Add a comment or record a voice note';

  @override
  String get receiptPhoto => 'Receipt photo';

  @override
  String get microphoneDenied =>
      'Allow microphone access to record a voice note.';

  @override
  String get voiceNote => 'Voice note';

  @override
  String get voiceNoteHelp => 'Up to 2 minutes';

  @override
  String get stop => 'Stop';

  @override
  String get play => 'Play';

  @override
  String get pause => 'Pause';

  @override
  String get noVoiceNote => 'No voice note';

  @override
  String get record => 'Record';

  @override
  String get playVoiceNote => 'Play voice note';

  @override
  String get uploadPayslips => 'Upload payslips';

  @override
  String get myPayslip => 'My payslip';

  @override
  String payslipNotYet(String month) {
    return 'Your payslip for $month is not available yet.';
  }

  @override
  String uploadedOn(String when) {
    return 'Uploaded $when';
  }

  @override
  String get view => 'View';

  @override
  String get allPayslips => 'All payslips';

  @override
  String get myTeam => 'My team';

  @override
  String get search => 'Search';

  @override
  String get noPayslips => 'No payslips for this month.';

  @override
  String get versions => 'Versions';

  @override
  String get payPeriod => 'Pay period';

  @override
  String get payslipNameRule =>
      'File names must be payslip-<employee code>.pdf, for example payslip-NLS1023.pdf. A new upload for the same person and month replaces the earlier one (kept as a version).';

  @override
  String get choosePdfs => 'Choose PDF files';

  @override
  String filesChosen(int count) {
    return '$count files chosen';
  }

  @override
  String uploadingProgress(int sent, int total) {
    return 'Uploading $sent / $total…';
  }

  @override
  String uploadForPeriod(String month) {
    return 'Upload for $month';
  }

  @override
  String matchedCount(int count) {
    return '$count matched';
  }

  @override
  String replacedCount(int count) {
    return '$count replaced';
  }

  @override
  String unmatchedCount(int count) {
    return '$count unmatched';
  }

  @override
  String invalidCount(int count) {
    return '$count invalid';
  }

  @override
  String duplicateCount(int count) {
    return '$count duplicates';
  }

  @override
  String get unmatchedFiles => 'Unmatched (not stored)';

  @override
  String get invalidFiles => 'Invalid (not stored)';

  @override
  String get duplicateFiles => 'Duplicates (not stored)';

  @override
  String get matchedFiles => 'Stored';

  @override
  String get allotTask => 'Allot task';

  @override
  String get noTasks => 'No tasks.';

  @override
  String get highPriority => 'High priority';

  @override
  String get allottedBy => 'Allotted by';

  @override
  String get reopened => 'Reopened';

  @override
  String submittedAt(String when) {
    return 'Submitted $when';
  }

  @override
  String get reasonRequiredNotDone =>
      'Give a reason when the task was not done';

  @override
  String get taskSubmitted => 'Task submitted';

  @override
  String get submit => 'Submit';

  @override
  String get reopenComment => 'Comment for reopening';

  @override
  String get reopen => 'Reopen';

  @override
  String tasksAllotted(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count tasks allotted',
      one: 'Task allotted',
    );
    return '$_temp0';
  }

  @override
  String get taskTitle => 'Task';

  @override
  String get details => 'Details';

  @override
  String get chooseRms => 'Choose regional managers';

  @override
  String get everyone => 'Everyone';

  @override
  String get download => 'Download';

  @override
  String get downloadExcel => 'Excel (.xlsx)';

  @override
  String get downloadPdf => 'PDF';

  @override
  String get muster => 'Muster';

  @override
  String get summary => 'Summary';

  @override
  String get noReportRows => 'No attendance for this selection.';

  @override
  String get resetPassword => 'Reset password';

  @override
  String get newPassword => 'New password';

  @override
  String passwordRule(int min) {
    return 'At least $min characters';
  }

  @override
  String get newUser => 'New user';

  @override
  String lastLogin(String when) {
    return 'last login $when';
  }

  @override
  String get inactive => 'Inactive';

  @override
  String get locked => 'Locked';

  @override
  String get passwordReset => 'Password reset. Their sessions were signed out.';

  @override
  String get unlocked => 'Unlocked';

  @override
  String get deactivated => 'Deactivated';

  @override
  String get activated => 'Activated';

  @override
  String get unlock => 'Unlock';

  @override
  String get deactivate => 'Deactivate';

  @override
  String get activate => 'Activate';

  @override
  String userCreated(String name) {
    return '$name can now sign in';
  }

  @override
  String get role => 'Role';

  @override
  String get primaryHint =>
      'Tap the circle to choose the primary business unit (own attendance, leave and payslips belong to it).';

  @override
  String reportsToLabel(String role) {
    return 'Reports to ($role)';
  }

  @override
  String get initialPassword => 'Initial password';

  @override
  String get createUser => 'Create user';

  @override
  String get email => 'Email';

  @override
  String get passwordByDirector =>
      'To change your password, contact your Director.';

  @override
  String get signOutConfirm => 'Sign out of this device?';

  @override
  String appVersion(String version) {
    return 'App version $version';
  }

  @override
  String peopleCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count people',
      one: '1 person',
    );
    return '$_temp0';
  }
}
