# hrms_api.api.PayslipsApi

## Load the API package
```dart
import 'package:hrms_api/api.dart';
```

All URIs are relative to */api/v1*

Method | HTTP request | Description
------------- | ------------- | -------------
[**downloadPayslip**](PayslipsApi.md#downloadpayslip) | **GET** /payslips/{id}/download | Signed download URL (≤ 10 min, audited)
[**listPayslipVersions**](PayslipsApi.md#listpayslipversions) | **GET** /payslips/{id}/versions | Upload history of a payslip
[**listPayslips**](PayslipsApi.md#listpayslips) | **GET** /payslips | Payslips: mine, my team (§7.2) or all in my business units (HR / director)
[**uploadPayslips**](PayslipsApi.md#uploadpayslips) | **POST** /payslips/upload | Bulk upload payslip PDFs for a pay period (payslip-&lt;empCode&gt;.pdf)


# **downloadPayslip**
> SignedUrlResponse downloadPayslip(id, version)

Signed download URL (≤ 10 min, audited)

Any authenticated manager.

### Example
```dart
import 'package:hrms_api/api.dart';

final api = HrmsApi().getPayslipsApi();
final String id = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 
final int version = 56; // int | Earlier version (HR / director only)

try {
    final response = api.downloadPayslip(id, version);
    print(response);
} on DioException catch (e) {
    print('Exception when calling PayslipsApi->downloadPayslip: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 
 **version** | **int**| Earlier version (HR / director only) | [optional] 

### Return type

[**SignedUrlResponse**](SignedUrlResponse.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **listPayslipVersions**
> PayslipVersionList listPayslipVersions(id)

Upload history of a payslip

Roles: HR, DIRECTOR.

### Example
```dart
import 'package:hrms_api/api.dart';

final api = HrmsApi().getPayslipsApi();
final String id = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 

try {
    final response = api.listPayslipVersions(id);
    print(response);
} on DioException catch (e) {
    print('Exception when calling PayslipsApi->listPayslipVersions: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 

### Return type

[**PayslipVersionList**](PayslipVersionList.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **listPayslips**
> PayslipPage listPayslips(cursor, limit, period, scope, businessUnitId, q)

Payslips: mine, my team (§7.2) or all in my business units (HR / director)

Any authenticated manager.

### Example
```dart
import 'package:hrms_api/api.dart';

final api = HrmsApi().getPayslipsApi();
final String cursor = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | The nextCursor of the previous page
final int limit = 56; // int | 
final String period = 2026-11; // String | 
final String scope = scope_example; // String | mine: my own; team: people I can see (§7.2), not me; all: HR / director
final String businessUnitId = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 
final String q = q_example; // String | Name or employee code contains

try {
    final response = api.listPayslips(cursor, limit, period, scope, businessUnitId, q);
    print(response);
} on DioException catch (e) {
    print('Exception when calling PayslipsApi->listPayslips: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **cursor** | **String**| The nextCursor of the previous page | [optional] 
 **limit** | **int**|  | [optional] [default to 50]
 **period** | **String**|  | [optional] 
 **scope** | **String**| mine: my own; team: people I can see (§7.2), not me; all: HR / director | [optional] [default to 'mine']
 **businessUnitId** | **String**|  | [optional] 
 **q** | **String**| Name or employee code contains | [optional] 

### Return type

[**PayslipPage**](PayslipPage.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **uploadPayslips**
> PayslipUploadResult uploadPayslips(period, files)

Bulk upload payslip PDFs for a pay period (payslip-<empCode>.pdf)

Each file is matched by its employee code; unmatched, invalid and duplicate files are reported and not stored. A re-upload adds a new version.  Roles: HR.

### Example
```dart
import 'package:hrms_api/api.dart';

final api = HrmsApi().getPayslipsApi();
final String period = 2026-11; // String | 
final List<MultipartFile> files = /path/to/file.txt; // List<MultipartFile> | PDF files named payslip-<empCode>.pdf (at most 100 per request)

try {
    final response = api.uploadPayslips(period, files);
    print(response);
} on DioException catch (e) {
    print('Exception when calling PayslipsApi->uploadPayslips: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **period** | **String**|  | 
 **files** | [**List&lt;MultipartFile&gt;**](MultipartFile.md)| PDF files named payslip-<empCode>.pdf (at most 100 per request) | 

### Return type

[**PayslipUploadResult**](PayslipUploadResult.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: multipart/form-data
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

