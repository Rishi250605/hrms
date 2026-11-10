# hrms_api.api.UsersApi

## Load the API package
```dart
import 'package:hrms_api/api.dart';
```

All URIs are relative to */api/v1*

Method | HTTP request | Description
------------- | ------------- | -------------
[**createUser**](UsersApi.md#createuser) | **POST** /users | Create a login (new employee, or an existing one being promoted) with an initial password
[**getMe**](UsersApi.md#getme) | **GET** /me | My profile: employee ID, role, reporting-to, business units
[**listUsers**](UsersApi.md#listusers) | **GET** /users | Logins in my business units (HR uses it to pick reporting managers)
[**registerDevice**](UsersApi.md#registerdevice) | **POST** /me/devices | Register this device for push notifications (FCM token)
[**resetUserPassword**](UsersApi.md#resetuserpassword) | **POST** /users/{id}/reset-password | Set a user&#39;s password (revokes their sessions and clears any lockout)
[**unlockUser**](UsersApi.md#unlockuser) | **POST** /users/{id}/unlock | Unlock an account locked after failed sign-ins
[**unregisterDevice**](UsersApi.md#unregisterdevice) | **POST** /me/devices/unregister | Stop push notifications to this device (call on logout)
[**updateUser**](UsersApi.md#updateuser) | **PATCH** /users/{id} | Update, deactivate or reactivate a login


# **createUser**
> UserItem createUser(userCreateBody)

Create a login (new employee, or an existing one being promoted) with an initial password

Roles: DIRECTOR.

### Example
```dart
import 'package:hrms_api/api.dart';

final api = HrmsApi().getUsersApi();
final UserCreateBody userCreateBody = ; // UserCreateBody | 

try {
    final response = api.createUser(userCreateBody);
    print(response);
} on DioException catch (e) {
    print('Exception when calling UsersApi->createUser: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **userCreateBody** | [**UserCreateBody**](UserCreateBody.md)|  | 

### Return type

[**UserItem**](UserItem.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getMe**
> MeResponse getMe()

My profile: employee ID, role, reporting-to, business units

Any authenticated manager.

### Example
```dart
import 'package:hrms_api/api.dart';

final api = HrmsApi().getUsersApi();

try {
    final response = api.getMe();
    print(response);
} on DioException catch (e) {
    print('Exception when calling UsersApi->getMe: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**MeResponse**](MeResponse.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **listUsers**
> UserList listUsers(role, businessUnitId, q, includeInactive, cursor, limit)

Logins in my business units (HR uses it to pick reporting managers)

Roles: DIRECTOR, HR, OPERATIONAL_MANAGER.

### Example
```dart
import 'package:hrms_api/api.dart';

final api = HrmsApi().getUsersApi();
final Role role = ; // Role | 
final String businessUnitId = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 
final String q = q_example; // String | 
final bool includeInactive = true; // bool | 
final String cursor = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 
final int limit = 56; // int | 

try {
    final response = api.listUsers(role, businessUnitId, q, includeInactive, cursor, limit);
    print(response);
} on DioException catch (e) {
    print('Exception when calling UsersApi->listUsers: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **role** | [**Role**](.md)|  | [optional] 
 **businessUnitId** | **String**|  | [optional] 
 **q** | **String**|  | [optional] 
 **includeInactive** | **bool**|  | [optional] 
 **cursor** | **String**|  | [optional] 
 **limit** | **int**|  | [optional] [default to 50]

### Return type

[**UserList**](UserList.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **registerDevice**
> registerDevice(deviceRegisterBody)

Register this device for push notifications (FCM token)

Any authenticated manager.

### Example
```dart
import 'package:hrms_api/api.dart';

final api = HrmsApi().getUsersApi();
final DeviceRegisterBody deviceRegisterBody = ; // DeviceRegisterBody | 

try {
    api.registerDevice(deviceRegisterBody);
} on DioException catch (e) {
    print('Exception when calling UsersApi->registerDevice: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **deviceRegisterBody** | [**DeviceRegisterBody**](DeviceRegisterBody.md)|  | 

### Return type

void (empty response body)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **resetUserPassword**
> UserItem resetUserPassword(id, resetPasswordBody)

Set a user's password (revokes their sessions and clears any lockout)

Roles: DIRECTOR.

### Example
```dart
import 'package:hrms_api/api.dart';

final api = HrmsApi().getUsersApi();
final String id = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 
final ResetPasswordBody resetPasswordBody = ; // ResetPasswordBody | 

try {
    final response = api.resetUserPassword(id, resetPasswordBody);
    print(response);
} on DioException catch (e) {
    print('Exception when calling UsersApi->resetUserPassword: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 
 **resetPasswordBody** | [**ResetPasswordBody**](ResetPasswordBody.md)|  | 

### Return type

[**UserItem**](UserItem.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **unlockUser**
> UserItem unlockUser(id)

Unlock an account locked after failed sign-ins

Roles: DIRECTOR.

### Example
```dart
import 'package:hrms_api/api.dart';

final api = HrmsApi().getUsersApi();
final String id = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 

try {
    final response = api.unlockUser(id);
    print(response);
} on DioException catch (e) {
    print('Exception when calling UsersApi->unlockUser: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 

### Return type

[**UserItem**](UserItem.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **unregisterDevice**
> unregisterDevice(deviceUnregisterBody)

Stop push notifications to this device (call on logout)

Any authenticated manager.

### Example
```dart
import 'package:hrms_api/api.dart';

final api = HrmsApi().getUsersApi();
final DeviceUnregisterBody deviceUnregisterBody = ; // DeviceUnregisterBody | 

try {
    api.unregisterDevice(deviceUnregisterBody);
} on DioException catch (e) {
    print('Exception when calling UsersApi->unregisterDevice: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **deviceUnregisterBody** | [**DeviceUnregisterBody**](DeviceUnregisterBody.md)|  | 

### Return type

void (empty response body)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **updateUser**
> UserItem updateUser(id, userUpdateBody)

Update, deactivate or reactivate a login

Roles: DIRECTOR.

### Example
```dart
import 'package:hrms_api/api.dart';

final api = HrmsApi().getUsersApi();
final String id = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 
final UserUpdateBody userUpdateBody = ; // UserUpdateBody | 

try {
    final response = api.updateUser(id, userUpdateBody);
    print(response);
} on DioException catch (e) {
    print('Exception when calling UsersApi->updateUser: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 
 **userUpdateBody** | [**UserUpdateBody**](UserUpdateBody.md)|  | 

### Return type

[**UserItem**](UserItem.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

