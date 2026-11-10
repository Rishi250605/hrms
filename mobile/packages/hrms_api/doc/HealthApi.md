# hrms_api.api.HealthApi

## Load the API package
```dart
import 'package:hrms_api/api.dart';
```

All URIs are relative to */api/v1*

Method | HTTP request | Description
------------- | ------------- | -------------
[**getHealth**](HealthApi.md#gethealth) | **GET** /health | Liveness probe
[**getReadiness**](HealthApi.md#getreadiness) | **GET** /health/ready | Readiness probe (checks the database)


# **getHealth**
> HealthResponse getHealth()

Liveness probe

Public.

### Example
```dart
import 'package:hrms_api/api.dart';

final api = HrmsApi().getHealthApi();

try {
    final response = api.getHealth();
    print(response);
} on DioException catch (e) {
    print('Exception when calling HealthApi->getHealth: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**HealthResponse**](HealthResponse.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getReadiness**
> HealthResponse getReadiness()

Readiness probe (checks the database)

Public.

### Example
```dart
import 'package:hrms_api/api.dart';

final api = HrmsApi().getHealthApi();

try {
    final response = api.getReadiness();
    print(response);
} on DioException catch (e) {
    print('Exception when calling HealthApi->getReadiness: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**HealthResponse**](HealthResponse.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

