# hrms_api.api.LeaveApi

## Load the API package
```dart
import 'package:hrms_api/api.dart';
```

All URIs are relative to */api/v1*

Method | HTTP request | Description
------------- | ------------- | -------------
[**approveLeaveRequest**](LeaveApi.md#approveleaverequest) | **POST** /leave-requests/{id}/approve | Approve (sets attendance and deducts the balance)
[**cancelLeaveRequest**](LeaveApi.md#cancelleaverequest) | **POST** /leave-requests/{id}/cancel | Withdraw while pending (requester), or cancel an approved request (approver / HR)
[**createLeavePolicy**](LeaveApi.md#createleavepolicy) | **POST** /leave-policies | Add a leave policy
[**createLeaveRequest**](LeaveApi.md#createleaverequest) | **POST** /leave-requests | Raise leave or OD (for myself, or as an RM for my driver / loadman)
[**createLeaveType**](LeaveApi.md#createleavetype) | **POST** /leave-types | Add a leave type
[**deleteLeavePolicy**](LeaveApi.md#deleteleavepolicy) | **DELETE** /leave-policies/{id} | Remove a policy
[**getLeaveBalances**](LeaveApi.md#getleavebalances) | **GET** /leave-balances | An employee&#39;s leave balances for a year (applicable types only)
[**listLeavePolicies**](LeaveApi.md#listleavepolicies) | **GET** /leave-policies | Leave policies (quota per type and employee filter)
[**listLeaveRequests**](LeaveApi.md#listleaverequests) | **GET** /leave-requests | Leave and OD requests: mine, my team, waiting for me, or all (HR / director)
[**listLeaveTypes**](LeaveApi.md#listleavetypes) | **GET** /leave-types | Leave types
[**rejectLeaveRequest**](LeaveApi.md#rejectleaverequest) | **POST** /leave-requests/{id}/reject | Reject (reason required)
[**updateLeavePolicy**](LeaveApi.md#updateleavepolicy) | **PUT** /leave-policies/{id} | Change the quota of a policy
[**updateLeaveType**](LeaveApi.md#updateleavetype) | **PATCH** /leave-types/{id} | Change or deactivate a leave type


# **approveLeaveRequest**
> LeaveRequestItem approveLeaveRequest(id)

Approve (sets attendance and deducts the balance)

Any authenticated manager.

### Example
```dart
import 'package:hrms_api/api.dart';

final api = HrmsApi().getLeaveApi();
final String id = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 

try {
    final response = api.approveLeaveRequest(id);
    print(response);
} on DioException catch (e) {
    print('Exception when calling LeaveApi->approveLeaveRequest: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 

### Return type

[**LeaveRequestItem**](LeaveRequestItem.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **cancelLeaveRequest**
> LeaveRequestItem cancelLeaveRequest(id)

Withdraw while pending (requester), or cancel an approved request (approver / HR)

Any authenticated manager.

### Example
```dart
import 'package:hrms_api/api.dart';

final api = HrmsApi().getLeaveApi();
final String id = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 

try {
    final response = api.cancelLeaveRequest(id);
    print(response);
} on DioException catch (e) {
    print('Exception when calling LeaveApi->cancelLeaveRequest: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 

### Return type

[**LeaveRequestItem**](LeaveRequestItem.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **createLeavePolicy**
> LeavePolicyItem createLeavePolicy(leavePolicyBody)

Add a leave policy

Roles: HR, DIRECTOR.

### Example
```dart
import 'package:hrms_api/api.dart';

final api = HrmsApi().getLeaveApi();
final LeavePolicyBody leavePolicyBody = ; // LeavePolicyBody | 

try {
    final response = api.createLeavePolicy(leavePolicyBody);
    print(response);
} on DioException catch (e) {
    print('Exception when calling LeaveApi->createLeavePolicy: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **leavePolicyBody** | [**LeavePolicyBody**](LeavePolicyBody.md)|  | 

### Return type

[**LeavePolicyItem**](LeavePolicyItem.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **createLeaveRequest**
> LeaveRequestItem createLeaveRequest(leaveRequestCreateBody)

Raise leave or OD (for myself, or as an RM for my driver / loadman)

Routed to the subject’s reporting manager. An RM raising for their driver / loadman may approve at once (autoApprove).  Any authenticated manager.

### Example
```dart
import 'package:hrms_api/api.dart';

final api = HrmsApi().getLeaveApi();
final LeaveRequestCreateBody leaveRequestCreateBody = ; // LeaveRequestCreateBody | 

try {
    final response = api.createLeaveRequest(leaveRequestCreateBody);
    print(response);
} on DioException catch (e) {
    print('Exception when calling LeaveApi->createLeaveRequest: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **leaveRequestCreateBody** | [**LeaveRequestCreateBody**](LeaveRequestCreateBody.md)|  | 

### Return type

[**LeaveRequestItem**](LeaveRequestItem.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **createLeaveType**
> LeaveTypeItem createLeaveType(leaveTypeCreateBody)

Add a leave type

Roles: HR, DIRECTOR.

### Example
```dart
import 'package:hrms_api/api.dart';

final api = HrmsApi().getLeaveApi();
final LeaveTypeCreateBody leaveTypeCreateBody = ; // LeaveTypeCreateBody | 

try {
    final response = api.createLeaveType(leaveTypeCreateBody);
    print(response);
} on DioException catch (e) {
    print('Exception when calling LeaveApi->createLeaveType: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **leaveTypeCreateBody** | [**LeaveTypeCreateBody**](LeaveTypeCreateBody.md)|  | 

### Return type

[**LeaveTypeItem**](LeaveTypeItem.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **deleteLeavePolicy**
> deleteLeavePolicy(id)

Remove a policy

Roles: HR, DIRECTOR.

### Example
```dart
import 'package:hrms_api/api.dart';

final api = HrmsApi().getLeaveApi();
final String id = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 

try {
    api.deleteLeavePolicy(id);
} on DioException catch (e) {
    print('Exception when calling LeaveApi->deleteLeavePolicy: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 

### Return type

void (empty response body)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getLeaveBalances**
> LeaveBalanceList getLeaveBalances(employeeId, year)

An employee's leave balances for a year (applicable types only)

Any authenticated manager.

### Example
```dart
import 'package:hrms_api/api.dart';

final api = HrmsApi().getLeaveApi();
final String employeeId = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 
final int year = 56; // int | 

try {
    final response = api.getLeaveBalances(employeeId, year);
    print(response);
} on DioException catch (e) {
    print('Exception when calling LeaveApi->getLeaveBalances: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **employeeId** | **String**|  | 
 **year** | **int**|  | [optional] 

### Return type

[**LeaveBalanceList**](LeaveBalanceList.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **listLeavePolicies**
> LeavePolicyList listLeavePolicies()

Leave policies (quota per type and employee filter)

Any authenticated manager.

### Example
```dart
import 'package:hrms_api/api.dart';

final api = HrmsApi().getLeaveApi();

try {
    final response = api.listLeavePolicies();
    print(response);
} on DioException catch (e) {
    print('Exception when calling LeaveApi->listLeavePolicies: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**LeavePolicyList**](LeavePolicyList.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **listLeaveRequests**
> LeaveRequestPage listLeaveRequests(cursor, limit, scope, status, kind, businessUnitId, employeeId, from, to)

Leave and OD requests: mine, my team, waiting for me, or all (HR / director)

Any authenticated manager.

### Example
```dart
import 'package:hrms_api/api.dart';

final api = HrmsApi().getLeaveApi();
final String cursor = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | The nextCursor of the previous page
final int limit = 56; // int | 
final String scope = scope_example; // String | mine: about me; team: my reports; approvals: waiting for me; all: HR / director
final RequestStatus status = ; // RequestStatus | 
final LeaveKind kind = ; // LeaveKind | 
final String businessUnitId = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 
final String employeeId = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 
final String from = 2026-11-09; // String | Calendar date (IST business date)
final String to = 2026-11-09; // String | Calendar date (IST business date)

try {
    final response = api.listLeaveRequests(cursor, limit, scope, status, kind, businessUnitId, employeeId, from, to);
    print(response);
} on DioException catch (e) {
    print('Exception when calling LeaveApi->listLeaveRequests: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **cursor** | **String**| The nextCursor of the previous page | [optional] 
 **limit** | **int**|  | [optional] [default to 50]
 **scope** | **String**| mine: about me; team: my reports; approvals: waiting for me; all: HR / director | [optional] [default to 'mine']
 **status** | [**RequestStatus**](.md)|  | [optional] 
 **kind** | [**LeaveKind**](.md)|  | [optional] 
 **businessUnitId** | **String**|  | [optional] 
 **employeeId** | **String**|  | [optional] 
 **from** | **String**| Calendar date (IST business date) | [optional] 
 **to** | **String**| Calendar date (IST business date) | [optional] 

### Return type

[**LeaveRequestPage**](LeaveRequestPage.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **listLeaveTypes**
> LeaveTypeList listLeaveTypes()

Leave types

Any authenticated manager.

### Example
```dart
import 'package:hrms_api/api.dart';

final api = HrmsApi().getLeaveApi();

try {
    final response = api.listLeaveTypes();
    print(response);
} on DioException catch (e) {
    print('Exception when calling LeaveApi->listLeaveTypes: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**LeaveTypeList**](LeaveTypeList.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **rejectLeaveRequest**
> LeaveRequestItem rejectLeaveRequest(id, rejectReasonBody)

Reject (reason required)

Any authenticated manager.

### Example
```dart
import 'package:hrms_api/api.dart';

final api = HrmsApi().getLeaveApi();
final String id = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 
final RejectReasonBody rejectReasonBody = ; // RejectReasonBody | 

try {
    final response = api.rejectLeaveRequest(id, rejectReasonBody);
    print(response);
} on DioException catch (e) {
    print('Exception when calling LeaveApi->rejectLeaveRequest: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 
 **rejectReasonBody** | [**RejectReasonBody**](RejectReasonBody.md)|  | 

### Return type

[**LeaveRequestItem**](LeaveRequestItem.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **updateLeavePolicy**
> LeavePolicyItem updateLeavePolicy(id, leavePolicyUpdateBody)

Change the quota of a policy

Roles: HR, DIRECTOR.

### Example
```dart
import 'package:hrms_api/api.dart';

final api = HrmsApi().getLeaveApi();
final String id = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 
final LeavePolicyUpdateBody leavePolicyUpdateBody = ; // LeavePolicyUpdateBody | 

try {
    final response = api.updateLeavePolicy(id, leavePolicyUpdateBody);
    print(response);
} on DioException catch (e) {
    print('Exception when calling LeaveApi->updateLeavePolicy: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 
 **leavePolicyUpdateBody** | [**LeavePolicyUpdateBody**](LeavePolicyUpdateBody.md)|  | 

### Return type

[**LeavePolicyItem**](LeavePolicyItem.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **updateLeaveType**
> LeaveTypeItem updateLeaveType(id, leaveTypeUpdateBody)

Change or deactivate a leave type

Roles: HR, DIRECTOR.

### Example
```dart
import 'package:hrms_api/api.dart';

final api = HrmsApi().getLeaveApi();
final String id = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 
final LeaveTypeUpdateBody leaveTypeUpdateBody = ; // LeaveTypeUpdateBody | 

try {
    final response = api.updateLeaveType(id, leaveTypeUpdateBody);
    print(response);
} on DioException catch (e) {
    print('Exception when calling LeaveApi->updateLeaveType: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 
 **leaveTypeUpdateBody** | [**LeaveTypeUpdateBody**](LeaveTypeUpdateBody.md)|  | 

### Return type

[**LeaveTypeItem**](LeaveTypeItem.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

