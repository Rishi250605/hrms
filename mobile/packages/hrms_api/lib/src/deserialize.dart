import 'package:hrms_api/src/model/accrual_rule.dart';
import 'package:hrms_api/src/model/allowance_approve_body.dart';
import 'package:hrms_api/src/model/allowance_create_body.dart';
import 'package:hrms_api/src/model/allowance_files.dart';
import 'package:hrms_api/src/model/allowance_item.dart';
import 'package:hrms_api/src/model/allowance_item_allowance_type.dart';
import 'package:hrms_api/src/model/allowance_list.dart';
import 'package:hrms_api/src/model/allowance_page.dart';
import 'package:hrms_api/src/model/allowance_summary.dart';
import 'package:hrms_api/src/model/allowance_summary_items_inner.dart';
import 'package:hrms_api/src/model/allowance_type_create_body.dart';
import 'package:hrms_api/src/model/allowance_type_item.dart';
import 'package:hrms_api/src/model/allowance_type_list.dart';
import 'package:hrms_api/src/model/allowance_type_update_body.dart';
import 'package:hrms_api/src/model/assignment_create_body.dart';
import 'package:hrms_api/src/model/assignment_item.dart';
import 'package:hrms_api/src/model/assignment_result.dart';
import 'package:hrms_api/src/model/attendance_employee.dart';
import 'package:hrms_api/src/model/attendance_mark_item.dart';
import 'package:hrms_api/src/model/attendance_mark_list.dart';
import 'package:hrms_api/src/model/attendance_report.dart';
import 'package:hrms_api/src/model/attendance_report_legend_inner.dart';
import 'package:hrms_api/src/model/attendance_report_rows_inner.dart';
import 'package:hrms_api/src/model/attendance_report_summary.dart';
import 'package:hrms_api/src/model/bank_details.dart';
import 'package:hrms_api/src/model/bank_details_body.dart';
import 'package:hrms_api/src/model/batch_approve_result.dart';
import 'package:hrms_api/src/model/bulk_approve_body.dart';
import 'package:hrms_api/src/model/bulk_approve_result.dart';
import 'package:hrms_api/src/model/bulk_approve_result_skipped_inner.dart';
import 'package:hrms_api/src/model/bulk_attendance_body.dart';
import 'package:hrms_api/src/model/bulk_attendance_result.dart';
import 'package:hrms_api/src/model/bulk_mark.dart';
import 'package:hrms_api/src/model/bulk_result_item.dart';
import 'package:hrms_api/src/model/bulk_result_item_error.dart';
import 'package:hrms_api/src/model/business_unit_create_body.dart';
import 'package:hrms_api/src/model/business_unit_item.dart';
import 'package:hrms_api/src/model/business_unit_list.dart';
import 'package:hrms_api/src/model/business_unit_membership.dart';
import 'package:hrms_api/src/model/business_unit_ref.dart';
import 'package:hrms_api/src/model/business_unit_update_body.dart';
import 'package:hrms_api/src/model/business_units_body.dart';
import 'package:hrms_api/src/model/compliance.dart';
import 'package:hrms_api/src/model/compliance_item.dart';
import 'package:hrms_api/src/model/correction_body.dart';
import 'package:hrms_api/src/model/correction_item.dart';
import 'package:hrms_api/src/model/correction_list.dart';
import 'package:hrms_api/src/model/dashboard.dart';
import 'package:hrms_api/src/model/dashboard_business_units_inner.dart';
import 'package:hrms_api/src/model/dashboard_business_units_inner_allowances_this_month.dart';
import 'package:hrms_api/src/model/dashboard_business_units_inner_pending_approvals.dart';
import 'package:hrms_api/src/model/dashboard_business_units_inner_tasks_today_inner.dart';
import 'package:hrms_api/src/model/dashboard_business_units_inner_today.dart';
import 'package:hrms_api/src/model/dashboard_me.dart';
import 'package:hrms_api/src/model/dashboard_me_my_attendance_today.dart';
import 'package:hrms_api/src/model/dashboard_me_pending_approvals.dart';
import 'package:hrms_api/src/model/depot_create_body.dart';
import 'package:hrms_api/src/model/depot_item.dart';
import 'package:hrms_api/src/model/depot_list.dart';
import 'package:hrms_api/src/model/depot_summary.dart';
import 'package:hrms_api/src/model/depot_update_body.dart';
import 'package:hrms_api/src/model/device_register_body.dart';
import 'package:hrms_api/src/model/device_unregister_body.dart';
import 'package:hrms_api/src/model/document_create_body.dart';
import 'package:hrms_api/src/model/document_employee.dart';
import 'package:hrms_api/src/model/document_invalid_details.dart';
import 'package:hrms_api/src/model/document_item.dart';
import 'package:hrms_api/src/model/document_list.dart';
import 'package:hrms_api/src/model/document_page.dart';
import 'package:hrms_api/src/model/document_reject_body.dart';
import 'package:hrms_api/src/model/document_requirement_body.dart';
import 'package:hrms_api/src/model/document_requirement_item.dart';
import 'package:hrms_api/src/model/document_requirement_list.dart';
import 'package:hrms_api/src/model/document_verify_body.dart';
import 'package:hrms_api/src/model/document_with_employee.dart';
import 'package:hrms_api/src/model/duty_create_body.dart';
import 'package:hrms_api/src/model/duty_item.dart';
import 'package:hrms_api/src/model/duty_item_template.dart';
import 'package:hrms_api/src/model/duty_item_vehicle.dart';
import 'package:hrms_api/src/model/duty_template_create_body.dart';
import 'package:hrms_api/src/model/duty_template_item.dart';
import 'package:hrms_api/src/model/duty_template_list.dart';
import 'package:hrms_api/src/model/duty_template_update_body.dart';
import 'package:hrms_api/src/model/duty_update_body.dart';
import 'package:hrms_api/src/model/employee_create_body.dart';
import 'package:hrms_api/src/model/employee_detail.dart';
import 'package:hrms_api/src/model/employee_job_item.dart';
import 'package:hrms_api/src/model/employee_list_item.dart';
import 'package:hrms_api/src/model/employee_page.dart';
import 'package:hrms_api/src/model/employee_update_body.dart';
import 'package:hrms_api/src/model/error_response.dart';
import 'package:hrms_api/src/model/error_response_error.dart';
import 'package:hrms_api/src/model/exit_body.dart';
import 'package:hrms_api/src/model/expiring_document_list.dart';
import 'package:hrms_api/src/model/health_response.dart';
import 'package:hrms_api/src/model/job_change_body.dart';
import 'package:hrms_api/src/model/job_input.dart';
import 'package:hrms_api/src/model/leave_balance_item.dart';
import 'package:hrms_api/src/model/leave_balance_list.dart';
import 'package:hrms_api/src/model/leave_policy_body.dart';
import 'package:hrms_api/src/model/leave_policy_item.dart';
import 'package:hrms_api/src/model/leave_policy_list.dart';
import 'package:hrms_api/src/model/leave_policy_update_body.dart';
import 'package:hrms_api/src/model/leave_request_create_body.dart';
import 'package:hrms_api/src/model/leave_request_item.dart';
import 'package:hrms_api/src/model/leave_request_item_leave_type.dart';
import 'package:hrms_api/src/model/leave_request_page.dart';
import 'package:hrms_api/src/model/leave_type_create_body.dart';
import 'package:hrms_api/src/model/leave_type_item.dart';
import 'package:hrms_api/src/model/leave_type_list.dart';
import 'package:hrms_api/src/model/leave_type_update_body.dart';
import 'package:hrms_api/src/model/login_body.dart';
import 'package:hrms_api/src/model/logout_body.dart';
import 'package:hrms_api/src/model/me_response.dart';
import 'package:hrms_api/src/model/next_code_response.dart';
import 'package:hrms_api/src/model/notification_item.dart';
import 'package:hrms_api/src/model/notification_page.dart';
import 'package:hrms_api/src/model/payslip_item.dart';
import 'package:hrms_api/src/model/payslip_item_employee.dart';
import 'package:hrms_api/src/model/payslip_page.dart';
import 'package:hrms_api/src/model/payslip_upload_match.dart';
import 'package:hrms_api/src/model/payslip_upload_result.dart';
import 'package:hrms_api/src/model/payslip_upload_result_invalid_inner.dart';
import 'package:hrms_api/src/model/payslip_version_list.dart';
import 'package:hrms_api/src/model/payslip_version_list_items_inner.dart';
import 'package:hrms_api/src/model/person_ref.dart';
import 'package:hrms_api/src/model/photo_body.dart';
import 'package:hrms_api/src/model/presign_body.dart';
import 'package:hrms_api/src/model/presign_response.dart';
import 'package:hrms_api/src/model/promotion_body.dart';
import 'package:hrms_api/src/model/promotion_result.dart';
import 'package:hrms_api/src/model/refresh_body.dart';
import 'package:hrms_api/src/model/region_create_body.dart';
import 'package:hrms_api/src/model/region_item.dart';
import 'package:hrms_api/src/model/region_list.dart';
import 'package:hrms_api/src/model/region_update_body.dart';
import 'package:hrms_api/src/model/reject_reason_body.dart';
import 'package:hrms_api/src/model/report_file.dart';
import 'package:hrms_api/src/model/reset_password_body.dart';
import 'package:hrms_api/src/model/roster_copy_body.dart';
import 'package:hrms_api/src/model/roster_copy_result.dart';
import 'package:hrms_api/src/model/roster_copy_result_skipped_inner.dart';
import 'package:hrms_api/src/model/roster_day.dart';
import 'package:hrms_api/src/model/roster_day_summary.dart';
import 'package:hrms_api/src/model/roster_employee.dart';
import 'package:hrms_api/src/model/roster_warning.dart';
import 'package:hrms_api/src/model/route_create_body.dart';
import 'package:hrms_api/src/model/route_item.dart';
import 'package:hrms_api/src/model/route_list.dart';
import 'package:hrms_api/src/model/route_update_body.dart';
import 'package:hrms_api/src/model/self_mark_body.dart';
import 'package:hrms_api/src/model/setting_item.dart';
import 'package:hrms_api/src/model/setting_list.dart';
import 'package:hrms_api/src/model/setting_update_body.dart';
import 'package:hrms_api/src/model/signed_url_response.dart';
import 'package:hrms_api/src/model/spare_item.dart';
import 'package:hrms_api/src/model/spare_list.dart';
import 'package:hrms_api/src/model/task_create_body.dart';
import 'package:hrms_api/src/model/task_item.dart';
import 'package:hrms_api/src/model/task_list.dart';
import 'package:hrms_api/src/model/task_page.dart';
import 'package:hrms_api/src/model/task_reopen_body.dart';
import 'package:hrms_api/src/model/task_submit_body.dart';
import 'package:hrms_api/src/model/team_attendance_day.dart';
import 'package:hrms_api/src/model/team_attendance_day_summary.dart';
import 'package:hrms_api/src/model/team_attendance_row.dart';
import 'package:hrms_api/src/model/team_attendance_row_duties_inner.dart';
import 'package:hrms_api/src/model/team_attendance_row_leave.dart';
import 'package:hrms_api/src/model/token_pair.dart';
import 'package:hrms_api/src/model/user_create_body.dart';
import 'package:hrms_api/src/model/user_item.dart';
import 'package:hrms_api/src/model/user_list.dart';
import 'package:hrms_api/src/model/user_update_body.dart';
import 'package:hrms_api/src/model/vehicle_create_body.dart';
import 'package:hrms_api/src/model/vehicle_item.dart';
import 'package:hrms_api/src/model/vehicle_list.dart';
import 'package:hrms_api/src/model/vehicle_update_body.dart';

