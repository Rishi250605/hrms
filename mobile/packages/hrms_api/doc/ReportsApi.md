# hrms_api.api.ReportsApi

## Load the API package
```dart
import 'package:hrms_api/api.dart';
```

All URIs are relative to */api/v1*

Method | HTTP request | Description
------------- | ------------- | -------------
[**attendanceReport**](ReportsApi.md#attendancereport) | **GET** /reports/attendance | Attendance muster and per-employee summary (scoped by §11)
[**exportAttendanceReport**](ReportsApi.md#exportattendancereport) | **GET** /reports/attendance/export | Excel (muster + summary sheets) or PDF (landscape muster) download
[**getDashboard**](ReportsApi.md#getdashboard) | **GET** /reports/dashboard | Home screen cards per business unit and my pending items


# **attendanceReport**
> AttendanceReport attendanceReport(businessUnitId, from, to, role, employeeId, status, approvalState)

Attendance muster and per-employee summary (scoped by §11)

Any authenticated manager.

### Example
```dart
import 'package:hrms_api/api.dart';

final api = HrmsApi().getReportsApi();
final String businessUnitId = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 
final String from = 2026-11-09; // String | Default: first day of the current month
final String to = 2026-11-09; // String | Default: last day of the month of `from`
final ReportGroup role = ; // ReportGroup | Drivers, loadmen, or managers of one role
final String employeeId = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 
final AttendanceStatus status = ; // AttendanceStatus | Only days with this status (and people who have one)
final ApprovalState approvalState = ; // ApprovalState | Only days in this approval state (and people who have one)

try {
    final response = api.attendanceReport(businessUnitId, from, to, role, employeeId, status, approvalState);
    print(response);
} on DioException catch (e) {
    print('Exception when calling ReportsApi->attendanceReport: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **businessUnitId** | **String**|  | [optional] 
 **from** | **String**| Default: first day of the current month | [optional] 
 **to** | **String**| Default: last day of the month of `from` | [optional] 
 **role** | [**ReportGroup**](.md)| Drivers, loadmen, or managers of one role | [optional] 
 **employeeId** | **String**|  | [optional] 
 **status** | [**AttendanceStatus**](.md)| Only days with this status (and people who have one) | [optional] 
 **approvalState** | [**ApprovalState**](.md)| Only days in this approval state (and people who have one) | [optional] 

### Return type

[**AttendanceReport**](AttendanceReport.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **exportAttendanceReport**
> ReportFile exportAttendanceReport(format, businessUnitId, from, to, role, employeeId, status, approvalState)

Excel (muster + summary sheets) or PDF (landscape muster) download

Generated server-side and returned as a signed URL (≤ 10 min). Every export is audit-logged.  Any authenticated manager.

### Example
```dart
import 'package:hrms_api/api.dart';

final api = HrmsApi().getReportsApi();
final String format = format_example; // String | 
final String businessUnitId = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 
final String from = 2026-11-09; // String | Default: first day of the current month
final String to = 2026-11-09; // String | Default: last day of the month of `from`
final ReportGroup role = ; // ReportGroup | Drivers, loadmen, or managers of one role
final String employeeId = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 
final AttendanceStatus status = ; // AttendanceStatus | Only days with this status (and people who have one)
final ApprovalState approvalState = ; // ApprovalState | Only days in this approval state (and people who have one)

try {
    final response = api.exportAttendanceReport(format, businessUnitId, from, to, role, employeeId, status, approvalState);
    print(response);
} on DioException catch (e) {
    print('Exception when calling ReportsApi->exportAttendanceReport: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **format** | **String**|  | 
 **businessUnitId** | **String**|  | [optional] 
 **from** | **String**| Default: first day of the current month | [optional] 
 **to** | **String**| Default: last day of the month of `from` | [optional] 
 **role** | [**ReportGroup**](.md)| Drivers, loadmen, or managers of one role | [optional] 
 **employeeId** | **String**|  | [optional] 
 **status** | [**AttendanceStatus**](.md)| Only days with this status (and people who have one) | [optional] 
 **approvalState** | [**ApprovalState**](.md)| Only days in this approval state (and people who have one) | [optional] 

### Return type

[**ReportFile**](ReportFile.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getDashboard**
> Dashboard getDashboard(businessUnitId)

Home screen cards per business unit and my pending items

Any authenticated manager.

### Example
```dart
import 'package:hrms_api/api.dart';

final api = HrmsApi().getReportsApi();
final String businessUnitId = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 

try {
    final response = api.getDashboard(businessUnitId);
    print(response);
} on DioException catch (e) {
    print('Exception when calling ReportsApi->getDashboard: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **businessUnitId** | **String**|  | [optional] 

### Return type

[**Dashboard**](Dashboard.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

