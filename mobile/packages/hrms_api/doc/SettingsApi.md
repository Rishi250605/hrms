# hrms_api.api.SettingsApi

## Load the API package
```dart
import 'package:hrms_api/api.dart';
```

All URIs are relative to */api/v1*

Method | HTTP request | Description
------------- | ------------- | -------------
[**listSettings**](SettingsApi.md#listsettings) | **GET** /settings | Company settings with their current values and defaults
[**updateSetting**](SettingsApi.md#updatesetting) | **PUT** /settings/{key} | Change a company setting


# **listSettings**
> SettingList listSettings()

Company settings with their current values and defaults

Any authenticated manager.

### Example
```dart
import 'package:hrms_api/api.dart';

final api = HrmsApi().getSettingsApi();

try {
    final response = api.listSettings();
    print(response);
} on DioException catch (e) {
    print('Exception when calling SettingsApi->listSettings: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**SettingList**](SettingList.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **updateSetting**
> SettingItem updateSetting(key, settingUpdateBody)

Change a company setting

The value is validated against the schema registered for the key. Which roles may edit is per key.  Roles: HR, DIRECTOR.

### Example
```dart
import 'package:hrms_api/api.dart';

final api = HrmsApi().getSettingsApi();
final String key = key_example; // String | 
final SettingUpdateBody settingUpdateBody = ; // SettingUpdateBody | 

try {
    final response = api.updateSetting(key, settingUpdateBody);
    print(response);
} on DioException catch (e) {
    print('Exception when calling SettingsApi->updateSetting: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **key** | **String**|  | 
 **settingUpdateBody** | [**SettingUpdateBody**](SettingUpdateBody.md)|  | 

### Return type

[**SettingItem**](SettingItem.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

