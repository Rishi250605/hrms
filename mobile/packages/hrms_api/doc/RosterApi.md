# hrms_api.api.RosterApi

## Load the API package
```dart
import 'package:hrms_api/api.dart';
```

All URIs are relative to */api/v1*

Method | HTTP request | Description
------------- | ------------- | -------------
[**assignToDuty**](RosterApi.md#assigntoduty) | **POST** /duties/{id}/assignments | Assign an employee to a duty
[**copyRoster**](RosterApi.md#copyroster) | **POST** /roster/copy | Copy a day (or week) of duties and crew to later dates
[**createDuty**](RosterApi.md#createduty) | **POST** /duties | Create a duty (from a template or explicit times)
[**getRoster**](RosterApi.md#getroster) | **GET** /roster | Day view of a depot: duties with crew, vehicle and route
[**getRosterSpares**](RosterApi.md#getrosterspares) | **GET** /roster/spares | Available spares from the depot pool (documents valid, not on leave, free)
[**removeDutyAssignment**](RosterApi.md#removedutyassignment) | **DELETE** /duty-assignments/{id} | Remove an employee from a duty
[**updateDuty**](RosterApi.md#updateduty) | **PATCH** /duties/{id} | Change times, vehicle, route, status or notes of a duty


# **assignToDuty**
> AssignmentResult assignToDuty(id, assignmentCreateBody)

Assign an employee to a duty

409 DOCUMENT_INVALID (details: failing documents + suggested spares), EMPLOYEE_ON_LEAVE, EMPLOYEE_DOUBLE_BOOKED, EMPLOYEE_NOT_IN_DEPOT, ROLE_NOT_ALLOWED, ROSTER_RULE_VIOLATION (rules set to BLOCK). Rules set to WARN come back in `warnings`.  Any authenticated manager.

### Example
```dart
import 'package:hrms_api/api.dart';

final api = HrmsApi().getRosterApi();
final String id = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 
final AssignmentCreateBody assignmentCreateBody = ; // AssignmentCreateBody | 

try {
    final response = api.assignToDuty(id, assignmentCreateBody);
    print(response);
} on DioException catch (e) {
    print('Exception when calling RosterApi->assignToDuty: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 
 **assignmentCreateBody** | [**AssignmentCreateBody**](AssignmentCreateBody.md)|  | 

### Return type

[**AssignmentResult**](AssignmentResult.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **copyRoster**
> RosterCopyResult copyRoster(rosterCopyBody)

Copy a day (or week) of duties and crew to later dates

Assignments that fail any check (documents, leave, overlaps, BLOCK rules) are skipped and reported.  Any authenticated manager.

### Example
```dart
import 'package:hrms_api/api.dart';

final api = HrmsApi().getRosterApi();
final RosterCopyBody rosterCopyBody = ; // RosterCopyBody | 

try {
    final response = api.copyRoster(rosterCopyBody);
    print(response);
} on DioException catch (e) {
    print('Exception when calling RosterApi->copyRoster: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **rosterCopyBody** | [**RosterCopyBody**](RosterCopyBody.md)|  | 

### Return type

[**RosterCopyResult**](RosterCopyResult.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **createDuty**
> DutyItem createDuty(dutyCreateBody)

Create a duty (from a template or explicit times)

Any authenticated manager.

### Example
```dart
import 'package:hrms_api/api.dart';

final api = HrmsApi().getRosterApi();
final DutyCreateBody dutyCreateBody = ; // DutyCreateBody | 

try {
    final response = api.createDuty(dutyCreateBody);
    print(response);
} on DioException catch (e) {
    print('Exception when calling RosterApi->createDuty: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **dutyCreateBody** | [**DutyCreateBody**](DutyCreateBody.md)|  | 

### Return type

[**DutyItem**](DutyItem.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getRoster**
> RosterDay getRoster(depotId, date)

Day view of a depot: duties with crew, vehicle and route

Any authenticated manager.

### Example
```dart
import 'package:hrms_api/api.dart';

final api = HrmsApi().getRosterApi();
final String depotId = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 
final String date = 2026-11-09; // String | Calendar date (IST business date)

try {
    final response = api.getRoster(depotId, date);
    print(response);
} on DioException catch (e) {
    print('Exception when calling RosterApi->getRoster: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **depotId** | **String**|  | 
 **date** | **String**| Calendar date (IST business date) | 

### Return type

[**RosterDay**](RosterDay.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getRosterSpares**
> SpareList getRosterSpares(depotId, date, role, dutyId)

Available spares from the depot pool (documents valid, not on leave, free)

Any authenticated manager.

### Example
```dart
import 'package:hrms_api/api.dart';

final api = HrmsApi().getRosterApi();
final String depotId = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 
final String date = 2026-11-09; // String | Calendar date (IST business date)
final AssignmentRole role = ; // AssignmentRole | 
final String dutyId = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | Exclude employees whose duties overlap this one, and compute warnings for it

try {
    final response = api.getRosterSpares(depotId, date, role, dutyId);
    print(response);
} on DioException catch (e) {
    print('Exception when calling RosterApi->getRosterSpares: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **depotId** | **String**|  | 
 **date** | **String**| Calendar date (IST business date) | 
 **role** | [**AssignmentRole**](.md)|  | [optional] 
 **dutyId** | **String**| Exclude employees whose duties overlap this one, and compute warnings for it | [optional] 

### Return type

[**SpareList**](SpareList.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **removeDutyAssignment**
> removeDutyAssignment(id)

Remove an employee from a duty

Any authenticated manager.

### Example
```dart
import 'package:hrms_api/api.dart';

final api = HrmsApi().getRosterApi();
final String id = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 

try {
    api.removeDutyAssignment(id);
} on DioException catch (e) {
    print('Exception when calling RosterApi->removeDutyAssignment: $e\n');
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

# **updateDuty**
> DutyItem updateDuty(id, dutyUpdateBody)

Change times, vehicle, route, status or notes of a duty

Any authenticated manager.

### Example
```dart
import 'package:hrms_api/api.dart';

final api = HrmsApi().getRosterApi();
final String id = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 
final DutyUpdateBody dutyUpdateBody = ; // DutyUpdateBody | 

try {
    final response = api.updateDuty(id, dutyUpdateBody);
    print(response);
} on DioException catch (e) {
    print('Exception when calling RosterApi->updateDuty: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 
 **dutyUpdateBody** | [**DutyUpdateBody**](DutyUpdateBody.md)|  | 

### Return type

[**DutyItem**](DutyItem.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

