# hrms_api.api.PerformanceApi

## Load the API package
```dart
import 'package:hrms_api/api.dart';
```

All URIs are relative to */api/v1*

Method | HTTP request | Description
------------- | ------------- | -------------
[**createPerformanceMetric**](PerformanceApi.md#createperformancemetric) | **POST** /performance-metrics | Add a weekly metric
[**getPerformance**](PerformanceApi.md#getperformance) | **GET** /performance/employees/{employeeId} | A person&#39;s rating history and weekly values (self, HR in the BU, director)
[**listPerformanceMetrics**](PerformanceApi.md#listperformancemetrics) | **GET** /performance-metrics | Weekly performance metrics (Mileage, Employee count, Maintenance, …)
[**listPerformancePeople**](PerformanceApi.md#listperformancepeople) | **GET** /performance/people | RMs, OMs and HRs in my business units with their latest rating (HR / director)
[**putPerformanceWeek**](PerformanceApi.md#putperformanceweek) | **PUT** /performance/employees/{employeeId}/weeks/{weekStart} | Enter or change a person&#39;s weekly metric values (director); null removes a value
[**ratePerformance**](PerformanceApi.md#rateperformance) | **POST** /performance/employees/{employeeId}/ratings | Rate a person 1–5 (HR: RMs and OMs in their BUs; director: anyone rated)
[**updatePerformanceMetric**](PerformanceApi.md#updateperformancemetric) | **PATCH** /performance-metrics/{id} | Rename, reorder or deactivate a weekly metric


# **createPerformanceMetric**
> PerformanceMetricItem createPerformanceMetric(performanceMetricCreateBody)

Add a weekly metric

Roles: DIRECTOR.

### Example
```dart
import 'package:hrms_api/api.dart';

final api = HrmsApi().getPerformanceApi();
final PerformanceMetricCreateBody performanceMetricCreateBody = ; // PerformanceMetricCreateBody | 

try {
    final response = api.createPerformanceMetric(performanceMetricCreateBody);
    print(response);
} on DioException catch (e) {
    print('Exception when calling PerformanceApi->createPerformanceMetric: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **performanceMetricCreateBody** | [**PerformanceMetricCreateBody**](PerformanceMetricCreateBody.md)|  | 

### Return type

[**PerformanceMetricItem**](PerformanceMetricItem.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getPerformance**
> PerformanceSummary getPerformance(employeeId, weeks)

A person's rating history and weekly values (self, HR in the BU, director)

Any authenticated manager.

### Example
```dart
import 'package:hrms_api/api.dart';

final api = HrmsApi().getPerformanceApi();
final String employeeId = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 
final int weeks = 56; // int | How many recent weeks to return

try {
    final response = api.getPerformance(employeeId, weeks);
    print(response);
} on DioException catch (e) {
    print('Exception when calling PerformanceApi->getPerformance: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **employeeId** | **String**|  | 
 **weeks** | **int**| How many recent weeks to return | [optional] 

### Return type

[**PerformanceSummary**](PerformanceSummary.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **listPerformanceMetrics**
> PerformanceMetricList listPerformanceMetrics()

Weekly performance metrics (Mileage, Employee count, Maintenance, …)

Any authenticated manager.

### Example
```dart
import 'package:hrms_api/api.dart';

final api = HrmsApi().getPerformanceApi();

try {
    final response = api.listPerformanceMetrics();
    print(response);
} on DioException catch (e) {
    print('Exception when calling PerformanceApi->listPerformanceMetrics: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**PerformanceMetricList**](PerformanceMetricList.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **listPerformancePeople**
> PerformancePersonList listPerformancePeople(businessUnitId)

RMs, OMs and HRs in my business units with their latest rating (HR / director)

Roles: HR, DIRECTOR.

### Example
```dart
import 'package:hrms_api/api.dart';

final api = HrmsApi().getPerformanceApi();
final String businessUnitId = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 

try {
    final response = api.listPerformancePeople(businessUnitId);
    print(response);
} on DioException catch (e) {
    print('Exception when calling PerformanceApi->listPerformancePeople: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **businessUnitId** | **String**|  | [optional] 

### Return type

[**PerformancePersonList**](PerformancePersonList.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **putPerformanceWeek**
> PerformanceSummary putPerformanceWeek(employeeId, weekStart, performanceWeekBody)

Enter or change a person's weekly metric values (director); null removes a value

Roles: DIRECTOR.

### Example
```dart
import 'package:hrms_api/api.dart';

final api = HrmsApi().getPerformanceApi();
final String employeeId = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 
final String weekStart = 2026-11-09; // String | Calendar date (IST business date)
final PerformanceWeekBody performanceWeekBody = ; // PerformanceWeekBody | 

try {
    final response = api.putPerformanceWeek(employeeId, weekStart, performanceWeekBody);
    print(response);
} on DioException catch (e) {
    print('Exception when calling PerformanceApi->putPerformanceWeek: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **employeeId** | **String**|  | 
 **weekStart** | **String**| Calendar date (IST business date) | 
 **performanceWeekBody** | [**PerformanceWeekBody**](PerformanceWeekBody.md)|  | 

### Return type

[**PerformanceSummary**](PerformanceSummary.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **ratePerformance**
> PerformanceRatingItem ratePerformance(employeeId, performanceRatingCreateBody)

Rate a person 1–5 (HR: RMs and OMs in their BUs; director: anyone rated)

Roles: HR, DIRECTOR.

### Example
```dart
import 'package:hrms_api/api.dart';

final api = HrmsApi().getPerformanceApi();
final String employeeId = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 
final PerformanceRatingCreateBody performanceRatingCreateBody = ; // PerformanceRatingCreateBody | 

try {
    final response = api.ratePerformance(employeeId, performanceRatingCreateBody);
    print(response);
} on DioException catch (e) {
    print('Exception when calling PerformanceApi->ratePerformance: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **employeeId** | **String**|  | 
 **performanceRatingCreateBody** | [**PerformanceRatingCreateBody**](PerformanceRatingCreateBody.md)|  | 

### Return type

[**PerformanceRatingItem**](PerformanceRatingItem.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **updatePerformanceMetric**
> PerformanceMetricItem updatePerformanceMetric(id, performanceMetricUpdateBody)

Rename, reorder or deactivate a weekly metric

Roles: DIRECTOR.

### Example
```dart
import 'package:hrms_api/api.dart';

final api = HrmsApi().getPerformanceApi();
final String id = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 
final PerformanceMetricUpdateBody performanceMetricUpdateBody = ; // PerformanceMetricUpdateBody | 

try {
    final response = api.updatePerformanceMetric(id, performanceMetricUpdateBody);
    print(response);
} on DioException catch (e) {
    print('Exception when calling PerformanceApi->updatePerformanceMetric: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 
 **performanceMetricUpdateBody** | [**PerformanceMetricUpdateBody**](PerformanceMetricUpdateBody.md)|  | 

### Return type

[**PerformanceMetricItem**](PerformanceMetricItem.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

