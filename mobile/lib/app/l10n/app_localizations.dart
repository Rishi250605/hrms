import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[Locale('en')];

  /// No description provided for @appTitle.
  ///
  /// In en, this message translates to:
  /// **'Transport HRMS'**
  String get appTitle;

  /// No description provided for @retry.
  ///
  /// In en, this message translates to:
  /// **'Retry'**
  String get retry;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @logout.
  ///
  /// In en, this message translates to:
  /// **'Sign out'**
  String get logout;

  /// No description provided for @loadingSession.
  ///
  /// In en, this message translates to:
  /// **'Signing you in…'**
  String get loadingSession;

  /// No description provided for @sessionLoadFailed.
  ///
  /// In en, this message translates to:
  /// **'Could not reach the server. Check your connection and try again.'**
  String get sessionLoadFailed;

  /// No description provided for @loginTitle.
  ///
  /// In en, this message translates to:
  /// **'Sign in'**
  String get loginTitle;

  /// No description provided for @loginSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Manager app for attendance, leave, allowances, payslips and tasks'**
  String get loginSubtitle;

  /// No description provided for @phoneLabel.
  ///
  /// In en, this message translates to:
  /// **'Mobile number'**
  String get phoneLabel;

  /// No description provided for @phoneHint.
  ///
  /// In en, this message translates to:
  /// **'98765 43210'**
  String get phoneHint;

  /// No description provided for @phoneInvalid.
  ///
  /// In en, this message translates to:
  /// **'Enter a valid 10-digit mobile number'**
  String get phoneInvalid;

  /// No description provided for @sendOtp.
  ///
  /// In en, this message translates to:
  /// **'Send OTP'**
  String get sendOtp;

  /// No description provided for @otpSentTo.
  ///
  /// In en, this message translates to:
  /// **'Enter the 6-digit OTP sent to {phone}'**
  String otpSentTo(String phone);

  /// No description provided for @otpLabel.
  ///
  /// In en, this message translates to:
  /// **'OTP'**
  String get otpLabel;

  /// No description provided for @otpInvalid.
  ///
  /// In en, this message translates to:
  /// **'Enter the 6-digit OTP'**
  String get otpInvalid;

  /// No description provided for @verify.
  ///
  /// In en, this message translates to:
  /// **'Verify and sign in'**
  String get verify;

  /// No description provided for @changeNumber.
  ///
  /// In en, this message translates to:
  /// **'Change number'**
  String get changeNumber;

  /// No description provided for @resendOtp.
  ///
  /// In en, this message translates to:
  /// **'Resend OTP'**
  String get resendOtp;

  /// No description provided for @resendIn.
  ///
  /// In en, this message translates to:
  /// **'Resend in {seconds}s'**
  String resendIn(int seconds);

  /// No description provided for @errorNetwork.
  ///
  /// In en, this message translates to:
  /// **'No connection to the server. Check your network and try again.'**
  String get errorNetwork;

  /// No description provided for @errorUnknown.
  ///
  /// In en, this message translates to:
  /// **'Something went wrong. Please try again.'**
  String get errorUnknown;

  /// No description provided for @errorSessionExpired.
  ///
  /// In en, this message translates to:
  /// **'Your session has expired. Please sign in again.'**
  String get errorSessionExpired;

  /// No description provided for @navHome.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get navHome;

  /// No description provided for @navRoster.
  ///
  /// In en, this message translates to:
  /// **'Roster'**
  String get navRoster;

  /// No description provided for @navAttendance.
  ///
  /// In en, this message translates to:
  /// **'Attendance'**
  String get navAttendance;

  /// No description provided for @navRequests.
  ///
  /// In en, this message translates to:
  /// **'Requests'**
  String get navRequests;

  /// No description provided for @navApprovals.
  ///
  /// In en, this message translates to:
  /// **'Approvals'**
  String get navApprovals;

  /// No description provided for @navDepots.
  ///
  /// In en, this message translates to:
  /// **'Depots'**
  String get navDepots;

  /// No description provided for @navReports.
  ///
  /// In en, this message translates to:
  /// **'Reports'**
  String get navReports;

  /// No description provided for @navEmployees.
  ///
  /// In en, this message translates to:
  /// **'Employees'**
  String get navEmployees;

  /// No description provided for @navPayroll.
  ///
  /// In en, this message translates to:
  /// **'Payroll'**
  String get navPayroll;

  /// No description provided for @navMore.
  ///
  /// In en, this message translates to:
  /// **'More'**
  String get navMore;

  /// No description provided for @roleOperationalManager.
  ///
  /// In en, this message translates to:
  /// **'Operational manager'**
  String get roleOperationalManager;

  /// No description provided for @roleRegionalManager.
  ///
  /// In en, this message translates to:
  /// **'Regional manager'**
  String get roleRegionalManager;

  /// No description provided for @roleOperationalHead.
  ///
  /// In en, this message translates to:
  /// **'Operational head'**
  String get roleOperationalHead;

  /// No description provided for @roleHr.
  ///
  /// In en, this message translates to:
  /// **'HR'**
  String get roleHr;

  /// No description provided for @homeGreeting.
  ///
  /// In en, this message translates to:
  /// **'Hello, {name}'**
  String homeGreeting(String name);

  /// No description provided for @comingInPhase.
  ///
  /// In en, this message translates to:
  /// **'Available in phase {phase}'**
  String comingInPhase(int phase);

  /// No description provided for @featureComingSoonTitle.
  ///
  /// In en, this message translates to:
  /// **'{feature} is on the way'**
  String featureComingSoonTitle(String feature);

  /// No description provided for @omCardDuties.
  ///
  /// In en, this message translates to:
  /// **'Today\'s duties'**
  String get omCardDuties;

  /// No description provided for @omCardAttendance.
  ///
  /// In en, this message translates to:
  /// **'Mark attendance'**
  String get omCardAttendance;

  /// No description provided for @omCardExpiring.
  ///
  /// In en, this message translates to:
  /// **'Expiring documents in my depots'**
  String get omCardExpiring;

  /// No description provided for @omCardMyRequests.
  ///
  /// In en, this message translates to:
  /// **'Requests I raised'**
  String get omCardMyRequests;

  /// No description provided for @rmCardApprovals.
  ///
  /// In en, this message translates to:
  /// **'Approvals inbox'**
  String get rmCardApprovals;

  /// No description provided for @rmCardNoShows.
  ///
  /// In en, this message translates to:
  /// **'No-shows and unfilled duties'**
  String get rmCardNoShows;

  /// No description provided for @rmCardExpiryRisk.
  ///
  /// In en, this message translates to:
  /// **'Expiry risk by depot'**
  String get rmCardExpiryRisk;

  /// No description provided for @headCardAttendance.
  ///
  /// In en, this message translates to:
  /// **'Attendance %'**
  String get headCardAttendance;

  /// No description provided for @headCardOt.
  ///
  /// In en, this message translates to:
  /// **'OT hours and cost'**
  String get headCardOt;

  /// No description provided for @headCardUnfilled.
  ///
  /// In en, this message translates to:
  /// **'Duties unfilled'**
  String get headCardUnfilled;

  /// No description provided for @headCardIdleVehicles.
  ///
  /// In en, this message translates to:
  /// **'Vehicles idle for lack of drivers'**
  String get headCardIdleVehicles;

  /// No description provided for @headCardApprovals.
  ///
  /// In en, this message translates to:
  /// **'Approvals needing your sign-off'**
  String get headCardApprovals;

  /// No description provided for @hrCardVerify.
  ///
  /// In en, this message translates to:
  /// **'Documents to verify'**
  String get hrCardVerify;

  /// No description provided for @hrCardJoinersLeavers.
  ///
  /// In en, this message translates to:
  /// **'Joiners and leavers'**
  String get hrCardJoinersLeavers;

  /// No description provided for @hrCardPayroll.
  ///
  /// In en, this message translates to:
  /// **'Payroll run status'**
  String get hrCardPayroll;

  /// No description provided for @hrCardExpiring.
  ///
  /// In en, this message translates to:
  /// **'Expiring documents (company-wide)'**
  String get hrCardExpiring;

  /// No description provided for @profileTitle.
  ///
  /// In en, this message translates to:
  /// **'My profile'**
  String get profileTitle;

  /// No description provided for @superAdmin.
  ///
  /// In en, this message translates to:
  /// **'Super admin'**
  String get superAdmin;

  /// No description provided for @scopeTitle.
  ///
  /// In en, this message translates to:
  /// **'My data scope'**
  String get scopeTitle;

  /// No description provided for @scopeCompanyWide.
  ///
  /// In en, this message translates to:
  /// **'Company-wide access'**
  String get scopeCompanyWide;

  /// No description provided for @scopeRegions.
  ///
  /// In en, this message translates to:
  /// **'Regions'**
  String get scopeRegions;

  /// No description provided for @scopeDepots.
  ///
  /// In en, this message translates to:
  /// **'Depots'**
  String get scopeDepots;

  /// No description provided for @scopeNone.
  ///
  /// In en, this message translates to:
  /// **'No depots or regions assigned yet. Ask HR to set your scope.'**
  String get scopeNone;

  /// No description provided for @navDocuments.
  ///
  /// In en, this message translates to:
  /// **'Verify'**
  String get navDocuments;

  /// No description provided for @navFleet.
  ///
  /// In en, this message translates to:
  /// **'Fleet'**
  String get navFleet;

  /// No description provided for @navNotifications.
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get navNotifications;

  /// No description provided for @ok.
  ///
  /// In en, this message translates to:
  /// **'OK'**
  String get ok;

  /// No description provided for @save.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get save;

  /// No description provided for @saved.
  ///
  /// In en, this message translates to:
  /// **'Saved'**
  String get saved;

  /// No description provided for @next.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get next;

  /// No description provided for @back.
  ///
  /// In en, this message translates to:
  /// **'Back'**
  String get back;

  /// No description provided for @remove.
  ///
  /// In en, this message translates to:
  /// **'Remove'**
  String get remove;

  /// No description provided for @dismiss.
  ///
  /// In en, this message translates to:
  /// **'Dismiss'**
  String get dismiss;

  /// No description provided for @none.
  ///
  /// In en, this message translates to:
  /// **'None'**
  String get none;

  /// No description provided for @optional.
  ///
  /// In en, this message translates to:
  /// **'Optional'**
  String get optional;

  /// No description provided for @required.
  ///
  /// In en, this message translates to:
  /// **'Required'**
  String get required;

  /// No description provided for @invalidValue.
  ///
  /// In en, this message translates to:
  /// **'Invalid value'**
  String get invalidValue;

  /// No description provided for @reason.
  ///
  /// In en, this message translates to:
  /// **'Reason'**
  String get reason;

  /// No description provided for @comment.
  ///
  /// In en, this message translates to:
  /// **'Comment'**
  String get comment;

  /// No description provided for @date.
  ///
  /// In en, this message translates to:
  /// **'Date'**
  String get date;

  /// No description provided for @today.
  ///
  /// In en, this message translates to:
  /// **'Today'**
  String get today;

  /// No description provided for @thisMonth.
  ///
  /// In en, this message translates to:
  /// **'This month'**
  String get thisMonth;

  /// No description provided for @depot.
  ///
  /// In en, this message translates to:
  /// **'Depot'**
  String get depot;

  /// No description provided for @employee.
  ///
  /// In en, this message translates to:
  /// **'Employee'**
  String get employee;

  /// No description provided for @moreActions.
  ///
  /// In en, this message translates to:
  /// **'More'**
  String get moreActions;

  /// No description provided for @filterAll.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get filterAll;

  /// No description provided for @cancelled.
  ///
  /// In en, this message translates to:
  /// **'Cancelled'**
  String get cancelled;

  /// No description provided for @catDriver.
  ///
  /// In en, this message translates to:
  /// **'Driver'**
  String get catDriver;

  /// No description provided for @catConductor.
  ///
  /// In en, this message translates to:
  /// **'Conductor'**
  String get catConductor;

  /// No description provided for @catHelper.
  ///
  /// In en, this message translates to:
  /// **'Helper'**
  String get catHelper;

  /// No description provided for @catMechanic.
  ///
  /// In en, this message translates to:
  /// **'Mechanic'**
  String get catMechanic;

  /// No description provided for @catDepotStaff.
  ///
  /// In en, this message translates to:
  /// **'Depot staff'**
  String get catDepotStaff;

  /// No description provided for @catOffice.
  ///
  /// In en, this message translates to:
  /// **'Office'**
  String get catOffice;

  /// No description provided for @empPermanent.
  ///
  /// In en, this message translates to:
  /// **'Permanent'**
  String get empPermanent;

  /// No description provided for @empFixedTerm.
  ///
  /// In en, this message translates to:
  /// **'Fixed term'**
  String get empFixedTerm;

  /// No description provided for @empContract.
  ///
  /// In en, this message translates to:
  /// **'Contract'**
  String get empContract;

  /// No description provided for @statusActive.
  ///
  /// In en, this message translates to:
  /// **'Active'**
  String get statusActive;

  /// No description provided for @statusOnNotice.
  ///
  /// In en, this message translates to:
  /// **'On notice'**
  String get statusOnNotice;

  /// No description provided for @statusExited.
  ///
  /// In en, this message translates to:
  /// **'Exited'**
  String get statusExited;

  /// No description provided for @statusSuspended.
  ///
  /// In en, this message translates to:
  /// **'Suspended'**
  String get statusSuspended;

  /// No description provided for @docDrivingLicence.
  ///
  /// In en, this message translates to:
  /// **'Driving licence'**
  String get docDrivingLicence;

  /// No description provided for @docPsvBadge.
  ///
  /// In en, this message translates to:
  /// **'PSV badge'**
  String get docPsvBadge;

  /// No description provided for @docMedical.
  ///
  /// In en, this message translates to:
  /// **'Medical fitness'**
  String get docMedical;

  /// No description provided for @docPolice.
  ///
  /// In en, this message translates to:
  /// **'Police verification'**
  String get docPolice;

  /// No description provided for @docAadhaar.
  ///
  /// In en, this message translates to:
  /// **'Aadhaar'**
  String get docAadhaar;

  /// No description provided for @docPan.
  ///
  /// In en, this message translates to:
  /// **'PAN'**
  String get docPan;

  /// No description provided for @docTraining.
  ///
  /// In en, this message translates to:
  /// **'Training certificate'**
  String get docTraining;

  /// No description provided for @docOther.
  ///
  /// In en, this message translates to:
  /// **'Other'**
  String get docOther;

  /// No description provided for @docStatusPending.
  ///
  /// In en, this message translates to:
  /// **'Pending verification'**
  String get docStatusPending;

  /// No description provided for @docStatusVerified.
  ///
  /// In en, this message translates to:
  /// **'Verified'**
  String get docStatusVerified;

  /// No description provided for @docStatusRejected.
  ///
  /// In en, this message translates to:
  /// **'Rejected'**
  String get docStatusRejected;

  /// No description provided for @docStatusExpired.
  ///
  /// In en, this message translates to:
  /// **'Expired'**
  String get docStatusExpired;

  /// No description provided for @complianceOk.
  ///
  /// In en, this message translates to:
  /// **'Documents OK'**
  String get complianceOk;

  /// No description provided for @complianceExpiring.
  ///
  /// In en, this message translates to:
  /// **'Expiring'**
  String get complianceExpiring;

  /// No description provided for @compliancePending.
  ///
  /// In en, this message translates to:
  /// **'Pending verification'**
  String get compliancePending;

  /// No description provided for @complianceExpired.
  ///
  /// In en, this message translates to:
  /// **'Expired'**
  String get complianceExpired;

  /// No description provided for @complianceMissing.
  ///
  /// In en, this message translates to:
  /// **'Missing'**
  String get complianceMissing;

  /// No description provided for @stateValid.
  ///
  /// In en, this message translates to:
  /// **'Valid'**
  String get stateValid;

  /// No description provided for @stateExpiring.
  ///
  /// In en, this message translates to:
  /// **'Expiring'**
  String get stateExpiring;

  /// No description provided for @stateUnverified.
  ///
  /// In en, this message translates to:
  /// **'Unverified'**
  String get stateUnverified;

  /// No description provided for @stateExpired.
  ///
  /// In en, this message translates to:
  /// **'Expired'**
  String get stateExpired;

  /// No description provided for @stateRejected.
  ///
  /// In en, this message translates to:
  /// **'Rejected'**
  String get stateRejected;

  /// No description provided for @stateMissing.
  ///
  /// In en, this message translates to:
  /// **'Missing'**
  String get stateMissing;

  /// No description provided for @attPresent.
  ///
  /// In en, this message translates to:
  /// **'Present'**
  String get attPresent;

  /// No description provided for @attAbsent.
  ///
  /// In en, this message translates to:
  /// **'Absent'**
  String get attAbsent;

  /// No description provided for @attHalfDay.
  ///
  /// In en, this message translates to:
  /// **'Half day'**
  String get attHalfDay;

  /// No description provided for @attOnLeave.
  ///
  /// In en, this message translates to:
  /// **'On leave'**
  String get attOnLeave;

  /// No description provided for @attWeeklyOff.
  ///
  /// In en, this message translates to:
  /// **'Weekly off'**
  String get attWeeklyOff;

  /// No description provided for @attHoliday.
  ///
  /// In en, this message translates to:
  /// **'Holiday'**
  String get attHoliday;

  /// No description provided for @attOutstation.
  ///
  /// In en, this message translates to:
  /// **'On duty (outstation)'**
  String get attOutstation;

  /// No description provided for @attPresentShort.
  ///
  /// In en, this message translates to:
  /// **'P'**
  String get attPresentShort;

  /// No description provided for @attAbsentShort.
  ///
  /// In en, this message translates to:
  /// **'A'**
  String get attAbsentShort;

  /// No description provided for @attHalfDayShort.
  ///
  /// In en, this message translates to:
  /// **'½'**
  String get attHalfDayShort;

  /// No description provided for @attOnLeaveShort.
  ///
  /// In en, this message translates to:
  /// **'L'**
  String get attOnLeaveShort;

  /// No description provided for @attWeeklyOffShort.
  ///
  /// In en, this message translates to:
  /// **'WO'**
  String get attWeeklyOffShort;

  /// No description provided for @attHolidayShort.
  ///
  /// In en, this message translates to:
  /// **'H'**
  String get attHolidayShort;

  /// No description provided for @attOutstationShort.
  ///
  /// In en, this message translates to:
  /// **'OD'**
  String get attOutstationShort;

  /// No description provided for @apprPending.
  ///
  /// In en, this message translates to:
  /// **'Pending'**
  String get apprPending;

  /// No description provided for @apprApproved.
  ///
  /// In en, this message translates to:
  /// **'Approved'**
  String get apprApproved;

  /// No description provided for @apprRejected.
  ///
  /// In en, this message translates to:
  /// **'Rejected'**
  String get apprRejected;

  /// No description provided for @apprCancelled.
  ///
  /// In en, this message translates to:
  /// **'Withdrawn'**
  String get apprCancelled;

  /// No description provided for @entityLeave.
  ///
  /// In en, this message translates to:
  /// **'Leave'**
  String get entityLeave;

  /// No description provided for @entityCorrection.
  ///
  /// In en, this message translates to:
  /// **'Attendance correction'**
  String get entityCorrection;

  /// No description provided for @entityAdvance.
  ///
  /// In en, this message translates to:
  /// **'Advance'**
  String get entityAdvance;

  /// No description provided for @entitySwap.
  ///
  /// In en, this message translates to:
  /// **'Duty swap'**
  String get entitySwap;

  /// No description provided for @entityRecovery.
  ///
  /// In en, this message translates to:
  /// **'Recovery'**
  String get entityRecovery;

  /// No description provided for @entityPolicyException.
  ///
  /// In en, this message translates to:
  /// **'Policy exception'**
  String get entityPolicyException;

  /// No description provided for @roleDriver.
  ///
  /// In en, this message translates to:
  /// **'Driver'**
  String get roleDriver;

  /// No description provided for @roleCoDriver.
  ///
  /// In en, this message translates to:
  /// **'Co-driver'**
  String get roleCoDriver;

  /// No description provided for @roleConductor.
  ///
  /// In en, this message translates to:
  /// **'Conductor'**
  String get roleConductor;

  /// No description provided for @roleHelper.
  ///
  /// In en, this message translates to:
  /// **'Helper'**
  String get roleHelper;

  /// No description provided for @employeesSearchHint.
  ///
  /// In en, this message translates to:
  /// **'Name, employee code or phone'**
  String get employeesSearchHint;

  /// No description provided for @employeesEmpty.
  ///
  /// In en, this message translates to:
  /// **'No employees match.'**
  String get employeesEmpty;

  /// No description provided for @employeesSelectHint.
  ///
  /// In en, this message translates to:
  /// **'Select an employee to see their profile.'**
  String get employeesSelectHint;

  /// No description provided for @employeeProfile.
  ///
  /// In en, this message translates to:
  /// **'Employee'**
  String get employeeProfile;

  /// No description provided for @employeeCreated.
  ///
  /// In en, this message translates to:
  /// **'{name} added'**
  String employeeCreated(String name);

  /// No description provided for @complianceTitle.
  ///
  /// In en, this message translates to:
  /// **'Required documents'**
  String get complianceTitle;

  /// No description provided for @noRequiredDocuments.
  ///
  /// In en, this message translates to:
  /// **'No documents are required for this category.'**
  String get noRequiredDocuments;

  /// No description provided for @notRosterable.
  ///
  /// In en, this message translates to:
  /// **'Cannot be rostered until every required document is valid.'**
  String get notRosterable;

  /// No description provided for @documentsTitle.
  ///
  /// In en, this message translates to:
  /// **'Documents'**
  String get documentsTitle;

  /// No description provided for @noDocuments.
  ///
  /// In en, this message translates to:
  /// **'No documents yet.'**
  String get noDocuments;

  /// No description provided for @validUntil.
  ///
  /// In en, this message translates to:
  /// **'Valid until {date}'**
  String validUntil(String date);

  /// No description provided for @rejectedBecause.
  ///
  /// In en, this message translates to:
  /// **'Rejected: {reason}'**
  String rejectedBecause(String reason);

  /// No description provided for @viewFile.
  ///
  /// In en, this message translates to:
  /// **'View file'**
  String get viewFile;

  /// No description provided for @jobHistory.
  ///
  /// In en, this message translates to:
  /// **'Job history'**
  String get jobHistory;

  /// No description provided for @jobFromOpen.
  ///
  /// In en, this message translates to:
  /// **'From {from}'**
  String jobFromOpen(String from);

  /// No description provided for @jobRange.
  ///
  /// In en, this message translates to:
  /// **'{from} – {to}'**
  String jobRange(String from, String to);

  /// No description provided for @reportsTo.
  ///
  /// In en, this message translates to:
  /// **'Reports to {name}'**
  String reportsTo(String name);

  /// No description provided for @personalDetails.
  ///
  /// In en, this message translates to:
  /// **'Personal details'**
  String get personalDetails;

  /// No description provided for @joiningDate.
  ///
  /// In en, this message translates to:
  /// **'Joining date'**
  String get joiningDate;

  /// No description provided for @exitDate.
  ///
  /// In en, this message translates to:
  /// **'Exit date'**
  String get exitDate;

  /// No description provided for @employmentTypeLabel.
  ///
  /// In en, this message translates to:
  /// **'Employment type'**
  String get employmentTypeLabel;

  /// No description provided for @contractor.
  ///
  /// In en, this message translates to:
  /// **'Contractor'**
  String get contractor;

  /// No description provided for @aadhaarLast4.
  ///
  /// In en, this message translates to:
  /// **'Aadhaar (last 4 digits)'**
  String get aadhaarLast4;

  /// No description provided for @aadhaarHelper.
  ///
  /// In en, this message translates to:
  /// **'Only the last 4 digits are stored.'**
  String get aadhaarHelper;

  /// No description provided for @aadhaarLast4Invalid.
  ///
  /// In en, this message translates to:
  /// **'Enter the last 4 digits'**
  String get aadhaarLast4Invalid;

  /// No description provided for @addDocument.
  ///
  /// In en, this message translates to:
  /// **'Add document'**
  String get addDocument;

  /// No description provided for @raiseLeave.
  ///
  /// In en, this message translates to:
  /// **'Raise leave'**
  String get raiseLeave;

  /// No description provided for @documentSaved.
  ///
  /// In en, this message translates to:
  /// **'Document saved. HR will verify it.'**
  String get documentSaved;

  /// No description provided for @changeJob.
  ///
  /// In en, this message translates to:
  /// **'Transfer / change job'**
  String get changeJob;

  /// No description provided for @recordExit.
  ///
  /// In en, this message translates to:
  /// **'Record exit'**
  String get recordExit;

  /// No description provided for @effectiveFrom.
  ///
  /// In en, this message translates to:
  /// **'Effective from'**
  String get effectiveFrom;

  /// No description provided for @depotUnchanged.
  ///
  /// In en, this message translates to:
  /// **'Depot (leave empty to keep)'**
  String get depotUnchanged;

  /// No description provided for @designation.
  ///
  /// In en, this message translates to:
  /// **'Designation'**
  String get designation;

  /// No description provided for @grade.
  ///
  /// In en, this message translates to:
  /// **'Grade'**
  String get grade;

  /// No description provided for @lastWorkingDay.
  ///
  /// In en, this message translates to:
  /// **'Last working day'**
  String get lastWorkingDay;

  /// No description provided for @documentTypeLabel.
  ///
  /// In en, this message translates to:
  /// **'Document type'**
  String get documentTypeLabel;

  /// No description provided for @documentNumber.
  ///
  /// In en, this message translates to:
  /// **'Document number'**
  String get documentNumber;

  /// No description provided for @licenceClass.
  ///
  /// In en, this message translates to:
  /// **'Licence class'**
  String get licenceClass;

  /// No description provided for @issueDate.
  ///
  /// In en, this message translates to:
  /// **'Issue date'**
  String get issueDate;

  /// No description provided for @expiryDate.
  ///
  /// In en, this message translates to:
  /// **'Expiry date'**
  String get expiryDate;

  /// No description provided for @takePhoto.
  ///
  /// In en, this message translates to:
  /// **'Take photo'**
  String get takePhoto;

  /// No description provided for @chooseFile.
  ///
  /// In en, this message translates to:
  /// **'Choose photo'**
  String get chooseFile;

  /// No description provided for @photoRequired.
  ///
  /// In en, this message translates to:
  /// **'Take or choose a photo of the document.'**
  String get photoRequired;

  /// No description provided for @saveForVerification.
  ///
  /// In en, this message translates to:
  /// **'Save for verification'**
  String get saveForVerification;

  /// No description provided for @onboardTitle.
  ///
  /// In en, this message translates to:
  /// **'Onboard employee'**
  String get onboardTitle;

  /// No description provided for @stepPersonal.
  ///
  /// In en, this message translates to:
  /// **'Personal'**
  String get stepPersonal;

  /// No description provided for @stepJob.
  ///
  /// In en, this message translates to:
  /// **'Job'**
  String get stepJob;

  /// No description provided for @stepStatutory.
  ///
  /// In en, this message translates to:
  /// **'Statutory and bank'**
  String get stepStatutory;

  /// No description provided for @stepReview.
  ///
  /// In en, this message translates to:
  /// **'Review'**
  String get stepReview;

  /// No description provided for @empCode.
  ///
  /// In en, this message translates to:
  /// **'Employee ID'**
  String get empCode;

  /// No description provided for @fullName.
  ///
  /// In en, this message translates to:
  /// **'Full name'**
  String get fullName;

  /// No description provided for @categoryLabel.
  ///
  /// In en, this message translates to:
  /// **'Category'**
  String get categoryLabel;

  /// No description provided for @dob.
  ///
  /// In en, this message translates to:
  /// **'Date of birth'**
  String get dob;

  /// No description provided for @gender.
  ///
  /// In en, this message translates to:
  /// **'Gender'**
  String get gender;

  /// No description provided for @genderMale.
  ///
  /// In en, this message translates to:
  /// **'Male'**
  String get genderMale;

  /// No description provided for @genderFemale.
  ///
  /// In en, this message translates to:
  /// **'Female'**
  String get genderFemale;

  /// No description provided for @genderOther.
  ///
  /// In en, this message translates to:
  /// **'Other'**
  String get genderOther;

  /// No description provided for @channelWhatsapp.
  ///
  /// In en, this message translates to:
  /// **'WhatsApp'**
  String get channelWhatsapp;

  /// No description provided for @channelSms.
  ///
  /// In en, this message translates to:
  /// **'SMS'**
  String get channelSms;

  /// No description provided for @reportingManager.
  ///
  /// In en, this message translates to:
  /// **'Reporting manager'**
  String get reportingManager;

  /// No description provided for @bankAccount.
  ///
  /// In en, this message translates to:
  /// **'Bank account number'**
  String get bankAccount;

  /// No description provided for @createEmployee.
  ///
  /// In en, this message translates to:
  /// **'Create employee'**
  String get createEmployee;

  /// No description provided for @verifyQueueTitle.
  ///
  /// In en, this message translates to:
  /// **'Documents to verify'**
  String get verifyQueueTitle;

  /// No description provided for @verifyQueueEmpty.
  ///
  /// In en, this message translates to:
  /// **'Nothing to verify. 🎉'**
  String get verifyQueueEmpty;

  /// No description provided for @verifyDocument.
  ///
  /// In en, this message translates to:
  /// **'Verify'**
  String get verifyDocument;

  /// No description provided for @reject.
  ///
  /// In en, this message translates to:
  /// **'Reject'**
  String get reject;

  /// No description provided for @rejectDocument.
  ///
  /// In en, this message translates to:
  /// **'Reject document'**
  String get rejectDocument;

  /// No description provided for @rejectReason.
  ///
  /// In en, this message translates to:
  /// **'Why is it rejected? (the manager will see this)'**
  String get rejectReason;

  /// No description provided for @noFile.
  ///
  /// In en, this message translates to:
  /// **'No file attached'**
  String get noFile;

  /// No description provided for @openFile.
  ///
  /// In en, this message translates to:
  /// **'Open file'**
  String get openFile;

  /// No description provided for @unfilledCount.
  ///
  /// In en, this message translates to:
  /// **'{count} unfilled'**
  String unfilledCount(int count);

  /// No description provided for @filledCount.
  ///
  /// In en, this message translates to:
  /// **'{count} filled'**
  String filledCount(int count);

  /// No description provided for @dutiesCount.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 duty} other{{count} duties}}'**
  String dutiesCount(int count);

  /// No description provided for @expiredCount.
  ///
  /// In en, this message translates to:
  /// **'{count} expired'**
  String expiredCount(int count);

  /// No description provided for @allFilled.
  ///
  /// In en, this message translates to:
  /// **'All filled'**
  String get allFilled;

  /// No description provided for @pendingToday.
  ///
  /// In en, this message translates to:
  /// **'Pending today'**
  String get pendingToday;

  /// No description provided for @pendingApproval.
  ///
  /// In en, this message translates to:
  /// **'Pending approval'**
  String get pendingApproval;

  /// No description provided for @noShowsUnfilled.
  ///
  /// In en, this message translates to:
  /// **'No-shows / unfilled today'**
  String get noShowsUnfilled;

  /// No description provided for @depotComparison.
  ///
  /// In en, this message translates to:
  /// **'Depots'**
  String get depotComparison;

  /// No description provided for @unfilled.
  ///
  /// In en, this message translates to:
  /// **'Unfilled'**
  String get unfilled;

  /// No description provided for @noShows.
  ///
  /// In en, this message translates to:
  /// **'No-shows'**
  String get noShows;

  /// No description provided for @attendancePendingShort.
  ///
  /// In en, this message translates to:
  /// **'Unmarked'**
  String get attendancePendingShort;

  /// No description provided for @expiring.
  ///
  /// In en, this message translates to:
  /// **'Expiring'**
  String get expiring;

  /// No description provided for @expired.
  ///
  /// In en, this message translates to:
  /// **'Expired'**
  String get expired;

  /// No description provided for @markAllRead.
  ///
  /// In en, this message translates to:
  /// **'Mark all read'**
  String get markAllRead;

  /// No description provided for @noNotifications.
  ///
  /// In en, this message translates to:
  /// **'No notifications.'**
  String get noNotifications;

  /// No description provided for @addDuty.
  ///
  /// In en, this message translates to:
  /// **'Add duty'**
  String get addDuty;

  /// No description provided for @copyPreviousDay.
  ///
  /// In en, this message translates to:
  /// **'Copy previous day'**
  String get copyPreviousDay;

  /// No description provided for @copyDone.
  ///
  /// In en, this message translates to:
  /// **'Roster copied'**
  String get copyDone;

  /// No description provided for @copySummary.
  ///
  /// In en, this message translates to:
  /// **'{duties} duties and {crew} crew assignments copied. {existing} duties were already there.'**
  String copySummary(int duties, int crew, int existing);

  /// No description provided for @copySkipped.
  ///
  /// In en, this message translates to:
  /// **'Not copied:'**
  String get copySkipped;

  /// No description provided for @noDuties.
  ///
  /// In en, this message translates to:
  /// **'No duties for this day. Add one or copy the previous day.'**
  String get noDuties;

  /// No description provided for @noVehicle.
  ///
  /// In en, this message translates to:
  /// **'No vehicle'**
  String get noVehicle;

  /// No description provided for @duty.
  ///
  /// In en, this message translates to:
  /// **'Duty'**
  String get duty;

  /// No description provided for @crew.
  ///
  /// In en, this message translates to:
  /// **'Crew'**
  String get crew;

  /// No description provided for @noCrew.
  ///
  /// In en, this message translates to:
  /// **'No one assigned yet.'**
  String get noCrew;

  /// No description provided for @assignRole.
  ///
  /// In en, this message translates to:
  /// **'Assign {role}'**
  String assignRole(String role);

  /// No description provided for @cancelDuty.
  ///
  /// In en, this message translates to:
  /// **'Cancel duty'**
  String get cancelDuty;

  /// No description provided for @assignedWithWarnings.
  ///
  /// In en, this message translates to:
  /// **'{name} assigned, with warnings'**
  String assignedWithWarnings(String name);

  /// No description provided for @documentsBlock.
  ///
  /// In en, this message translates to:
  /// **'{name} cannot be rostered: documents are not valid on this date.'**
  String documentsBlock(String name);

  /// No description provided for @trySpares.
  ///
  /// In en, this message translates to:
  /// **'Available spares:'**
  String get trySpares;

  /// No description provided for @suggestedSpares.
  ///
  /// In en, this message translates to:
  /// **'Suggested spares'**
  String get suggestedSpares;

  /// No description provided for @noSpares.
  ///
  /// In en, this message translates to:
  /// **'No spares available.'**
  String get noSpares;

  /// No description provided for @allEmployees.
  ///
  /// In en, this message translates to:
  /// **'All employees'**
  String get allEmployees;

  /// No description provided for @hoursLast7Days.
  ///
  /// In en, this message translates to:
  /// **'{hours} h in last 7 days'**
  String hoursLast7Days(String hours);

  /// No description provided for @dutyTemplate.
  ///
  /// In en, this message translates to:
  /// **'Template'**
  String get dutyTemplate;

  /// No description provided for @customTimes.
  ///
  /// In en, this message translates to:
  /// **'Custom times'**
  String get customTimes;

  /// No description provided for @start.
  ///
  /// In en, this message translates to:
  /// **'Start'**
  String get start;

  /// No description provided for @end.
  ///
  /// In en, this message translates to:
  /// **'End'**
  String get end;

  /// No description provided for @endsNextDay.
  ///
  /// In en, this message translates to:
  /// **'Ends the next day.'**
  String get endsNextDay;

  /// No description provided for @route.
  ///
  /// In en, this message translates to:
  /// **'Route'**
  String get route;

  /// No description provided for @vehicle.
  ///
  /// In en, this message translates to:
  /// **'Vehicle'**
  String get vehicle;

  /// No description provided for @vehicles.
  ///
  /// In en, this message translates to:
  /// **'Vehicles'**
  String get vehicles;

  /// No description provided for @routes.
  ///
  /// In en, this message translates to:
  /// **'Routes'**
  String get routes;

  /// No description provided for @dutyTemplates.
  ///
  /// In en, this message translates to:
  /// **'Templates'**
  String get dutyTemplates;

  /// No description provided for @addVehicle.
  ///
  /// In en, this message translates to:
  /// **'Add vehicle'**
  String get addVehicle;

  /// No description provided for @addRoute.
  ///
  /// In en, this message translates to:
  /// **'Add route'**
  String get addRoute;

  /// No description provided for @addTemplate.
  ///
  /// In en, this message translates to:
  /// **'Add template'**
  String get addTemplate;

  /// No description provided for @regNo.
  ///
  /// In en, this message translates to:
  /// **'Registration number'**
  String get regNo;

  /// No description provided for @vehicleType.
  ///
  /// In en, this message translates to:
  /// **'Type (bus, truck, …)'**
  String get vehicleType;

  /// No description provided for @capacity.
  ///
  /// In en, this message translates to:
  /// **'Capacity'**
  String get capacity;

  /// No description provided for @code.
  ///
  /// In en, this message translates to:
  /// **'Code'**
  String get code;

  /// No description provided for @name.
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get name;

  /// No description provided for @origin.
  ///
  /// In en, this message translates to:
  /// **'From'**
  String get origin;

  /// No description provided for @destination.
  ///
  /// In en, this message translates to:
  /// **'To'**
  String get destination;

  /// No description provided for @minutes.
  ///
  /// In en, this message translates to:
  /// **'{count} min'**
  String minutes(int count);

  /// No description provided for @allPresent.
  ///
  /// In en, this message translates to:
  /// **'All present'**
  String get allPresent;

  /// No description provided for @attendanceSummary.
  ///
  /// In en, this message translates to:
  /// **'{marked} of {total} marked · {rostered} rostered'**
  String attendanceSummary(int marked, int total, int rostered);

  /// No description provided for @submitMarks.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =0{Nothing to submit} =1{Submit 1 mark} other{Submit {count} marks}}'**
  String submitMarks(int count);

  /// No description provided for @attendanceSaved.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 mark saved} other{{count} marks saved}}'**
  String attendanceSaved(int count);

  /// No description provided for @editWindowClosed.
  ///
  /// In en, this message translates to:
  /// **'The edit window for this day has closed. Request a correction to change a mark.'**
  String get editWindowClosed;

  /// No description provided for @noTeam.
  ///
  /// In en, this message translates to:
  /// **'No employees at this depot on this date.'**
  String get noTeam;

  /// No description provided for @onLeave.
  ///
  /// In en, this message translates to:
  /// **'Leave'**
  String get onLeave;

  /// No description provided for @pendingSync.
  ///
  /// In en, this message translates to:
  /// **'Pending sync'**
  String get pendingSync;

  /// No description provided for @syncFailed.
  ///
  /// In en, this message translates to:
  /// **'Not accepted'**
  String get syncFailed;

  /// No description provided for @requestCorrection.
  ///
  /// In en, this message translates to:
  /// **'Request correction'**
  String get requestCorrection;

  /// No description provided for @notMarked.
  ///
  /// In en, this message translates to:
  /// **'Not marked'**
  String get notMarked;

  /// No description provided for @offlinePending.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{Offline: 1 mark saved on this phone, waiting to sync} other{Offline: {count} marks saved on this phone, waiting to sync}}'**
  String offlinePending(int count);

  /// No description provided for @syncingPending.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{Sending 1 mark…} other{Sending {count} marks…}}'**
  String syncingPending(int count);

  /// No description provided for @syncRejected.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 mark was not accepted:} other{{count} marks were not accepted:}}'**
  String syncRejected(int count);

  /// No description provided for @myRequests.
  ///
  /// In en, this message translates to:
  /// **'My requests'**
  String get myRequests;

  /// No description provided for @newRequest.
  ///
  /// In en, this message translates to:
  /// **'New request'**
  String get newRequest;

  /// No description provided for @noRequests.
  ///
  /// In en, this message translates to:
  /// **'You have not raised any requests.'**
  String get noRequests;

  /// No description provided for @leaveRequest.
  ///
  /// In en, this message translates to:
  /// **'Leave request'**
  String get leaveRequest;

  /// No description provided for @attendanceCorrection.
  ///
  /// In en, this message translates to:
  /// **'Attendance correction'**
  String get attendanceCorrection;

  /// No description provided for @leaveType.
  ///
  /// In en, this message translates to:
  /// **'Leave type'**
  String get leaveType;

  /// No description provided for @fromDate.
  ///
  /// In en, this message translates to:
  /// **'From'**
  String get fromDate;

  /// No description provided for @toDate.
  ///
  /// In en, this message translates to:
  /// **'To'**
  String get toDate;

  /// No description provided for @startsMidday.
  ///
  /// In en, this message translates to:
  /// **'Starts at mid-day (half day)'**
  String get startsMidday;

  /// No description provided for @endsMidday.
  ///
  /// In en, this message translates to:
  /// **'Ends at mid-day (half day)'**
  String get endsMidday;

  /// No description provided for @leaveDays.
  ///
  /// In en, this message translates to:
  /// **'{days} day(s)'**
  String leaveDays(String days);

  /// No description provided for @leaveAvailable.
  ///
  /// In en, this message translates to:
  /// **'Available: {available} day(s) ({pending} pending)'**
  String leaveAvailable(String available, String pending);

  /// No description provided for @noBalanceKept.
  ///
  /// In en, this message translates to:
  /// **'No balance is kept for this leave type.'**
  String get noBalanceKept;

  /// No description provided for @submitForApproval.
  ///
  /// In en, this message translates to:
  /// **'Submit for approval'**
  String get submitForApproval;

  /// No description provided for @leaveSubmitted.
  ///
  /// In en, this message translates to:
  /// **'Leave submitted for approval'**
  String get leaveSubmitted;

  /// No description provided for @leaveApproved.
  ///
  /// In en, this message translates to:
  /// **'Leave recorded (no approval step applied)'**
  String get leaveApproved;

  /// No description provided for @correctTo.
  ///
  /// In en, this message translates to:
  /// **'Correct to'**
  String get correctTo;

  /// No description provided for @correctionSubmitted.
  ///
  /// In en, this message translates to:
  /// **'Correction submitted for approval'**
  String get correctionSubmitted;

  /// No description provided for @approvalsInbox.
  ///
  /// In en, this message translates to:
  /// **'Approvals'**
  String get approvalsInbox;

  /// No description provided for @inboxEmpty.
  ///
  /// In en, this message translates to:
  /// **'Nothing waiting for you.'**
  String get inboxEmpty;

  /// No description provided for @approve.
  ///
  /// In en, this message translates to:
  /// **'Approve'**
  String get approve;

  /// No description provided for @approvedMessage.
  ///
  /// In en, this message translates to:
  /// **'Approved'**
  String get approvedMessage;

  /// No description provided for @rejectedMessage.
  ///
  /// In en, this message translates to:
  /// **'Rejected'**
  String get rejectedMessage;

  /// No description provided for @raisedBy.
  ///
  /// In en, this message translates to:
  /// **'by {name}'**
  String raisedBy(String name);

  /// No description provided for @stepOf.
  ///
  /// In en, this message translates to:
  /// **'step {step} of {total}'**
  String stepOf(int step, int total);

  /// No description provided for @escalated.
  ///
  /// In en, this message translates to:
  /// **'escalated'**
  String get escalated;

  /// No description provided for @withdraw.
  ///
  /// In en, this message translates to:
  /// **'Withdraw request'**
  String get withdraw;

  /// No description provided for @roleDirector.
  ///
  /// In en, this message translates to:
  /// **'Director'**
  String get roleDirector;

  /// No description provided for @catLoadman.
  ///
  /// In en, this message translates to:
  /// **'Loadman'**
  String get catLoadman;

  /// No description provided for @attOnDuty.
  ///
  /// In en, this message translates to:
  /// **'On duty (OD)'**
  String get attOnDuty;

  /// No description provided for @attOnDutyShort.
  ///
  /// In en, this message translates to:
  /// **'OD'**
  String get attOnDutyShort;

  /// No description provided for @kindLeave.
  ///
  /// In en, this message translates to:
  /// **'Leave'**
  String get kindLeave;

  /// No description provided for @kindOd.
  ///
  /// In en, this message translates to:
  /// **'On duty (OD)'**
  String get kindOd;

  /// No description provided for @taskPending.
  ///
  /// In en, this message translates to:
  /// **'Pending'**
  String get taskPending;

  /// No description provided for @taskOverdue.
  ///
  /// In en, this message translates to:
  /// **'Overdue'**
  String get taskOverdue;

  /// No description provided for @taskCompleted.
  ///
  /// In en, this message translates to:
  /// **'Completed'**
  String get taskCompleted;

  /// No description provided for @taskNotDone.
  ///
  /// In en, this message translates to:
  /// **'Not done'**
  String get taskNotDone;

  /// No description provided for @navLeave.
  ///
  /// In en, this message translates to:
  /// **'Leave & OD'**
  String get navLeave;

  /// No description provided for @navAllowances.
  ///
  /// In en, this message translates to:
  /// **'Allowances'**
  String get navAllowances;

  /// No description provided for @navPayslips.
  ///
  /// In en, this message translates to:
  /// **'Payslips'**
  String get navPayslips;

  /// No description provided for @navTasks.
  ///
  /// In en, this message translates to:
  /// **'Tasks'**
  String get navTasks;

  /// No description provided for @navUsers.
  ///
  /// In en, this message translates to:
  /// **'Users'**
  String get navUsers;

  /// No description provided for @loginInvalid.
  ///
  /// In en, this message translates to:
  /// **'Invalid employee ID or password'**
  String get loginInvalid;

  /// No description provided for @loginLocked.
  ///
  /// In en, this message translates to:
  /// **'Account locked, try again in {minutes} minutes or contact your Director'**
  String loginLocked(int minutes);

  /// No description provided for @loginDisabled.
  ///
  /// In en, this message translates to:
  /// **'Your login is deactivated. Contact your Director.'**
  String get loginDisabled;

  /// No description provided for @empCodeInvalid.
  ///
  /// In en, this message translates to:
  /// **'Enter your employee ID, e.g. NLS001'**
  String get empCodeInvalid;

  /// No description provided for @password.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get password;

  /// No description provided for @showPassword.
  ///
  /// In en, this message translates to:
  /// **'Show password'**
  String get showPassword;

  /// No description provided for @hidePassword.
  ///
  /// In en, this message translates to:
  /// **'Hide password'**
  String get hidePassword;

  /// No description provided for @passwordRequired.
  ///
  /// In en, this message translates to:
  /// **'Enter your password'**
  String get passwordRequired;

  /// No description provided for @signIn.
  ///
  /// In en, this message translates to:
  /// **'Sign in'**
  String get signIn;

  /// No description provided for @forgotPasswordHint.
  ///
  /// In en, this message translates to:
  /// **'Forgot password? Contact your Director.'**
  String get forgotPasswordHint;

  /// No description provided for @businessUnit.
  ///
  /// In en, this message translates to:
  /// **'Business unit'**
  String get businessUnit;

  /// No description provided for @businessUnits.
  ///
  /// In en, this message translates to:
  /// **'Business units'**
  String get businessUnits;

  /// No description provided for @allBusinessUnits.
  ///
  /// In en, this message translates to:
  /// **'All business units'**
  String get allBusinessUnits;

  /// No description provided for @primary.
  ///
  /// In en, this message translates to:
  /// **'primary'**
  String get primary;

  /// No description provided for @chooseEmployees.
  ///
  /// In en, this message translates to:
  /// **'Choose people'**
  String get chooseEmployees;

  /// No description provided for @selectedCount.
  ///
  /// In en, this message translates to:
  /// **'Done ({count})'**
  String selectedCount(int count);

  /// No description provided for @myAttendanceToday.
  ///
  /// In en, this message translates to:
  /// **'My attendance today'**
  String get myAttendanceToday;

  /// No description provided for @tapToMark.
  ///
  /// In en, this message translates to:
  /// **'Tap to mark'**
  String get tapToMark;

  /// No description provided for @attendanceToApprove.
  ///
  /// In en, this message translates to:
  /// **'Attendance to approve'**
  String get attendanceToApprove;

  /// No description provided for @leaveToApprove.
  ///
  /// In en, this message translates to:
  /// **'Leave / OD to approve'**
  String get leaveToApprove;

  /// No description provided for @allowancesToApprove.
  ///
  /// In en, this message translates to:
  /// **'Allowances to approve'**
  String get allowancesToApprove;

  /// No description provided for @myOpenTasks.
  ///
  /// In en, this message translates to:
  /// **'My open tasks'**
  String get myOpenTasks;

  /// No description provided for @overdueCount.
  ///
  /// In en, this message translates to:
  /// **'{count} overdue'**
  String overdueCount(int count);

  /// No description provided for @myToDo.
  ///
  /// In en, this message translates to:
  /// **'For me'**
  String get myToDo;

  /// No description provided for @attendanceReport.
  ///
  /// In en, this message translates to:
  /// **'Attendance report'**
  String get attendanceReport;

  /// No description provided for @leaveAndOdList.
  ///
  /// In en, this message translates to:
  /// **'Leave & OD list'**
  String get leaveAndOdList;

  /// No description provided for @presentToday.
  ///
  /// In en, this message translates to:
  /// **'Present today'**
  String get presentToday;

  /// No description provided for @todaySummary.
  ///
  /// In en, this message translates to:
  /// **'{present} present · {absent} absent · {leave} on leave · {notMarked} not marked'**
  String todaySummary(int present, int absent, int leave, int notMarked);

  /// No description provided for @pendingApprovals.
  ///
  /// In en, this message translates to:
  /// **'Pending approvals'**
  String get pendingApprovals;

  /// No description provided for @pendingBreakdown.
  ///
  /// In en, this message translates to:
  /// **'Attendance {attendance} · Leave {leave} · Allowances {allowances}'**
  String pendingBreakdown(int attendance, int leave, int allowances);

  /// No description provided for @allowancesThisMonth.
  ///
  /// In en, this message translates to:
  /// **'Allowances approved this month'**
  String get allowancesThisMonth;

  /// No description provided for @requestedAmount.
  ///
  /// In en, this message translates to:
  /// **'Requested {amount}'**
  String requestedAmount(String amount);

  /// No description provided for @tasksToday.
  ///
  /// In en, this message translates to:
  /// **'Today\'s tasks per operational manager'**
  String get tasksToday;

  /// No description provided for @notDoneCount.
  ///
  /// In en, this message translates to:
  /// **'{count} not done'**
  String notDoneCount(int count);

  /// No description provided for @headcountAsOf.
  ///
  /// In en, this message translates to:
  /// **'{count} people · {date}'**
  String headcountAsOf(int count, String date);

  /// No description provided for @tabTeam.
  ///
  /// In en, this message translates to:
  /// **'Team'**
  String get tabTeam;

  /// No description provided for @tabMine.
  ///
  /// In en, this message translates to:
  /// **'Mine'**
  String get tabMine;

  /// No description provided for @tabMyAttendance.
  ///
  /// In en, this message translates to:
  /// **'My attendance'**
  String get tabMyAttendance;

  /// No description provided for @tabApprovals.
  ///
  /// In en, this message translates to:
  /// **'Approvals'**
  String get tabApprovals;

  /// No description provided for @tabAllotted.
  ///
  /// In en, this message translates to:
  /// **'Allotted'**
  String get tabAllotted;

  /// No description provided for @tabCompleted.
  ///
  /// In en, this message translates to:
  /// **'Completed'**
  String get tabCompleted;

  /// No description provided for @teamAttendanceSummary.
  ///
  /// In en, this message translates to:
  /// **'{marked} of {total} marked'**
  String teamAttendanceSummary(int marked, int total);

  /// No description provided for @selfMarkSent.
  ///
  /// In en, this message translates to:
  /// **'Sent to your reporting manager for approval'**
  String get selfMarkSent;

  /// No description provided for @todayDate.
  ///
  /// In en, this message translates to:
  /// **'Today, {date}'**
  String todayDate(String date);

  /// No description provided for @approvedBy.
  ///
  /// In en, this message translates to:
  /// **'Approved by {name}'**
  String approvedBy(String name);

  /// No description provided for @last31Days.
  ///
  /// In en, this message translates to:
  /// **'Last 31 days'**
  String get last31Days;

  /// No description provided for @noMarksYet.
  ///
  /// In en, this message translates to:
  /// **'No attendance marked yet.'**
  String get noMarksYet;

  /// No description provided for @approveAll.
  ///
  /// In en, this message translates to:
  /// **'Approve all ({count})'**
  String approveAll(int count);

  /// No description provided for @approvedCount.
  ///
  /// In en, this message translates to:
  /// **'{count} approved'**
  String approvedCount(int count);

  /// No description provided for @corrections.
  ///
  /// In en, this message translates to:
  /// **'Corrections'**
  String get corrections;

  /// No description provided for @requestType.
  ///
  /// In en, this message translates to:
  /// **'Type'**
  String get requestType;

  /// No description provided for @dates.
  ///
  /// In en, this message translates to:
  /// **'Dates'**
  String get dates;

  /// No description provided for @odLocation.
  ///
  /// In en, this message translates to:
  /// **'Location / place of duty'**
  String get odLocation;

  /// No description provided for @odPurpose.
  ///
  /// In en, this message translates to:
  /// **'Purpose'**
  String get odPurpose;

  /// No description provided for @time.
  ///
  /// In en, this message translates to:
  /// **'Time'**
  String get time;

  /// No description provided for @raisedByLabel.
  ///
  /// In en, this message translates to:
  /// **'Raised by'**
  String get raisedByLabel;

  /// No description provided for @approver.
  ///
  /// In en, this message translates to:
  /// **'Approver'**
  String get approver;

  /// No description provided for @forTeamMember.
  ///
  /// In en, this message translates to:
  /// **'For a driver / loadman in my team'**
  String get forTeamMember;

  /// No description provided for @approveNow.
  ///
  /// In en, this message translates to:
  /// **'Approve now (I am their approver)'**
  String get approveNow;

  /// No description provided for @saveAndApprove.
  ///
  /// In en, this message translates to:
  /// **'Save and approve'**
  String get saveAndApprove;

  /// No description provided for @newAllowance.
  ///
  /// In en, this message translates to:
  /// **'New allowance'**
  String get newAllowance;

  /// No description provided for @noAllowances.
  ///
  /// In en, this message translates to:
  /// **'No allowance requests.'**
  String get noAllowances;

  /// No description provided for @batchTitle.
  ///
  /// In en, this message translates to:
  /// **'{name} · {count} people'**
  String batchTitle(String name, int count);

  /// No description provided for @monthlyTotals.
  ///
  /// In en, this message translates to:
  /// **'Monthly totals (approved / requested)'**
  String get monthlyTotals;

  /// No description provided for @requestsPending.
  ///
  /// In en, this message translates to:
  /// **'{count} requests · {pending} pending'**
  String requestsPending(int count, int pending);

  /// No description provided for @amountInvalid.
  ///
  /// In en, this message translates to:
  /// **'Enter an amount greater than 0'**
  String get amountInvalid;

  /// No description provided for @commentForChangedAmount.
  ///
  /// In en, this message translates to:
  /// **'Add a comment explaining the changed amount'**
  String get commentForChangedAmount;

  /// No description provided for @requestedAmountLabel.
  ///
  /// In en, this message translates to:
  /// **'Requested'**
  String get requestedAmountLabel;

  /// No description provided for @approvedAmountLabel.
  ///
  /// In en, this message translates to:
  /// **'Approved'**
  String get approvedAmountLabel;

  /// No description provided for @viewReceipt.
  ///
  /// In en, this message translates to:
  /// **'View receipt'**
  String get viewReceipt;

  /// No description provided for @amountToApprove.
  ///
  /// In en, this message translates to:
  /// **'Amount to approve'**
  String get amountToApprove;

  /// No description provided for @allowanceSubmitted.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{Allowance sent for approval} other{{count} allowances sent for approval}}'**
  String allowanceSubmitted(int count);

  /// No description provided for @forMyself.
  ///
  /// In en, this message translates to:
  /// **'Myself'**
  String get forMyself;

  /// No description provided for @forMyTeam.
  ///
  /// In en, this message translates to:
  /// **'My team'**
  String get forMyTeam;

  /// No description provided for @allowanceType.
  ///
  /// In en, this message translates to:
  /// **'Allowance type'**
  String get allowanceType;

  /// No description provided for @amount.
  ///
  /// In en, this message translates to:
  /// **'Amount'**
  String get amount;

  /// No description provided for @amountPerPerson.
  ///
  /// In en, this message translates to:
  /// **'Amount per person'**
  String get amountPerPerson;

  /// No description provided for @maxAmount.
  ///
  /// In en, this message translates to:
  /// **'Up to {amount}'**
  String maxAmount(String amount);

  /// No description provided for @batchTotal.
  ///
  /// In en, this message translates to:
  /// **'Total {amount}'**
  String batchTotal(String amount);

  /// No description provided for @commentOrVoice.
  ///
  /// In en, this message translates to:
  /// **'Add a comment or record a voice note'**
  String get commentOrVoice;

  /// No description provided for @receiptPhoto.
  ///
  /// In en, this message translates to:
  /// **'Receipt photo'**
  String get receiptPhoto;

  /// No description provided for @microphoneDenied.
  ///
  /// In en, this message translates to:
  /// **'Allow microphone access to record a voice note.'**
  String get microphoneDenied;

  /// No description provided for @voiceNote.
  ///
  /// In en, this message translates to:
  /// **'Voice note'**
  String get voiceNote;

  /// No description provided for @voiceNoteHelp.
  ///
  /// In en, this message translates to:
  /// **'Up to 2 minutes'**
  String get voiceNoteHelp;

  /// No description provided for @stop.
  ///
  /// In en, this message translates to:
  /// **'Stop'**
  String get stop;

  /// No description provided for @play.
  ///
  /// In en, this message translates to:
  /// **'Play'**
  String get play;

  /// No description provided for @pause.
  ///
  /// In en, this message translates to:
  /// **'Pause'**
  String get pause;

  /// No description provided for @noVoiceNote.
  ///
  /// In en, this message translates to:
  /// **'No voice note'**
  String get noVoiceNote;

  /// No description provided for @record.
  ///
  /// In en, this message translates to:
  /// **'Record'**
  String get record;

  /// No description provided for @playVoiceNote.
  ///
  /// In en, this message translates to:
  /// **'Play voice note'**
  String get playVoiceNote;

  /// No description provided for @uploadPayslips.
  ///
  /// In en, this message translates to:
  /// **'Upload payslips'**
  String get uploadPayslips;

  /// No description provided for @myPayslip.
  ///
  /// In en, this message translates to:
  /// **'My payslip'**
  String get myPayslip;

  /// No description provided for @payslipNotYet.
  ///
  /// In en, this message translates to:
  /// **'Your payslip for {month} is not available yet.'**
  String payslipNotYet(String month);

  /// No description provided for @uploadedOn.
  ///
  /// In en, this message translates to:
  /// **'Uploaded {when}'**
  String uploadedOn(String when);

  /// No description provided for @view.
  ///
  /// In en, this message translates to:
  /// **'View'**
  String get view;

  /// No description provided for @allPayslips.
  ///
  /// In en, this message translates to:
  /// **'All payslips'**
  String get allPayslips;

  /// No description provided for @myTeam.
  ///
  /// In en, this message translates to:
  /// **'My team'**
  String get myTeam;

  /// No description provided for @search.
  ///
  /// In en, this message translates to:
  /// **'Search'**
  String get search;

  /// No description provided for @noPayslips.
  ///
  /// In en, this message translates to:
  /// **'No payslips for this month.'**
  String get noPayslips;

  /// No description provided for @versions.
  ///
  /// In en, this message translates to:
  /// **'Versions'**
  String get versions;

  /// No description provided for @payPeriod.
  ///
  /// In en, this message translates to:
  /// **'Pay period'**
  String get payPeriod;

  /// No description provided for @payslipNameRule.
  ///
  /// In en, this message translates to:
  /// **'File names must be payslip-<employee code>.pdf, for example payslip-NLS1023.pdf. A new upload for the same person and month replaces the earlier one (kept as a version).'**
  String get payslipNameRule;

  /// No description provided for @choosePdfs.
  ///
  /// In en, this message translates to:
  /// **'Choose PDF files'**
  String get choosePdfs;

  /// No description provided for @filesChosen.
  ///
  /// In en, this message translates to:
  /// **'{count} files chosen'**
  String filesChosen(int count);

  /// No description provided for @uploadingProgress.
  ///
  /// In en, this message translates to:
  /// **'Uploading {sent} / {total}…'**
  String uploadingProgress(int sent, int total);

  /// No description provided for @uploadForPeriod.
  ///
  /// In en, this message translates to:
  /// **'Upload for {month}'**
  String uploadForPeriod(String month);

  /// No description provided for @matchedCount.
  ///
  /// In en, this message translates to:
  /// **'{count} matched'**
  String matchedCount(int count);

  /// No description provided for @replacedCount.
  ///
  /// In en, this message translates to:
  /// **'{count} replaced'**
  String replacedCount(int count);

  /// No description provided for @unmatchedCount.
  ///
  /// In en, this message translates to:
  /// **'{count} unmatched'**
  String unmatchedCount(int count);

  /// No description provided for @invalidCount.
  ///
  /// In en, this message translates to:
  /// **'{count} invalid'**
  String invalidCount(int count);

  /// No description provided for @duplicateCount.
  ///
  /// In en, this message translates to:
  /// **'{count} duplicates'**
  String duplicateCount(int count);

  /// No description provided for @unmatchedFiles.
  ///
  /// In en, this message translates to:
  /// **'Unmatched (not stored)'**
  String get unmatchedFiles;

  /// No description provided for @invalidFiles.
  ///
  /// In en, this message translates to:
  /// **'Invalid (not stored)'**
  String get invalidFiles;

  /// No description provided for @duplicateFiles.
  ///
  /// In en, this message translates to:
  /// **'Duplicates (not stored)'**
  String get duplicateFiles;

  /// No description provided for @matchedFiles.
  ///
  /// In en, this message translates to:
  /// **'Stored'**
  String get matchedFiles;

  /// No description provided for @allotTask.
  ///
  /// In en, this message translates to:
  /// **'Allot task'**
  String get allotTask;

  /// No description provided for @noTasks.
  ///
  /// In en, this message translates to:
  /// **'No tasks.'**
  String get noTasks;

  /// No description provided for @highPriority.
  ///
  /// In en, this message translates to:
  /// **'High priority'**
  String get highPriority;

  /// No description provided for @allottedBy.
  ///
  /// In en, this message translates to:
  /// **'Allotted by'**
  String get allottedBy;

  /// No description provided for @reopened.
  ///
  /// In en, this message translates to:
  /// **'Reopened'**
  String get reopened;

  /// No description provided for @submittedAt.
  ///
  /// In en, this message translates to:
  /// **'Submitted {when}'**
  String submittedAt(String when);

  /// No description provided for @reasonRequiredNotDone.
  ///
  /// In en, this message translates to:
  /// **'Give a reason when the task was not done'**
  String get reasonRequiredNotDone;

  /// No description provided for @taskSubmitted.
  ///
  /// In en, this message translates to:
  /// **'Task submitted'**
  String get taskSubmitted;

  /// No description provided for @submit.
  ///
  /// In en, this message translates to:
  /// **'Submit'**
  String get submit;

  /// No description provided for @reopenComment.
  ///
  /// In en, this message translates to:
  /// **'Comment for reopening'**
  String get reopenComment;

  /// No description provided for @reopen.
  ///
  /// In en, this message translates to:
  /// **'Reopen'**
  String get reopen;

  /// No description provided for @tasksAllotted.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{Task allotted} other{{count} tasks allotted}}'**
  String tasksAllotted(int count);

  /// No description provided for @taskTitle.
  ///
  /// In en, this message translates to:
  /// **'Task'**
  String get taskTitle;

  /// No description provided for @details.
  ///
  /// In en, this message translates to:
  /// **'Details'**
  String get details;

  /// No description provided for @chooseRms.
  ///
  /// In en, this message translates to:
  /// **'Choose regional managers'**
  String get chooseRms;

  /// No description provided for @everyone.
  ///
  /// In en, this message translates to:
  /// **'Everyone'**
  String get everyone;

  /// No description provided for @download.
  ///
  /// In en, this message translates to:
  /// **'Download'**
  String get download;

  /// No description provided for @downloadExcel.
  ///
  /// In en, this message translates to:
  /// **'Excel (.xlsx)'**
  String get downloadExcel;

  /// No description provided for @downloadPdf.
  ///
  /// In en, this message translates to:
  /// **'PDF'**
  String get downloadPdf;

  /// No description provided for @muster.
  ///
  /// In en, this message translates to:
  /// **'Muster'**
  String get muster;

  /// No description provided for @summary.
  ///
  /// In en, this message translates to:
  /// **'Summary'**
  String get summary;

  /// No description provided for @noReportRows.
  ///
  /// In en, this message translates to:
  /// **'No attendance for this selection.'**
  String get noReportRows;

  /// No description provided for @resetPassword.
  ///
  /// In en, this message translates to:
  /// **'Reset password'**
  String get resetPassword;

  /// No description provided for @newPassword.
  ///
  /// In en, this message translates to:
  /// **'New password'**
  String get newPassword;

  /// No description provided for @passwordRule.
  ///
  /// In en, this message translates to:
  /// **'At least {min} characters'**
  String passwordRule(int min);

  /// No description provided for @newUser.
  ///
  /// In en, this message translates to:
  /// **'New user'**
  String get newUser;

  /// No description provided for @lastLogin.
  ///
  /// In en, this message translates to:
  /// **'last login {when}'**
  String lastLogin(String when);

  /// No description provided for @inactive.
  ///
  /// In en, this message translates to:
  /// **'Inactive'**
  String get inactive;

  /// No description provided for @locked.
  ///
  /// In en, this message translates to:
  /// **'Locked'**
  String get locked;

  /// No description provided for @passwordReset.
  ///
  /// In en, this message translates to:
  /// **'Password reset. Their sessions were signed out.'**
  String get passwordReset;

  /// No description provided for @unlocked.
  ///
  /// In en, this message translates to:
  /// **'Unlocked'**
  String get unlocked;

  /// No description provided for @deactivated.
  ///
  /// In en, this message translates to:
  /// **'Deactivated'**
  String get deactivated;

  /// No description provided for @activated.
  ///
  /// In en, this message translates to:
  /// **'Activated'**
  String get activated;

  /// No description provided for @unlock.
  ///
  /// In en, this message translates to:
  /// **'Unlock'**
  String get unlock;

  /// No description provided for @deactivate.
  ///
  /// In en, this message translates to:
  /// **'Deactivate'**
  String get deactivate;

  /// No description provided for @activate.
  ///
  /// In en, this message translates to:
  /// **'Activate'**
  String get activate;

  /// No description provided for @userCreated.
  ///
  /// In en, this message translates to:
  /// **'{name} can now sign in'**
  String userCreated(String name);

  /// No description provided for @role.
  ///
  /// In en, this message translates to:
  /// **'Role'**
  String get role;

  /// No description provided for @primaryHint.
  ///
  /// In en, this message translates to:
  /// **'Tap the circle to choose the primary business unit (own attendance, leave and payslips belong to it).'**
  String get primaryHint;

  /// No description provided for @reportsToLabel.
  ///
  /// In en, this message translates to:
  /// **'Reports to ({role})'**
  String reportsToLabel(String role);

  /// No description provided for @initialPassword.
  ///
  /// In en, this message translates to:
  /// **'Initial password'**
  String get initialPassword;

  /// No description provided for @createUser.
  ///
  /// In en, this message translates to:
  /// **'Create user'**
  String get createUser;

  /// No description provided for @email.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get email;

  /// No description provided for @passwordByDirector.
  ///
  /// In en, this message translates to:
  /// **'To change your password, contact your Director.'**
  String get passwordByDirector;

  /// No description provided for @signOutConfirm.
  ///
  /// In en, this message translates to:
  /// **'Sign out of this device?'**
  String get signOutConfirm;

  /// No description provided for @appVersion.
  ///
  /// In en, this message translates to:
  /// **'App version {version}'**
  String appVersion(String version);

  /// No description provided for @peopleCount.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 person} other{{count} people}}'**
  String peopleCount(int count);
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
