# hrms_api.api.DocumentsApi

## Load the API package
```dart
import 'package:hrms_api/api.dart';
```

All URIs are relative to */api/v1*

Method | HTTP request | Description
------------- | ------------- | -------------
[**getDocument**](DocumentsApi.md#getdocument) | **GET** /documents/{id} | One document
[**getDocumentFileUrl**](DocumentsApi.md#getdocumentfileurl) | **GET** /documents/{id}/file-url | Short-lived signed URL of the scan (≤ 10 min)
[**listDocumentRequirements**](DocumentsApi.md#listdocumentrequirements) | **GET** /document-requirements | Documents required per employee category to be rostered
[**listDocuments**](DocumentsApi.md#listdocuments) | **GET** /documents | Documents in my scope (HR verification queue: status&#x3D;PENDING_VERIFICATION)
[**listExpiringDocuments**](DocumentsApi.md#listexpiringdocuments) | **GET** /documents/expiring | Documents expiring soon (latest per employee and type)
[**presignUpload**](DocumentsApi.md#presignupload) | **POST** /uploads/presign | Signed URL to upload a document scan or photo directly to storage
[**rejectDocument**](DocumentsApi.md#rejectdocument) | **POST** /documents/{id}/reject | Reject a pending document (notifies whoever captured it)
[**setDocumentRequirements**](DocumentsApi.md#setdocumentrequirements) | **PUT** /document-requirements/{category} | Replace the required documents of a category
[**verifyDocument**](DocumentsApi.md#verifydocument) | **POST** /documents/{id}/verify | Verify a pending document


# **getDocument**
> DocumentWithEmployee getDocument(id)

One document

Any authenticated manager.

### Example
```dart
import 'package:hrms_api/api.dart';

final api = HrmsApi().getDocumentsApi();
final String id = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 

try {
    final response = api.getDocument(id);
    print(response);
} on DioException catch (e) {
    print('Exception when calling DocumentsApi->getDocument: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 

### Return type

[**DocumentWithEmployee**](DocumentWithEmployee.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getDocumentFileUrl**
> SignedUrlResponse getDocumentFileUrl(id)

Short-lived signed URL of the scan (≤ 10 min)

Any authenticated manager.

### Example
```dart
import 'package:hrms_api/api.dart';

final api = HrmsApi().getDocumentsApi();
final String id = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 

try {
    final response = api.getDocumentFileUrl(id);
    print(response);
} on DioException catch (e) {
    print('Exception when calling DocumentsApi->getDocumentFileUrl: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 

### Return type

[**SignedUrlResponse**](SignedUrlResponse.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **listDocumentRequirements**
> DocumentRequirementList listDocumentRequirements()

Documents required per employee category to be rostered

Any authenticated manager.

### Example
```dart
import 'package:hrms_api/api.dart';

final api = HrmsApi().getDocumentsApi();

try {
    final response = api.listDocumentRequirements();
    print(response);
} on DioException catch (e) {
    print('Exception when calling DocumentsApi->listDocumentRequirements: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**DocumentRequirementList**](DocumentRequirementList.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **listDocuments**
> DocumentPage listDocuments(cursor, limit, businessUnitId, status, type, depotId)

Documents in my scope (HR verification queue: status=PENDING_VERIFICATION)

Any authenticated manager.

### Example
```dart
import 'package:hrms_api/api.dart';

final api = HrmsApi().getDocumentsApi();
final String cursor = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | The nextCursor of the previous page
final int limit = 56; // int | 
final String businessUnitId = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 
final DocumentStatus status = ; // DocumentStatus | 
final DocumentType type = ; // DocumentType | 
final String depotId = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 

try {
    final response = api.listDocuments(cursor, limit, businessUnitId, status, type, depotId);
    print(response);
} on DioException catch (e) {
    print('Exception when calling DocumentsApi->listDocuments: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **cursor** | **String**| The nextCursor of the previous page | [optional] 
 **limit** | **int**|  | [optional] [default to 50]
 **businessUnitId** | **String**|  | [optional] 
 **status** | [**DocumentStatus**](.md)|  | [optional] 
 **type** | [**DocumentType**](.md)|  | [optional] 
 **depotId** | **String**|  | [optional] 

### Return type

[**DocumentPage**](DocumentPage.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **listExpiringDocuments**
> ExpiringDocumentList listExpiringDocuments(businessUnitId, withinDays, depotId, includeExpired)

Documents expiring soon (latest per employee and type)

Any authenticated manager.

### Example
```dart
import 'package:hrms_api/api.dart';

final api = HrmsApi().getDocumentsApi();
final String businessUnitId = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 
final int withinDays = 56; // int | 
final String depotId = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 
final bool includeExpired = true; // bool | Also list the latest already-expired, not-yet-renewed documents

try {
    final response = api.listExpiringDocuments(businessUnitId, withinDays, depotId, includeExpired);
    print(response);
} on DioException catch (e) {
    print('Exception when calling DocumentsApi->listExpiringDocuments: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **businessUnitId** | **String**|  | [optional] 
 **withinDays** | **int**|  | [optional] [default to 30]
 **depotId** | **String**|  | [optional] 
 **includeExpired** | **bool**| Also list the latest already-expired, not-yet-renewed documents | [optional] 

### Return type

[**ExpiringDocumentList**](ExpiringDocumentList.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **presignUpload**
> PresignResponse presignUpload(presignBody)

Signed URL to upload a document scan or photo directly to storage

PUT the file to `url` with the returned headers before it expires, then send `key` as fileKey.  Any authenticated manager.

### Example
```dart
import 'package:hrms_api/api.dart';

final api = HrmsApi().getDocumentsApi();
final PresignBody presignBody = ; // PresignBody | 

try {
    final response = api.presignUpload(presignBody);
    print(response);
} on DioException catch (e) {
    print('Exception when calling DocumentsApi->presignUpload: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **presignBody** | [**PresignBody**](PresignBody.md)|  | 

### Return type

[**PresignResponse**](PresignResponse.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **rejectDocument**
> DocumentWithEmployee rejectDocument(id, documentRejectBody)

Reject a pending document (notifies whoever captured it)

Roles: HR, DIRECTOR.

### Example
```dart
import 'package:hrms_api/api.dart';

final api = HrmsApi().getDocumentsApi();
final String id = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 
final DocumentRejectBody documentRejectBody = ; // DocumentRejectBody | 

try {
    final response = api.rejectDocument(id, documentRejectBody);
    print(response);
} on DioException catch (e) {
    print('Exception when calling DocumentsApi->rejectDocument: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 
 **documentRejectBody** | [**DocumentRejectBody**](DocumentRejectBody.md)|  | 

### Return type

[**DocumentWithEmployee**](DocumentWithEmployee.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **setDocumentRequirements**
> DocumentRequirementItem setDocumentRequirements(category, documentRequirementBody)

Replace the required documents of a category

Roles: HR, DIRECTOR.

### Example
```dart
import 'package:hrms_api/api.dart';

final api = HrmsApi().getDocumentsApi();
final EmployeeCategory category = ; // EmployeeCategory | 
final DocumentRequirementBody documentRequirementBody = ; // DocumentRequirementBody | 

try {
    final response = api.setDocumentRequirements(category, documentRequirementBody);
    print(response);
} on DioException catch (e) {
    print('Exception when calling DocumentsApi->setDocumentRequirements: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **category** | [**EmployeeCategory**](.md)|  | 
 **documentRequirementBody** | [**DocumentRequirementBody**](DocumentRequirementBody.md)|  | 

### Return type

[**DocumentRequirementItem**](DocumentRequirementItem.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **verifyDocument**
> DocumentWithEmployee verifyDocument(id, documentVerifyBody)

Verify a pending document

Roles: HR, DIRECTOR.

### Example
```dart
import 'package:hrms_api/api.dart';

final api = HrmsApi().getDocumentsApi();
final String id = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 
final DocumentVerifyBody documentVerifyBody = ; // DocumentVerifyBody | 

try {
    final response = api.verifyDocument(id, documentVerifyBody);
    print(response);
} on DioException catch (e) {
    print('Exception when calling DocumentsApi->verifyDocument: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 
 **documentVerifyBody** | [**DocumentVerifyBody**](DocumentVerifyBody.md)|  | 

### Return type

[**DocumentWithEmployee**](DocumentWithEmployee.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

