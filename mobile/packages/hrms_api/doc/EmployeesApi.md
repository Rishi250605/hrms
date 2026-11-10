# hrms_api.api.EmployeesApi

## Load the API package
```dart
import 'package:hrms_api/api.dart';
```

All URIs are relative to */api/v1*

Method | HTTP request | Description
------------- | ------------- | -------------
[**changeEmployeeJob**](EmployeesApi.md#changeemployeejob) | **POST** /employees/{id}/job-changes | Transfer / promote: close the open job row and start a new one
[**createEmployee**](EmployeesApi.md#createemployee) | **POST** /employees | Onboard an employee with their first job row
[**createEmployeeDocument**](EmployeesApi.md#createemployeedocument) | **POST** /employees/{id}/documents | Record a captured document (pending HR verification)
[**exitEmployee**](EmployeesApi.md#exitemployee) | **POST** /employees/{id}/exit | Record an exit (last working day)
[**getEmployee**](EmployeesApi.md#getemployee) | **GET** /employees/{id} | Employee profile with job history and document compliance
[**getEmployeeBankDetails**](EmployeesApi.md#getemployeebankdetails) | **GET** /employees/{id}/bank-details | Masked bank details (pay data, audited)
[**getEmployeePhotoUrl**](EmployeesApi.md#getemployeephotourl) | **GET** /employees/{id}/photo-url | Short-lived signed URL of the photo
[**listEmployeeDocuments**](EmployeesApi.md#listemployeedocuments) | **GET** /employees/{id}/documents | An employee&#39;s documents
[**listEmployees**](EmployeesApi.md#listemployees) | **GET** /employees | Employees in my scope
[**promoteEmployee**](EmployeesApi.md#promoteemployee) | **POST** /employees/{id}/promotion | Change the role of a login (promotion) with its new reporting line
[**setEmployeeBankDetails**](EmployeesApi.md#setemployeebankdetails) | **PUT** /employees/{id}/bank-details | Set bank details (stored encrypted)
[**setEmployeeBusinessUnits**](EmployeesApi.md#setemployeebusinessunits) | **PUT** /employees/{id}/business-units | Set business-unit membership (staff: exactly one; managers: one or more with a primary)
[**setEmployeePhoto**](EmployeesApi.md#setemployeephoto) | **PUT** /employees/{id}/photo | Attach an uploaded photo
[**suggestEmpCode**](EmployeesApi.md#suggestempcode) | **GET** /employees/next-code | Next free employee ID for a business unit (e.g. NLS014)
[**updateEmployee**](EmployeesApi.md#updateemployee) | **PATCH** /employees/{id} | Update personal details, or suspend / reinstate


# **changeEmployeeJob**
> EmployeeDetail changeEmployeeJob(id, jobChangeBody)

Transfer / promote: close the open job row and start a new one

Roles: HR, DIRECTOR.

### Example
```dart
import 'package:hrms_api/api.dart';

final api = HrmsApi().getEmployeesApi();
final String id = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 
final JobChangeBody jobChangeBody = ; // JobChangeBody | 

try {
    final response = api.changeEmployeeJob(id, jobChangeBody);
    print(response);
} on DioException catch (e) {
    print('Exception when calling EmployeesApi->changeEmployeeJob: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 
 **jobChangeBody** | [**JobChangeBody**](JobChangeBody.md)|  | 

### Return type

[**EmployeeDetail**](EmployeeDetail.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **createEmployee**
> EmployeeDetail createEmployee(employeeCreateBody)

Onboard an employee with their first job row

Roles: HR, DIRECTOR.

### Example
```dart
import 'package:hrms_api/api.dart';

final api = HrmsApi().getEmployeesApi();
final EmployeeCreateBody employeeCreateBody = ; // EmployeeCreateBody | 

try {
    final response = api.createEmployee(employeeCreateBody);
    print(response);
} on DioException catch (e) {
    print('Exception when calling EmployeesApi->createEmployee: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **employeeCreateBody** | [**EmployeeCreateBody**](EmployeeCreateBody.md)|  | 

### Return type

[**EmployeeDetail**](EmployeeDetail.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **createEmployeeDocument**
> DocumentItem createEmployeeDocument(id, documentCreateBody)

Record a captured document (pending HR verification)

Any authenticated manager.

### Example
```dart
import 'package:hrms_api/api.dart';

final api = HrmsApi().getEmployeesApi();
final String id = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 
final DocumentCreateBody documentCreateBody = ; // DocumentCreateBody | 

try {
    final response = api.createEmployeeDocument(id, documentCreateBody);
    print(response);
} on DioException catch (e) {
    print('Exception when calling EmployeesApi->createEmployeeDocument: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 
 **documentCreateBody** | [**DocumentCreateBody**](DocumentCreateBody.md)|  | 

### Return type

[**DocumentItem**](DocumentItem.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **exitEmployee**
> EmployeeDetail exitEmployee(id, exitBody)

Record an exit (last working day)

Roles: HR, DIRECTOR.

### Example
```dart
import 'package:hrms_api/api.dart';

final api = HrmsApi().getEmployeesApi();
final String id = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 
final ExitBody exitBody = ; // ExitBody | 

try {
    final response = api.exitEmployee(id, exitBody);
    print(response);
} on DioException catch (e) {
    print('Exception when calling EmployeesApi->exitEmployee: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 
 **exitBody** | [**ExitBody**](ExitBody.md)|  | 

### Return type

[**EmployeeDetail**](EmployeeDetail.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getEmployee**
> EmployeeDetail getEmployee(id)

Employee profile with job history and document compliance

Any authenticated manager.

### Example
```dart
import 'package:hrms_api/api.dart';

final api = HrmsApi().getEmployeesApi();
final String id = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 

try {
    final response = api.getEmployee(id);
    print(response);
} on DioException catch (e) {
    print('Exception when calling EmployeesApi->getEmployee: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 

### Return type

[**EmployeeDetail**](EmployeeDetail.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getEmployeeBankDetails**
> BankDetails getEmployeeBankDetails(id)

Masked bank details (pay data, audited)

Roles: HR, DIRECTOR.

### Example
```dart
import 'package:hrms_api/api.dart';

final api = HrmsApi().getEmployeesApi();
final String id = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 

try {
    final response = api.getEmployeeBankDetails(id);
    print(response);
} on DioException catch (e) {
    print('Exception when calling EmployeesApi->getEmployeeBankDetails: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 

### Return type

[**BankDetails**](BankDetails.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getEmployeePhotoUrl**
> SignedUrlResponse getEmployeePhotoUrl(id)

Short-lived signed URL of the photo

Any authenticated manager.

### Example
```dart
import 'package:hrms_api/api.dart';

final api = HrmsApi().getEmployeesApi();
final String id = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 

try {
    final response = api.getEmployeePhotoUrl(id);
    print(response);
} on DioException catch (e) {
    print('Exception when calling EmployeesApi->getEmployeePhotoUrl: $e\n');
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

# **listEmployeeDocuments**
> DocumentList listEmployeeDocuments(id)

An employee's documents

Any authenticated manager.

### Example
```dart
import 'package:hrms_api/api.dart';

final api = HrmsApi().getEmployeesApi();
final String id = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 

try {
    final response = api.listEmployeeDocuments(id);
    print(response);
} on DioException catch (e) {
    print('Exception when calling EmployeesApi->listEmployeeDocuments: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 

### Return type

[**DocumentList**](DocumentList.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **listEmployees**
> EmployeePage listEmployees(cursor, limit, q, businessUnitId, depotId, category, role, staffOnly, reportingToEmployeeId, status, compliance)

Employees in my scope

Business unit + reporting line (§11): RM their reports, OM their RMs and their teams, HR / director everyone in their BUs. EXITED left out unless status=EXITED.  Any authenticated manager.

### Example
```dart
import 'package:hrms_api/api.dart';

final api = HrmsApi().getEmployeesApi();
final String cursor = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | The nextCursor of the previous page
final int limit = 56; // int | 
final String q = q_example; // String | Name, employee ID or phone
final String businessUnitId = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 
final String depotId = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 
final EmployeeCategory category = ; // EmployeeCategory | 
final Role role = ; // Role | 
final bool staffOnly = true; // bool | Only non-login staff (drivers, loadmen, …)
final String reportingToEmployeeId = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | Direct reports of this employee
final EmployeeStatus status = ; // EmployeeStatus | Default: everyone except EXITED
final ComplianceOverall compliance = ; // ComplianceOverall | 

try {
    final response = api.listEmployees(cursor, limit, q, businessUnitId, depotId, category, role, staffOnly, reportingToEmployeeId, status, compliance);
    print(response);
} on DioException catch (e) {
    print('Exception when calling EmployeesApi->listEmployees: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **cursor** | **String**| The nextCursor of the previous page | [optional] 
 **limit** | **int**|  | [optional] [default to 50]
 **q** | **String**| Name, employee ID or phone | [optional] 
 **businessUnitId** | **String**|  | [optional] 
 **depotId** | **String**|  | [optional] 
 **category** | [**EmployeeCategory**](.md)|  | [optional] 
 **role** | [**Role**](.md)|  | [optional] 
 **staffOnly** | **bool**| Only non-login staff (drivers, loadmen, …) | [optional] 
 **reportingToEmployeeId** | **String**| Direct reports of this employee | [optional] 
 **status** | [**EmployeeStatus**](.md)| Default: everyone except EXITED | [optional] 
 **compliance** | [**ComplianceOverall**](.md)|  | [optional] 

### Return type

[**EmployeePage**](EmployeePage.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **promoteEmployee**
> PromotionResult promoteEmployee(id, promotionBody)

Change the role of a login (promotion) with its new reporting line

The only way a role changes (decision Q1). Returns direct reports that must be reassigned.  Roles: HR, DIRECTOR.

### Example
```dart
import 'package:hrms_api/api.dart';

final api = HrmsApi().getEmployeesApi();
final String id = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 
final PromotionBody promotionBody = ; // PromotionBody | 

try {
    final response = api.promoteEmployee(id, promotionBody);
    print(response);
} on DioException catch (e) {
    print('Exception when calling EmployeesApi->promoteEmployee: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 
 **promotionBody** | [**PromotionBody**](PromotionBody.md)|  | 

### Return type

[**PromotionResult**](PromotionResult.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **setEmployeeBankDetails**
> BankDetails setEmployeeBankDetails(id, bankDetailsBody)

Set bank details (stored encrypted)

Roles: HR, DIRECTOR.

### Example
```dart
import 'package:hrms_api/api.dart';

final api = HrmsApi().getEmployeesApi();
final String id = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 
final BankDetailsBody bankDetailsBody = ; // BankDetailsBody | 

try {
    final response = api.setEmployeeBankDetails(id, bankDetailsBody);
    print(response);
} on DioException catch (e) {
    print('Exception when calling EmployeesApi->setEmployeeBankDetails: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 
 **bankDetailsBody** | [**BankDetailsBody**](BankDetailsBody.md)|  | 

### Return type

[**BankDetails**](BankDetails.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **setEmployeeBusinessUnits**
> EmployeeDetail setEmployeeBusinessUnits(id, businessUnitsBody)

Set business-unit membership (staff: exactly one; managers: one or more with a primary)

Roles: HR, DIRECTOR.

### Example
```dart
import 'package:hrms_api/api.dart';

final api = HrmsApi().getEmployeesApi();
final String id = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 
final BusinessUnitsBody businessUnitsBody = ; // BusinessUnitsBody | 

try {
    final response = api.setEmployeeBusinessUnits(id, businessUnitsBody);
    print(response);
} on DioException catch (e) {
    print('Exception when calling EmployeesApi->setEmployeeBusinessUnits: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 
 **businessUnitsBody** | [**BusinessUnitsBody**](BusinessUnitsBody.md)|  | 

### Return type

[**EmployeeDetail**](EmployeeDetail.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **setEmployeePhoto**
> setEmployeePhoto(id, photoBody)

Attach an uploaded photo

Any authenticated manager.

### Example
```dart
import 'package:hrms_api/api.dart';

final api = HrmsApi().getEmployeesApi();
final String id = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 
final PhotoBody photoBody = ; // PhotoBody | 

try {
    api.setEmployeePhoto(id, photoBody);
} on DioException catch (e) {
    print('Exception when calling EmployeesApi->setEmployeePhoto: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 
 **photoBody** | [**PhotoBody**](PhotoBody.md)|  | 

### Return type

void (empty response body)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **suggestEmpCode**
> NextCodeResponse suggestEmpCode(businessUnitId)

Next free employee ID for a business unit (e.g. NLS014)

Roles: HR, DIRECTOR.

### Example
```dart
import 'package:hrms_api/api.dart';

final api = HrmsApi().getEmployeesApi();
final String businessUnitId = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 

try {
    final response = api.suggestEmpCode(businessUnitId);
    print(response);
} on DioException catch (e) {
    print('Exception when calling EmployeesApi->suggestEmpCode: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **businessUnitId** | **String**|  | 

### Return type

[**NextCodeResponse**](NextCodeResponse.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **updateEmployee**
> EmployeeDetail updateEmployee(id, employeeUpdateBody)

Update personal details, or suspend / reinstate

Roles: HR, DIRECTOR.

### Example
```dart
import 'package:hrms_api/api.dart';

final api = HrmsApi().getEmployeesApi();
final String id = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 
final EmployeeUpdateBody employeeUpdateBody = ; // EmployeeUpdateBody | 

try {
    final response = api.updateEmployee(id, employeeUpdateBody);
    print(response);
} on DioException catch (e) {
    print('Exception when calling EmployeesApi->updateEmployee: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 
 **employeeUpdateBody** | [**EmployeeUpdateBody**](EmployeeUpdateBody.md)|  | 

### Return type

[**EmployeeDetail**](EmployeeDetail.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

