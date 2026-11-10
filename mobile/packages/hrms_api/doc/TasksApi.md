# hrms_api.api.TasksApi

## Load the API package
```dart
import 'package:hrms_api/api.dart';
```

All URIs are relative to */api/v1*

Method | HTTP request | Description
------------- | ------------- | -------------
[**createTasks**](TasksApi.md#createtasks) | **POST** /tasks | Allot a task to one or more RMs (one task each)
[**getTask**](TasksApi.md#gettask) | **GET** /tasks/{id} | One task
[**listTasks**](TasksApi.md#listtasks) | **GET** /tasks | Tasks assigned to me (RM), allotted by me (OM) or all (HR / director)
[**reopenTask**](TasksApi.md#reopentask) | **POST** /tasks/{id}/reopen | Reopen a submitted task with a comment
[**submitTask**](TasksApi.md#submittask) | **POST** /tasks/{id}/submit | Submit as completed or not done (reason required); locks the task


# **createTasks**
> TaskList createTasks(taskCreateBody)

Allot a task to one or more RMs (one task each)

Roles: OPERATIONAL_MANAGER.

### Example
```dart
import 'package:hrms_api/api.dart';

final api = HrmsApi().getTasksApi();
final TaskCreateBody taskCreateBody = ; // TaskCreateBody | 

try {
    final response = api.createTasks(taskCreateBody);
    print(response);
} on DioException catch (e) {
    print('Exception when calling TasksApi->createTasks: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **taskCreateBody** | [**TaskCreateBody**](TaskCreateBody.md)|  | 

### Return type

[**TaskList**](TaskList.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getTask**
> TaskItem getTask(id)

One task

Any authenticated manager.

### Example
```dart
import 'package:hrms_api/api.dart';

final api = HrmsApi().getTasksApi();
final String id = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 

try {
    final response = api.getTask(id);
    print(response);
} on DioException catch (e) {
    print('Exception when calling TasksApi->getTask: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 

### Return type

[**TaskItem**](TaskItem.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **listTasks**
> TaskPage listTasks(cursor, limit, scope, state, status, overdue, date, from, to, businessUnitId, assigneeEmployeeId, allottedByEmployeeId)

Tasks assigned to me (RM), allotted by me (OM) or all (HR / director)

Any authenticated manager.

### Example
```dart
import 'package:hrms_api/api.dart';

final api = HrmsApi().getTasksApi();
final String cursor = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | The nextCursor of the previous page
final int limit = 56; // int | 
final String scope = scope_example; // String | allotted: by me (OM); assigned: to me (RM); all: HR / director
final String state = state_example; // String | open: PENDING (incl. overdue); submitted: COMPLETED or NOT_DONE
final TaskStatus status = ; // TaskStatus | 
final bool overdue = true; // bool | 
final String date = 2026-11-09; // String | Calendar date (IST business date)
final String from = 2026-11-09; // String | Calendar date (IST business date)
final String to = 2026-11-09; // String | Calendar date (IST business date)
final String businessUnitId = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 
final String assigneeEmployeeId = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 
final String allottedByEmployeeId = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 

try {
    final response = api.listTasks(cursor, limit, scope, state, status, overdue, date, from, to, businessUnitId, assigneeEmployeeId, allottedByEmployeeId);
    print(response);
} on DioException catch (e) {
    print('Exception when calling TasksApi->listTasks: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **cursor** | **String**| The nextCursor of the previous page | [optional] 
 **limit** | **int**|  | [optional] [default to 50]
 **scope** | **String**| allotted: by me (OM); assigned: to me (RM); all: HR / director | [optional] [default to 'assigned']
 **state** | **String**| open: PENDING (incl. overdue); submitted: COMPLETED or NOT_DONE | [optional] 
 **status** | [**TaskStatus**](.md)|  | [optional] 
 **overdue** | **bool**|  | [optional] 
 **date** | **String**| Calendar date (IST business date) | [optional] 
 **from** | **String**| Calendar date (IST business date) | [optional] 
 **to** | **String**| Calendar date (IST business date) | [optional] 
 **businessUnitId** | **String**|  | [optional] 
 **assigneeEmployeeId** | **String**|  | [optional] 
 **allottedByEmployeeId** | **String**|  | [optional] 

### Return type

[**TaskPage**](TaskPage.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **reopenTask**
> TaskItem reopenTask(id, taskReopenBody)

Reopen a submitted task with a comment

Roles: OPERATIONAL_MANAGER.

### Example
```dart
import 'package:hrms_api/api.dart';

final api = HrmsApi().getTasksApi();
final String id = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 
final TaskReopenBody taskReopenBody = ; // TaskReopenBody | 

try {
    final response = api.reopenTask(id, taskReopenBody);
    print(response);
} on DioException catch (e) {
    print('Exception when calling TasksApi->reopenTask: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 
 **taskReopenBody** | [**TaskReopenBody**](TaskReopenBody.md)|  | 

### Return type

[**TaskItem**](TaskItem.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **submitTask**
> TaskItem submitTask(id, taskSubmitBody)

Submit as completed or not done (reason required); locks the task

Roles: REGIONAL_MANAGER.

### Example
```dart
import 'package:hrms_api/api.dart';

final api = HrmsApi().getTasksApi();
final String id = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 
final TaskSubmitBody taskSubmitBody = ; // TaskSubmitBody | 

try {
    final response = api.submitTask(id, taskSubmitBody);
    print(response);
} on DioException catch (e) {
    print('Exception when calling TasksApi->submitTask: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 
 **taskSubmitBody** | [**TaskSubmitBody**](TaskSubmitBody.md)|  | 

### Return type

[**TaskItem**](TaskItem.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