final _regList = RegExp(r'^List<(.*)>$');
final _regSet = RegExp(r'^Set<(.*)>$');
final _regMap = RegExp(r'^Map<String,(.*)>$');

ReturnType deserialize<ReturnType, BaseType>(
  dynamic value,
  String targetType, {
  bool growable = true,
}) {
  switch (targetType) {
    case 'String':
      return '$value' as ReturnType;
    case 'int':
      return (value is int ? value : int.parse('$value')) as ReturnType;
    case 'bool':
      if (value is bool) {
        return value as ReturnType;
      }
      final valueString = '$value'.toLowerCase();
      return (valueString == 'true' || valueString == '1') as ReturnType;
    case 'double':
      return (value is double ? value : double.parse('$value')) as ReturnType;
    case 'AccrualRule':
      return AccrualRule.fromJson(value as Map<String, dynamic>) as ReturnType;
    case 'AllowanceApproveBody':
      return AllowanceApproveBody.fromJson(value as Map<String, dynamic>)
          as ReturnType;
    case 'AllowanceCreateBody':
      return AllowanceCreateBody.fromJson(value as Map<String, dynamic>)
          as ReturnType;
    case 'AllowanceFiles':
      return AllowanceFiles.fromJson(value as Map<String, dynamic>)
          as ReturnType;
    case 'AllowanceItem':
      return AllowanceItem.fromJson(value as Map<String, dynamic>)
          as ReturnType;
    case 'AllowanceItemAllowanceType':
      return AllowanceItemAllowanceType.fromJson(value as Map<String, dynamic>)
          as ReturnType;
    case 'AllowanceList':
      return AllowanceList.fromJson(value as Map<String, dynamic>)
          as ReturnType;
    case 'AllowancePage':
      return AllowancePage.fromJson(value as Map<String, dynamic>)
          as ReturnType;
    case 'AllowanceSummary':
      return AllowanceSummary.fromJson(value as Map<String, dynamic>)
          as ReturnType;
    case 'AllowanceSummaryItemsInner':
      return AllowanceSummaryItemsInner.fromJson(value as Map<String, dynamic>)
          as ReturnType;
    case 'AllowanceTypeCreateBody':
      return AllowanceTypeCreateBody.fromJson(value as Map<String, dynamic>)
          as ReturnType;
    case 'AllowanceTypeItem':
      return AllowanceTypeItem.fromJson(value as Map<String, dynamic>)
          as ReturnType;
    case 'AllowanceTypeList':
      return AllowanceTypeList.fromJson(value as Map<String, dynamic>)
          as ReturnType;
    case 'AllowanceTypeUpdateBody':
      return AllowanceTypeUpdateBody.fromJson(value as Map<String, dynamic>)
          as ReturnType;
    case 'ApprovalState':
    case 'AssignmentCreateBody':
      return AssignmentCreateBody.fromJson(value as Map<String, dynamic>)
          as ReturnType;
    case 'AssignmentItem':
      return AssignmentItem.fromJson(value as Map<String, dynamic>)
          as ReturnType;
    case 'AssignmentResult':
      return AssignmentResult.fromJson(value as Map<String, dynamic>)
          as ReturnType;
    case 'AssignmentRole':
    case 'AttendanceEmployee':
      return AttendanceEmployee.fromJson(value as Map<String, dynamic>)
          as ReturnType;
    case 'AttendanceMarkItem':
      return AttendanceMarkItem.fromJson(value as Map<String, dynamic>)
          as ReturnType;
    case 'AttendanceMarkList':
      return AttendanceMarkList.fromJson(value as Map<String, dynamic>)
          as ReturnType;
    case 'AttendanceReport':
      return AttendanceReport.fromJson(value as Map<String, dynamic>)
          as ReturnType;
    case 'AttendanceReportLegendInner':
      return AttendanceReportLegendInner.fromJson(value as Map<String, dynamic>)
          as ReturnType;
    case 'AttendanceReportRowsInner':
      return AttendanceReportRowsInner.fromJson(value as Map<String, dynamic>)
          as ReturnType;
    case 'AttendanceReportSummary':
      return AttendanceReportSummary.fromJson(value as Map<String, dynamic>)
          as ReturnType;
    case 'AttendanceSource':
    case 'AttendanceStatus':
    case 'BankDetails':
      return BankDetails.fromJson(value as Map<String, dynamic>) as ReturnType;
    case 'BankDetailsBody':
      return BankDetailsBody.fromJson(value as Map<String, dynamic>)
          as ReturnType;
    case 'BatchApproveResult':
      return BatchApproveResult.fromJson(value as Map<String, dynamic>)
          as ReturnType;
    case 'BulkApproveBody':
      return BulkApproveBody.fromJson(value as Map<String, dynamic>)
          as ReturnType;
    case 'BulkApproveResult':
      return BulkApproveResult.fromJson(value as Map<String, dynamic>)
          as ReturnType;
    case 'BulkApproveResultSkippedInner':
      return BulkApproveResultSkippedInner.fromJson(
            value as Map<String, dynamic>,
          )
          as ReturnType;
    case 'BulkAttendanceBody':
      return BulkAttendanceBody.fromJson(value as Map<String, dynamic>)
          as ReturnType;
    case 'BulkAttendanceResult':
      return BulkAttendanceResult.fromJson(value as Map<String, dynamic>)
          as ReturnType;
    case 'BulkMark':
      return BulkMark.fromJson(value as Map<String, dynamic>) as ReturnType;
    case 'BulkResultItem':
      return BulkResultItem.fromJson(value as Map<String, dynamic>)
          as ReturnType;
    case 'BulkResultItemError':
      return BulkResultItemError.fromJson(value as Map<String, dynamic>)
          as ReturnType;
    case 'BusinessUnitCreateBody':
      return BusinessUnitCreateBody.fromJson(value as Map<String, dynamic>)
          as ReturnType;
    case 'BusinessUnitItem':
      return BusinessUnitItem.fromJson(value as Map<String, dynamic>)
          as ReturnType;
    case 'BusinessUnitList':
      return BusinessUnitList.fromJson(value as Map<String, dynamic>)
          as ReturnType;
    case 'BusinessUnitMembership':
      return BusinessUnitMembership.fromJson(value as Map<String, dynamic>)
          as ReturnType;
    case 'BusinessUnitRef':
      return BusinessUnitRef.fromJson(value as Map<String, dynamic>)
          as ReturnType;
    case 'BusinessUnitUpdateBody':
      return BusinessUnitUpdateBody.fromJson(value as Map<String, dynamic>)
          as ReturnType;
    case 'BusinessUnitsBody':
      return BusinessUnitsBody.fromJson(value as Map<String, dynamic>)
          as ReturnType;
    case 'Compliance':
      return Compliance.fromJson(value as Map<String, dynamic>) as ReturnType;
    case 'ComplianceItem':
      return ComplianceItem.fromJson(value as Map<String, dynamic>)
          as ReturnType;
    case 'ComplianceOverall':
    case 'ComplianceState':
    case 'CorrectionBody':
      return CorrectionBody.fromJson(value as Map<String, dynamic>)
          as ReturnType;
    case 'CorrectionItem':
      return CorrectionItem.fromJson(value as Map<String, dynamic>)
          as ReturnType;
    case 'CorrectionList':
      return CorrectionList.fromJson(value as Map<String, dynamic>)
          as ReturnType;
    case 'Dashboard':
      return Dashboard.fromJson(value as Map<String, dynamic>) as ReturnType;
    case 'DashboardBusinessUnitsInner':
      return DashboardBusinessUnitsInner.fromJson(value as Map<String, dynamic>)
          as ReturnType;
    case 'DashboardBusinessUnitsInnerAllowancesThisMonth':
      return DashboardBusinessUnitsInnerAllowancesThisMonth.fromJson(
            value as Map<String, dynamic>,
          )
          as ReturnType;
    case 'DashboardBusinessUnitsInnerPendingApprovals':
      return DashboardBusinessUnitsInnerPendingApprovals.fromJson(
            value as Map<String, dynamic>,
          )
          as ReturnType;
    case 'DashboardBusinessUnitsInnerTasksTodayInner':
      return DashboardBusinessUnitsInnerTasksTodayInner.fromJson(
            value as Map<String, dynamic>,
          )
          as ReturnType;
    case 'DashboardBusinessUnitsInnerToday':
      return DashboardBusinessUnitsInnerToday.fromJson(
            value as Map<String, dynamic>,
          )
          as ReturnType;
    case 'DashboardMe':
      return DashboardMe.fromJson(value as Map<String, dynamic>) as ReturnType;
    case 'DashboardMeMyAttendanceToday':
      return DashboardMeMyAttendanceToday.fromJson(
            value as Map<String, dynamic>,
          )
          as ReturnType;
    case 'DashboardMePendingApprovals':
      return DashboardMePendingApprovals.fromJson(value as Map<String, dynamic>)
          as ReturnType;
    case 'DepotCreateBody':
      return DepotCreateBody.fromJson(value as Map<String, dynamic>)
          as ReturnType;
    case 'DepotItem':
      return DepotItem.fromJson(value as Map<String, dynamic>) as ReturnType;
    case 'DepotList':
      return DepotList.fromJson(value as Map<String, dynamic>) as ReturnType;
    case 'DepotSummary':
      return DepotSummary.fromJson(value as Map<String, dynamic>) as ReturnType;
    case 'DepotUpdateBody':
      return DepotUpdateBody.fromJson(value as Map<String, dynamic>)
          as ReturnType;
    case 'DeviceRegisterBody':
      return DeviceRegisterBody.fromJson(value as Map<String, dynamic>)
          as ReturnType;
    case 'DeviceUnregisterBody':
      return DeviceUnregisterBody.fromJson(value as Map<String, dynamic>)
          as ReturnType;
    case 'DocumentCreateBody':
      return DocumentCreateBody.fromJson(value as Map<String, dynamic>)
          as ReturnType;
    case 'DocumentEmployee':
      return DocumentEmployee.fromJson(value as Map<String, dynamic>)
          as ReturnType;
    case 'DocumentInvalidDetails':
      return DocumentInvalidDetails.fromJson(value as Map<String, dynamic>)
          as ReturnType;
    case 'DocumentItem':
      return DocumentItem.fromJson(value as Map<String, dynamic>) as ReturnType;
    case 'DocumentList':
      return DocumentList.fromJson(value as Map<String, dynamic>) as ReturnType;
    case 'DocumentPage':
      return DocumentPage.fromJson(value as Map<String, dynamic>) as ReturnType;
    case 'DocumentRejectBody':
      return DocumentRejectBody.fromJson(value as Map<String, dynamic>)
          as ReturnType;
    case 'DocumentRequirementBody':
      return DocumentRequirementBody.fromJson(value as Map<String, dynamic>)
          as ReturnType;
    case 'DocumentRequirementItem':
      return DocumentRequirementItem.fromJson(value as Map<String, dynamic>)
          as ReturnType;
    case 'DocumentRequirementList':
      return DocumentRequirementList.fromJson(value as Map<String, dynamic>)
          as ReturnType;
    case 'DocumentStatus':
    case 'DocumentType':
    case 'DocumentVerifyBody':
      return DocumentVerifyBody.fromJson(value as Map<String, dynamic>)
          as ReturnType;
    case 'DocumentWithEmployee':
      return DocumentWithEmployee.fromJson(value as Map<String, dynamic>)
          as ReturnType;
    case 'DutyCreateBody':
      return DutyCreateBody.fromJson(value as Map<String, dynamic>)
          as ReturnType;
    case 'DutyItem':
      return DutyItem.fromJson(value as Map<String, dynamic>) as ReturnType;
    case 'DutyItemTemplate':
      return DutyItemTemplate.fromJson(value as Map<String, dynamic>)
          as ReturnType;
    case 'DutyItemVehicle':
      return DutyItemVehicle.fromJson(value as Map<String, dynamic>)
          as ReturnType;
    case 'DutyStatus':
    case 'DutyTemplateCreateBody':
      return DutyTemplateCreateBody.fromJson(value as Map<String, dynamic>)
          as ReturnType;
    case 'DutyTemplateItem':
      return DutyTemplateItem.fromJson(value as Map<String, dynamic>)
          as ReturnType;
    case 'DutyTemplateList':
      return DutyTemplateList.fromJson(value as Map<String, dynamic>)
          as ReturnType;
    case 'DutyTemplateUpdateBody':
      return DutyTemplateUpdateBody.fromJson(value as Map<String, dynamic>)
          as ReturnType;
    case 'DutyUpdateBody':
      return DutyUpdateBody.fromJson(value as Map<String, dynamic>)
          as ReturnType;
    case 'EmployeeCategory':
    case 'EmployeeCreateBody':
      return EmployeeCreateBody.fromJson(value as Map<String, dynamic>)
          as ReturnType;
    case 'EmployeeDetail':
      return EmployeeDetail.fromJson(value as Map<String, dynamic>)
          as ReturnType;
    case 'EmployeeJobItem':
      return EmployeeJobItem.fromJson(value as Map<String, dynamic>)
          as ReturnType;
    case 'EmployeeListItem':
      return EmployeeListItem.fromJson(value as Map<String, dynamic>)
          as ReturnType;
    case 'EmployeePage':
      return EmployeePage.fromJson(value as Map<String, dynamic>) as ReturnType;
    case 'EmployeeStatus':
    case 'EmployeeUpdateBody':
      return EmployeeUpdateBody.fromJson(value as Map<String, dynamic>)
          as ReturnType;
    case 'EmploymentType':
    case 'ErrorResponse':
      return ErrorResponse.fromJson(value as Map<String, dynamic>)
          as ReturnType;
    case 'ErrorResponseError':
      return ErrorResponseError.fromJson(value as Map<String, dynamic>)
          as ReturnType;
    case 'ExitBody':
      return ExitBody.fromJson(value as Map<String, dynamic>) as ReturnType;
    case 'ExpiringDocumentList':
      return ExpiringDocumentList.fromJson(value as Map<String, dynamic>)
          as ReturnType;
    case 'Gender':
    case 'HealthResponse':
      return HealthResponse.fromJson(value as Map<String, dynamic>)
          as ReturnType;
    case 'JobChangeBody':
      return JobChangeBody.fromJson(value as Map<String, dynamic>)
          as ReturnType;
    case 'JobInput':
      return JobInput.fromJson(value as Map<String, dynamic>) as ReturnType;
    case 'LeaveBalanceItem':
      return LeaveBalanceItem.fromJson(value as Map<String, dynamic>)
          as ReturnType;
    case 'LeaveBalanceList':
      return LeaveBalanceList.fromJson(value as Map<String, dynamic>)
          as ReturnType;
    case 'LeaveKind':
    case 'LeavePolicyBody':
      return LeavePolicyBody.fromJson(value as Map<String, dynamic>)
          as ReturnType;
    case 'LeavePolicyItem':
      return LeavePolicyItem.fromJson(value as Map<String, dynamic>)
          as ReturnType;
    case 'LeavePolicyList':
      return LeavePolicyList.fromJson(value as Map<String, dynamic>)
          as ReturnType;
    case 'LeavePolicyUpdateBody':
      return LeavePolicyUpdateBody.fromJson(value as Map<String, dynamic>)
          as ReturnType;
    case 'LeaveRequestCreateBody':
      return LeaveRequestCreateBody.fromJson(value as Map<String, dynamic>)
          as ReturnType;
    case 'LeaveRequestItem':
      return LeaveRequestItem.fromJson(value as Map<String, dynamic>)
          as ReturnType;
    case 'LeaveRequestItemLeaveType':
      return LeaveRequestItemLeaveType.fromJson(value as Map<String, dynamic>)
          as ReturnType;
    case 'LeaveRequestPage':
      return LeaveRequestPage.fromJson(value as Map<String, dynamic>)
          as ReturnType;
    case 'LeaveTypeCreateBody':
      return LeaveTypeCreateBody.fromJson(value as Map<String, dynamic>)
          as ReturnType;
    case 'LeaveTypeItem':
      return LeaveTypeItem.fromJson(value as Map<String, dynamic>)
          as ReturnType;
    case 'LeaveTypeList':
      return LeaveTypeList.fromJson(value as Map<String, dynamic>)
          as ReturnType;
    case 'LeaveTypeUpdateBody':
      return LeaveTypeUpdateBody.fromJson(value as Map<String, dynamic>)
          as ReturnType;
    case 'LoginBody':
      return LoginBody.fromJson(value as Map<String, dynamic>) as ReturnType;
    case 'LogoutBody':
      return LogoutBody.fromJson(value as Map<String, dynamic>) as ReturnType;
    case 'MeResponse':
      return MeResponse.fromJson(value as Map<String, dynamic>) as ReturnType;
    case 'NextCodeResponse':
      return NextCodeResponse.fromJson(value as Map<String, dynamic>)
          as ReturnType;
    case 'NotificationItem':
      return NotificationItem.fromJson(value as Map<String, dynamic>)
          as ReturnType;
    case 'NotificationPage':
      return NotificationPage.fromJson(value as Map<String, dynamic>)
          as ReturnType;
    case 'PayslipItem':
      return PayslipItem.fromJson(value as Map<String, dynamic>) as ReturnType;
    case 'PayslipItemEmployee':
      return PayslipItemEmployee.fromJson(value as Map<String, dynamic>)
          as ReturnType;
    case 'PayslipPage':
      return PayslipPage.fromJson(value as Map<String, dynamic>) as ReturnType;
    case 'PayslipUploadMatch':
      return PayslipUploadMatch.fromJson(value as Map<String, dynamic>)
          as ReturnType;
    case 'PayslipUploadResult':
      return PayslipUploadResult.fromJson(value as Map<String, dynamic>)
          as ReturnType;
    case 'PayslipUploadResultInvalidInner':
      return PayslipUploadResultInvalidInner.fromJson(
            value as Map<String, dynamic>,
          )
          as ReturnType;
    case 'PayslipVersionList':
      return PayslipVersionList.fromJson(value as Map<String, dynamic>)
          as ReturnType;
    case 'PayslipVersionListItemsInner':
      return PayslipVersionListItemsInner.fromJson(
            value as Map<String, dynamic>,
          )
          as ReturnType;
    case 'PersonRef':
      return PersonRef.fromJson(value as Map<String, dynamic>) as ReturnType;
    case 'PhotoBody':
      return PhotoBody.fromJson(value as Map<String, dynamic>) as ReturnType;
    case 'PreferredChannel':
    case 'PresignBody':
      return PresignBody.fromJson(value as Map<String, dynamic>) as ReturnType;
    case 'PresignResponse':
      return PresignResponse.fromJson(value as Map<String, dynamic>)
          as ReturnType;
    case 'PromotionBody':
      return PromotionBody.fromJson(value as Map<String, dynamic>)
          as ReturnType;
    case 'PromotionResult':
      return PromotionResult.fromJson(value as Map<String, dynamic>)
          as ReturnType;
    case 'RefreshBody':
      return RefreshBody.fromJson(value as Map<String, dynamic>) as ReturnType;
    case 'RegionCreateBody':
      return RegionCreateBody.fromJson(value as Map<String, dynamic>)
          as ReturnType;
    case 'RegionItem':
      return RegionItem.fromJson(value as Map<String, dynamic>) as ReturnType;
    case 'RegionList':
      return RegionList.fromJson(value as Map<String, dynamic>) as ReturnType;
    case 'RegionUpdateBody':
      return RegionUpdateBody.fromJson(value as Map<String, dynamic>)
          as ReturnType;
    case 'RejectReasonBody':
      return RejectReasonBody.fromJson(value as Map<String, dynamic>)
          as ReturnType;
    case 'ReportFile':
      return ReportFile.fromJson(value as Map<String, dynamic>) as ReturnType;
    case 'ReportGroup':
    case 'RequestStatus':
    case 'ResetPasswordBody':
      return ResetPasswordBody.fromJson(value as Map<String, dynamic>)
          as ReturnType;
    case 'Role':
    case 'RosterCopyBody':
      return RosterCopyBody.fromJson(value as Map<String, dynamic>)
          as ReturnType;
    case 'RosterCopyResult':
      return RosterCopyResult.fromJson(value as Map<String, dynamic>)
          as ReturnType;
    case 'RosterCopyResultSkippedInner':
      return RosterCopyResultSkippedInner.fromJson(
            value as Map<String, dynamic>,
          )
          as ReturnType;
    case 'RosterDay':
      return RosterDay.fromJson(value as Map<String, dynamic>) as ReturnType;
    case 'RosterDaySummary':
      return RosterDaySummary.fromJson(value as Map<String, dynamic>)
          as ReturnType;
    case 'RosterEmployee':
      return RosterEmployee.fromJson(value as Map<String, dynamic>)
          as ReturnType;
    case 'RosterWarning':
      return RosterWarning.fromJson(value as Map<String, dynamic>)
          as ReturnType;
    case 'RouteCreateBody':
      return RouteCreateBody.fromJson(value as Map<String, dynamic>)
          as ReturnType;
    case 'RouteItem':
      return RouteItem.fromJson(value as Map<String, dynamic>) as ReturnType;
    case 'RouteList':
      return RouteList.fromJson(value as Map<String, dynamic>) as ReturnType;
    case 'RouteUpdateBody':
      return RouteUpdateBody.fromJson(value as Map<String, dynamic>)
          as ReturnType;
    case 'SelfMarkBody':
      return SelfMarkBody.fromJson(value as Map<String, dynamic>) as ReturnType;
    case 'SettingItem':
      return SettingItem.fromJson(value as Map<String, dynamic>) as ReturnType;
    case 'SettingList':
      return SettingList.fromJson(value as Map<String, dynamic>) as ReturnType;
    case 'SettingUpdateBody':
      return SettingUpdateBody.fromJson(value as Map<String, dynamic>)
          as ReturnType;
    case 'SignedUrlResponse':
      return SignedUrlResponse.fromJson(value as Map<String, dynamic>)
          as ReturnType;
    case 'SpareItem':
      return SpareItem.fromJson(value as Map<String, dynamic>) as ReturnType;
    case 'SpareList':
      return SpareList.fromJson(value as Map<String, dynamic>) as ReturnType;
    case 'TaskCreateBody':
      return TaskCreateBody.fromJson(value as Map<String, dynamic>)
          as ReturnType;
    case 'TaskItem':
      return TaskItem.fromJson(value as Map<String, dynamic>) as ReturnType;
    case 'TaskList':
      return TaskList.fromJson(value as Map<String, dynamic>) as ReturnType;
    case 'TaskPage':
      return TaskPage.fromJson(value as Map<String, dynamic>) as ReturnType;
    case 'TaskPriority':
    case 'TaskReopenBody':
      return TaskReopenBody.fromJson(value as Map<String, dynamic>)
          as ReturnType;
    case 'TaskStatus':
    case 'TaskSubmitBody':
      return TaskSubmitBody.fromJson(value as Map<String, dynamic>)
          as ReturnType;
    case 'TeamAttendanceDay':
      return TeamAttendanceDay.fromJson(value as Map<String, dynamic>)
          as ReturnType;
    case 'TeamAttendanceDaySummary':
      return TeamAttendanceDaySummary.fromJson(value as Map<String, dynamic>)
          as ReturnType;
    case 'TeamAttendanceRow':
      return TeamAttendanceRow.fromJson(value as Map<String, dynamic>)
          as ReturnType;
    case 'TeamAttendanceRowDutiesInner':
      return TeamAttendanceRowDutiesInner.fromJson(
            value as Map<String, dynamic>,
          )
          as ReturnType;
    case 'TeamAttendanceRowLeave':
      return TeamAttendanceRowLeave.fromJson(value as Map<String, dynamic>)
          as ReturnType;
    case 'TokenPair':
      return TokenPair.fromJson(value as Map<String, dynamic>) as ReturnType;
    case 'UserCreateBody':
      return UserCreateBody.fromJson(value as Map<String, dynamic>)
          as ReturnType;
    case 'UserItem':
      return UserItem.fromJson(value as Map<String, dynamic>) as ReturnType;
    case 'UserList':
      return UserList.fromJson(value as Map<String, dynamic>) as ReturnType;
    case 'UserUpdateBody':
      return UserUpdateBody.fromJson(value as Map<String, dynamic>)
          as ReturnType;
    case 'VehicleCreateBody':
      return VehicleCreateBody.fromJson(value as Map<String, dynamic>)
          as ReturnType;
    case 'VehicleItem':
      return VehicleItem.fromJson(value as Map<String, dynamic>) as ReturnType;
    case 'VehicleList':
      return VehicleList.fromJson(value as Map<String, dynamic>) as ReturnType;
    case 'VehicleStatus':
    case 'VehicleUpdateBody':
      return VehicleUpdateBody.fromJson(value as Map<String, dynamic>)
          as ReturnType;
    default:
      RegExpMatch? match;

      if (value is List && (match = _regList.firstMatch(targetType)) != null) {
        targetType = match![1]!; // ignore: parameter_assignments
        return value
                .map<BaseType>(
                  (dynamic v) => deserialize<BaseType, BaseType>(
                    v,
                    targetType,
                    growable: growable,
                  ),
                )
                .toList(growable: growable)
            as ReturnType;
      }
      if (value is Set && (match = _regSet.firstMatch(targetType)) != null) {
        targetType = match![1]!; // ignore: parameter_assignments
        return value
                .map<BaseType>(
                  (dynamic v) => deserialize<BaseType, BaseType>(
                    v,
                    targetType,
                    growable: growable,
                  ),
                )
                .toSet()
            as ReturnType;
      }
      if (value is Map && (match = _regMap.firstMatch(targetType)) != null) {
        targetType = match![1]!.trim(); // ignore: parameter_assignments
        return Map<String, BaseType>.fromIterables(
              value.keys as Iterable<String>,
              value.values.map(
                (dynamic v) => deserialize<BaseType, BaseType>(
                  v,
                  targetType,
                  growable: growable,
                ),
              ),
            )
            as ReturnType;
      }
      break;
  }
  throw Exception('Cannot deserialize');
}
