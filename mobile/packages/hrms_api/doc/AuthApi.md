# hrms_api.api.AuthApi

## Load the API package
```dart
import 'package:hrms_api/api.dart';
```

All URIs are relative to */api/v1*

Method | HTTP request | Description
------------- | ------------- | -------------
[**login**](AuthApi.md#login) | **POST** /auth/login | Sign in with employee ID and password
[**logout**](AuthApi.md#logout) | **POST** /auth/logout | End the session that the refresh token belongs to
[**refreshToken**](AuthApi.md#refreshtoken) | **POST** /auth/refresh | Rotate the refresh token and get a new access token


# **login**
> TokenPair login(loginBody)

Sign in with employee ID and password

Passwords are set by the director. After 5 failures in 15 minutes the account is locked for 15 minutes.  Public.

### Example
```dart
import 'package:hrms_api/api.dart';

final api = HrmsApi().getAuthApi();
final LoginBody loginBody = ; // LoginBody | 

try {
    final response = api.login(loginBody);
    print(response);
} on DioException catch (e) {
    print('Exception when calling AuthApi->login: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **loginBody** | [**LoginBody**](LoginBody.md)|  | 

### Return type

[**TokenPair**](TokenPair.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **logout**
> logout(logoutBody)

End the session that the refresh token belongs to

Public.

### Example
```dart
import 'package:hrms_api/api.dart';

final api = HrmsApi().getAuthApi();
final LogoutBody logoutBody = ; // LogoutBody | 

try {
    api.logout(logoutBody);
} on DioException catch (e) {
    print('Exception when calling AuthApi->logout: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **logoutBody** | [**LogoutBody**](LogoutBody.md)|  | 

### Return type

void (empty response body)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **refreshToken**
> TokenPair refreshToken(refreshBody)

Rotate the refresh token and get a new access token

Public.

### Example
```dart
import 'package:hrms_api/api.dart';

final api = HrmsApi().getAuthApi();
final RefreshBody refreshBody = ; // RefreshBody | 

try {
    final response = api.refreshToken(refreshBody);
    print(response);
} on DioException catch (e) {
    print('Exception when calling AuthApi->refreshToken: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **refreshBody** | [**RefreshBody**](RefreshBody.md)|  | 

### Return type

[**TokenPair**](TokenPair.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

