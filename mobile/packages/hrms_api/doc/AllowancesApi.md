# hrms_api.api.AllowancesApi

## Load the API package
```dart
import 'package:hrms_api/api.dart';
```

All URIs are relative to */api/v1*

Method | HTTP request | Description
------------- | ------------- | -------------
[**allowanceMonthlySummary**](AllowancesApi.md#allowancemonthlysummary) | **GET** /allowances/summary | Monthly totals per business unit
[**approveAllowance**](AllowancesApi.md#approveallowance) | **POST** /allowances/{id}/approve | Approve (optionally a different amount, with a comment)
[**approveAllowanceBatch**](AllowancesApi.md#approveallowancebatch) | **POST** /allowances/batch/{batchId}/approve | Approve a whole batch at the requested amounts
[**createAllowance**](AllowancesApi.md#createallowance) | **POST** /allowances | Raise an allowance (RM: self or team, one request per beneficiary; OM: self)
[**createAllowanceType**](AllowancesApi.md#createallowancetype) | **POST** /allowance-types | Add an allowance type
[**getAllowanceFiles**](AllowancesApi.md#getallowancefiles) | **GET** /allowances/{id}/files | Signed URLs of the voice note and receipt (≤ 10 min, audited)
[**listAllowanceTypes**](AllowancesApi.md#listallowancetypes) | **GET** /allowance-types | Allowance types
[**listAllowances**](AllowancesApi.md#listallowances) | **GET** /allowances | Allowance requests: mine, my team, waiting for me, or all (HR / director)
[**rejectAllowance**](AllowancesApi.md#rejectallowance) | **POST** /allowances/{id}/reject | Reject (reason required)
[**updateAllowanceType**](AllowancesApi.md#updateallowancetype) | **PATCH** /allowance-types/{id} | Change, limit or deactivate an allowance type


# **allowanceMonthlySummary**
> AllowanceSummary allowanceMonthlySummary(month, businessUnitId)

Monthly totals per business unit

Roles: HR, DIRECTOR.

### Example
```dart
import 'package:hrms_api/api.dart';

final api = HrmsApi().getAllowancesApi();
final String month = 2026-11; // String | 
final String businessUnitId = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 

try {
    final response = api.allowanceMonthlySummary(month, businessUnitId);
    print(response);
} on DioException catch (e) {
    print('Exception when calling AllowancesApi->allowanceMonthlySummary: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **month** | **String**|  | 
 **businessUnitId** | **String**|  | [optional] 

### Return type

[**AllowanceSummary**](AllowanceSummary.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **approveAllowance**
> AllowanceItem approveAllowance(id, allowanceApproveBody)

Approve (optionally a different amount, with a comment)

Roles: OPERATIONAL_MANAGER, HR, DIRECTOR.

### Example
```dart
import 'package:hrms_api/api.dart';

final api = HrmsApi().getAllowancesApi();
final String id = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 
final AllowanceApproveBody allowanceApproveBody = ; // AllowanceApproveBody | 

try {
    final response = api.approveAllowance(id, allowanceApproveBody);
    print(response);
} on DioException catch (e) {
    print('Exception when calling AllowancesApi->approveAllowance: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 
 **allowanceApproveBody** | [**AllowanceApproveBody**](AllowanceApproveBody.md)|  | 

### Return type

[**AllowanceItem**](AllowanceItem.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **approveAllowanceBatch**
> BatchApproveResult approveAllowanceBatch(batchId)

Approve a whole batch at the requested amounts

Roles: OPERATIONAL_MANAGER, HR, DIRECTOR.

### Example
```dart
import 'package:hrms_api/api.dart';

final api = HrmsApi().getAllowancesApi();
final String batchId = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 

try {
    final response = api.approveAllowanceBatch(batchId);
    print(response);
} on DioException catch (e) {
    print('Exception when calling AllowancesApi->approveAllowanceBatch: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **batchId** | **String**|  | 

### Return type

[**BatchApproveResult**](BatchApproveResult.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **createAllowance**
> AllowanceList createAllowance(allowanceCreateBody)

Raise an allowance (RM: self or team, one request per beneficiary; OM: self)

A comment and/or a voice note is required. Upload the voice note / receipt first with POST /uploads/presign.  Roles: REGIONAL_MANAGER, OPERATIONAL_MANAGER.

### Example
```dart
import 'package:hrms_api/api.dart';

final api = HrmsApi().getAllowancesApi();
final AllowanceCreateBody allowanceCreateBody = ; // AllowanceCreateBody | 

try {
    final response = api.createAllowance(allowanceCreateBody);
    print(response);
} on DioException catch (e) {
    print('Exception when calling AllowancesApi->createAllowance: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **allowanceCreateBody** | [**AllowanceCreateBody**](AllowanceCreateBody.md)|  | 

### Return type

[**AllowanceList**](AllowanceList.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **createAllowanceType**
> AllowanceTypeItem createAllowanceType(allowanceTypeCreateBody)

Add an allowance type

Roles: HR, DIRECTOR.

### Example
```dart
import 'package:hrms_api/api.dart';

final api = HrmsApi().getAllowancesApi();
final AllowanceTypeCreateBody allowanceTypeCreateBody = ; // AllowanceTypeCreateBody | 

try {
    final response = api.createAllowanceType(allowanceTypeCreateBody);
    print(response);
} on DioException catch (e) {
    print('Exception when calling AllowancesApi->createAllowanceType: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **allowanceTypeCreateBody** | [**AllowanceTypeCreateBody**](AllowanceTypeCreateBody.md)|  | 

### Return type

[**AllowanceTypeItem**](AllowanceTypeItem.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getAllowanceFiles**
> AllowanceFiles getAllowanceFiles(id)

Signed URLs of the voice note and receipt (≤ 10 min, audited)

Any authenticated manager.

### Example
```dart
import 'package:hrms_api/api.dart';

final api = HrmsApi().getAllowancesApi();
final String id = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 

try {
    final response = api.getAllowanceFiles(id);
    print(response);
} on DioException catch (e) {
    print('Exception when calling AllowancesApi->getAllowanceFiles: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 

### Return type

[**AllowanceFiles**](AllowanceFiles.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **listAllowanceTypes**
> AllowanceTypeList listAllowanceTypes()

Allowance types

Any authenticated manager.

### Example
```dart
import 'package:hrms_api/api.dart';

final api = HrmsApi().getAllowancesApi();

try {
    final response = api.listAllowanceTypes();
    print(response);
} on DioException catch (e) {
    print('Exception when calling AllowancesApi->listAllowanceTypes: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**AllowanceTypeList**](AllowanceTypeList.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **listAllowances**
> AllowancePage listAllowances(cursor, limit, scope, status, businessUnitId, batchId, from, to)

Allowance requests: mine, my team, waiting for me, or all (HR / director)

Any authenticated manager.

### Example
```dart
import 'package:hrms_api/api.dart';

final api = HrmsApi().getAllowancesApi();
final String cursor = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | The nextCursor of the previous page
final int limit = 56; // int | 
final String scope = scope_example; // String | mine: raised by me or for me; team: my reports; approvals: waiting for me; all: HR / director
final RequestStatus status = ; // RequestStatus | 
final String businessUnitId = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 
final String batchId = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 
final String from = 2026-11-09; // String | Calendar date (IST business date)
final String to = 2026-11-09; // String | Calendar date (IST business date)

try {
    final response = api.listAllowances(cursor, limit, scope, status, businessUnitId, batchId, from, to);
    print(response);
} on DioException catch (e) {
    print('Exception when calling AllowancesApi->listAllowances: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **cursor** | **String**| The nextCursor of the previous page | [optional] 
 **limit** | **int**|  | [optional] [default to 50]
 **scope** | **String**| mine: raised by me or for me; team: my reports; approvals: waiting for me; all: HR / director | [optional] [default to 'mine']
 **status** | [**RequestStatus**](.md)|  | [optional] 
 **businessUnitId** | **String**|  | [optional] 
 **batchId** | **String**|  | [optional] 
 **from** | **String**| Calendar date (IST business date) | [optional] 
 **to** | **String**| Calendar date (IST business date) | [optional] 

### Return type

[**AllowancePage**](AllowancePage.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **rejectAllowance**
> AllowanceItem rejectAllowance(id, rejectReasonBody)

Reject (reason required)

Roles: OPERATIONAL_MANAGER, HR, DIRECTOR.

### Example
```dart
import 'package:hrms_api/api.dart';

final api = HrmsApi().getAllowancesApi();
final String id = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 
final RejectReasonBody rejectReasonBody = ; // RejectReasonBody | 

try {
    final response = api.rejectAllowance(id, rejectReasonBody);
    print(response);
} on DioException catch (e) {
    print('Exception when calling AllowancesApi->rejectAllowance: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 
 **rejectReasonBody** | [**RejectReasonBody**](RejectReasonBody.md)|  | 

### Return type

[**AllowanceItem**](AllowanceItem.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **updateAllowanceType**
> AllowanceTypeItem updateAllowanceType(id, allowanceTypeUpdateBody)

Change, limit or deactivate an allowance type

Roles: HR, DIRECTOR.

### Example
```dart
import 'package:hrms_api/api.dart';

final api = HrmsApi().getAllowancesApi();
final String id = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 
final AllowanceTypeUpdateBody allowanceTypeUpdateBody = ; // AllowanceTypeUpdateBody | 

try {
    final response = api.updateAllowanceType(id, allowanceTypeUpdateBody);
    print(response);
} on DioException catch (e) {
    print('Exception when calling AllowancesApi->updateAllowanceType: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 
 **allowanceTypeUpdateBody** | [**AllowanceTypeUpdateBody**](AllowanceTypeUpdateBody.md)|  | 

### Return type

[**AllowanceTypeItem**](AllowanceTypeItem.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

