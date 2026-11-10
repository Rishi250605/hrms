# hrms_api.api.AttendanceApi

## Load the API package
```dart
import 'package:hrms_api/api.dart';
```

All URIs are relative to */api/v1*

Method | HTTP request | Description
------------- | ------------- | -------------
[**approveAttendance**](AttendanceApi.md#approveattendance) | **POST** /attendance/{id}/approve | Approve a self-mark of a direct report
[**approveAttendanceCorrection**](AttendanceApi.md#approveattendancecorrection) | **POST** /attendance/corrections/{id}/approve | Approve a correction (applies the mark)
[**bulkApproveAttendance**](AttendanceApi.md#bulkapproveattendance) | **POST** /attendance/approvals/bulk-approve | Approve several pending self-marks
[**getTeamAttendance**](AttendanceApi.md#getteamattendance) | **GET** /attendance/team | RM: the day&#39;s drivers and loadmen, pre-filled PRESENT (leave / OD pre-filled from approved requests)
[**listAttendanceApprovals**](AttendanceApi.md#listattendanceapprovals) | **GET** /attendance/approvals | Self-marks of my direct reports (OM: RMs, HR: OMs, director: HR)
[**listAttendanceCorrections**](AttendanceApi.md#listattendancecorrections) | **GET** /attendance/corrections | Corrections I raised (scope&#x3D;mine) or that wait for me (scope&#x3D;approvals)
[**listAttendanceMarks**](AttendanceApi.md#listattendancemarks) | **GET** /attendance/marks | Attendance marks in my scope (read-only)
[**listSelfAttendance**](AttendanceApi.md#listselfattendance) | **GET** /attendance/self | My own attendance marks
[**markSelfAttendance**](AttendanceApi.md#markselfattendance) | **POST** /attendance/self | Mark my own attendance (goes to my reporting manager for approval)
[**markTeamAttendance**](AttendanceApi.md#markteamattendance) | **POST** /attendance/team/bulk | RM: mark drivers / loadmen (final; idempotent by clientMutationId)
[**rejectAttendance**](AttendanceApi.md#rejectattendance) | **POST** /attendance/{id}/reject | Reject a self-mark (reason required); it can be corrected and resubmitted
[**rejectAttendanceCorrection**](AttendanceApi.md#rejectattendancecorrection) | **POST** /attendance/corrections/{id}/reject | Reject a correction (reason required)
[**requestAttendanceCorrection**](AttendanceApi.md#requestattendancecorrection) | **POST** /attendance/corrections | Change a mark after the edit window or after approval (approved by my reporting manager)


# **approveAttendance**
> AttendanceMarkItem approveAttendance(id)

Approve a self-mark of a direct report

Roles: OPERATIONAL_MANAGER, HR, DIRECTOR.

### Example
```dart
import 'package:hrms_api/api.dart';

final api = HrmsApi().getAttendanceApi();
final String id = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 

try {
    final response = api.approveAttendance(id);
    print(response);
} on DioException catch (e) {
    print('Exception when calling AttendanceApi->approveAttendance: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 

### Return type

[**AttendanceMarkItem**](AttendanceMarkItem.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **approveAttendanceCorrection**
> CorrectionItem approveAttendanceCorrection(id)

Approve a correction (applies the mark)

Roles: OPERATIONAL_MANAGER, HR, DIRECTOR.

### Example
```dart
import 'package:hrms_api/api.dart';

final api = HrmsApi().getAttendanceApi();
final String id = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 

try {
    final response = api.approveAttendanceCorrection(id);
    print(response);
} on DioException catch (e) {
    print('Exception when calling AttendanceApi->approveAttendanceCorrection: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 

### Return type

[**CorrectionItem**](CorrectionItem.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **bulkApproveAttendance**
> BulkApproveResult bulkApproveAttendance(bulkApproveBody)

Approve several pending self-marks

Roles: OPERATIONAL_MANAGER, HR, DIRECTOR.

### Example
```dart
import 'package:hrms_api/api.dart';

final api = HrmsApi().getAttendanceApi();
final BulkApproveBody bulkApproveBody = ; // BulkApproveBody | 

try {
    final response = api.bulkApproveAttendance(bulkApproveBody);
    print(response);
} on DioException catch (e) {
    print('Exception when calling AttendanceApi->bulkApproveAttendance: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **bulkApproveBody** | [**BulkApproveBody**](BulkApproveBody.md)|  | 

### Return type

[**BulkApproveResult**](BulkApproveResult.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getTeamAttendance**
> TeamAttendanceDay getTeamAttendance(date, businessUnitId)

RM: the day's drivers and loadmen, pre-filled PRESENT (leave / OD pre-filled from approved requests)

Roles: REGIONAL_MANAGER.

### Example
```dart
import 'package:hrms_api/api.dart';

final api = HrmsApi().getAttendanceApi();
final String date = 2026-11-09; // String | Calendar date (IST business date)
final String businessUnitId = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 

try {
    final response = api.getTeamAttendance(date, businessUnitId);
    print(response);
} on DioException catch (e) {
    print('Exception when calling AttendanceApi->getTeamAttendance: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **date** | **String**| Calendar date (IST business date) | 
 **businessUnitId** | **String**|  | [optional] 

### Return type

[**TeamAttendanceDay**](TeamAttendanceDay.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **listAttendanceApprovals**
> AttendanceMarkList listAttendanceApprovals(state, businessUnitId)

Self-marks of my direct reports (OM: RMs, HR: OMs, director: HR)

Roles: OPERATIONAL_MANAGER, HR, DIRECTOR.

### Example
```dart
import 'package:hrms_api/api.dart';

final api = HrmsApi().getAttendanceApi();
final ApprovalState state = ; // ApprovalState | 
final String businessUnitId = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 

try {
    final response = api.listAttendanceApprovals(state, businessUnitId);
    print(response);
} on DioException catch (e) {
    print('Exception when calling AttendanceApi->listAttendanceApprovals: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **state** | [**ApprovalState**](.md)|  | [optional] 
 **businessUnitId** | **String**|  | [optional] 

### Return type

[**AttendanceMarkList**](AttendanceMarkList.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **listAttendanceCorrections**
> CorrectionList listAttendanceCorrections(scope, status, businessUnitId)

Corrections I raised (scope=mine) or that wait for me (scope=approvals)

Any authenticated manager.

### Example
```dart
import 'package:hrms_api/api.dart';

final api = HrmsApi().getAttendanceApi();
final String scope = scope_example; // String | 
final RequestStatus status = ; // RequestStatus | 
final String businessUnitId = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 

try {
    final response = api.listAttendanceCorrections(scope, status, businessUnitId);
    print(response);
} on DioException catch (e) {
    print('Exception when calling AttendanceApi->listAttendanceCorrections: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **scope** | **String**|  | [optional] [default to 'mine']
 **status** | [**RequestStatus**](.md)|  | [optional] 
 **businessUnitId** | **String**|  | [optional] 

### Return type

[**CorrectionList**](CorrectionList.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **listAttendanceMarks**
> AttendanceMarkList listAttendanceMarks(from, to, businessUnitId, employeeId)

Attendance marks in my scope (read-only)

Any authenticated manager.

### Example
```dart
import 'package:hrms_api/api.dart';

final api = HrmsApi().getAttendanceApi();
final String from = 2026-11-09; // String | Calendar date (IST business date)
final String to = 2026-11-09; // String | Calendar date (IST business date)
final String businessUnitId = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 
final String employeeId = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 

try {
    final response = api.listAttendanceMarks(from, to, businessUnitId, employeeId);
    print(response);
} on DioException catch (e) {
    print('Exception when calling AttendanceApi->listAttendanceMarks: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **from** | **String**| Calendar date (IST business date) | 
 **to** | **String**| Calendar date (IST business date) | 
 **businessUnitId** | **String**|  | [optional] 
 **employeeId** | **String**|  | [optional] 

### Return type

[**AttendanceMarkList**](AttendanceMarkList.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **listSelfAttendance**
> AttendanceMarkList listSelfAttendance(from, to)

My own attendance marks

Any authenticated manager.

### Example
```dart
import 'package:hrms_api/api.dart';

final api = HrmsApi().getAttendanceApi();
final String from = 2026-11-09; // String | Calendar date (IST business date)
final String to = 2026-11-09; // String | Calendar date (IST business date)

try {
    final response = api.listSelfAttendance(from, to);
    print(response);
} on DioException catch (e) {
    print('Exception when calling AttendanceApi->listSelfAttendance: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **from** | **String**| Calendar date (IST business date) | 
 **to** | **String**| Calendar date (IST business date) | 

### Return type

[**AttendanceMarkList**](AttendanceMarkList.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **markSelfAttendance**
> AttendanceMarkItem markSelfAttendance(selfMarkBody)

Mark my own attendance (goes to my reporting manager for approval)

Roles: REGIONAL_MANAGER, OPERATIONAL_MANAGER, HR.

### Example
```dart
import 'package:hrms_api/api.dart';

final api = HrmsApi().getAttendanceApi();
final SelfMarkBody selfMarkBody = ; // SelfMarkBody | 

try {
    final response = api.markSelfAttendance(selfMarkBody);
    print(response);
} on DioException catch (e) {
    print('Exception when calling AttendanceApi->markSelfAttendance: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **selfMarkBody** | [**SelfMarkBody**](SelfMarkBody.md)|  | 

### Return type

[**AttendanceMarkItem**](AttendanceMarkItem.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **markTeamAttendance**
> BulkAttendanceResult markTeamAttendance(bulkAttendanceBody)

RM: mark drivers / loadmen (final; idempotent by clientMutationId)

Each mark is applied independently: APPLIED, DUPLICATE (replay) or REJECTED (EDIT_WINDOW_CLOSED, FUTURE_DATE, INVALID_ASSIGNMENT, CLIENT_ID_REUSED). Any employee who does not report to the RM refuses the whole request with 403.  Roles: REGIONAL_MANAGER.

### Example
```dart
import 'package:hrms_api/api.dart';

final api = HrmsApi().getAttendanceApi();
final BulkAttendanceBody bulkAttendanceBody = ; // BulkAttendanceBody | 

try {
    final response = api.markTeamAttendance(bulkAttendanceBody);
    print(response);
} on DioException catch (e) {
    print('Exception when calling AttendanceApi->markTeamAttendance: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **bulkAttendanceBody** | [**BulkAttendanceBody**](BulkAttendanceBody.md)|  | 

### Return type

[**BulkAttendanceResult**](BulkAttendanceResult.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **rejectAttendance**
> AttendanceMarkItem rejectAttendance(id, rejectReasonBody)

Reject a self-mark (reason required); it can be corrected and resubmitted

Roles: OPERATIONAL_MANAGER, HR, DIRECTOR.

### Example
```dart
import 'package:hrms_api/api.dart';

final api = HrmsApi().getAttendanceApi();
final String id = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 
final RejectReasonBody rejectReasonBody = ; // RejectReasonBody | 

try {
    final response = api.rejectAttendance(id, rejectReasonBody);
    print(response);
} on DioException catch (e) {
    print('Exception when calling AttendanceApi->rejectAttendance: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 
 **rejectReasonBody** | [**RejectReasonBody**](RejectReasonBody.md)|  | 

### Return type

[**AttendanceMarkItem**](AttendanceMarkItem.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **rejectAttendanceCorrection**
> CorrectionItem rejectAttendanceCorrection(id, rejectReasonBody)

Reject a correction (reason required)

Roles: OPERATIONAL_MANAGER, HR, DIRECTOR.

### Example
```dart
import 'package:hrms_api/api.dart';

final api = HrmsApi().getAttendanceApi();
final String id = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 
final RejectReasonBody rejectReasonBody = ; // RejectReasonBody | 

try {
    final response = api.rejectAttendanceCorrection(id, rejectReasonBody);
    print(response);
} on DioException catch (e) {
    print('Exception when calling AttendanceApi->rejectAttendanceCorrection: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 
 **rejectReasonBody** | [**RejectReasonBody**](RejectReasonBody.md)|  | 

### Return type

[**CorrectionItem**](CorrectionItem.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **requestAttendanceCorrection**
> CorrectionItem requestAttendanceCorrection(correctionBody)

Change a mark after the edit window or after approval (approved by my reporting manager)

Roles: REGIONAL_MANAGER, OPERATIONAL_MANAGER, HR.

### Example
```dart
import 'package:hrms_api/api.dart';

final api = HrmsApi().getAttendanceApi();
final CorrectionBody correctionBody = ; // CorrectionBody | 

try {
    final response = api.requestAttendanceCorrection(correctionBody);
    print(response);
} on DioException catch (e) {
    print('Exception when calling AttendanceApi->requestAttendanceCorrection: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **correctionBody** | [**CorrectionBody**](CorrectionBody.md)|  | 

### Return type

[**CorrectionItem**](CorrectionItem.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

