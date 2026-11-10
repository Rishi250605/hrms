# hrms_api.model.EmployeeCreateBody

## Load the model package
```dart
import 'package:hrms_api/api.dart';
```

## Properties
Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**empCode** | **String** | BU code + digits, e.g. NLS001 (GET /employees/next-code suggests one) | 
**fullName** | **String** |  | 
**phone** | **String** | E.164, or a 10-digit Indian mobile number | 
**altPhone** | **String** | E.164, or a 10-digit Indian mobile number | [optional] 
**dob** | **String** | Calendar date (IST business date) | [optional] 
**gender** | [**Gender**](Gender.md) |  | [optional] 
**joiningDate** | **String** | Calendar date (IST business date) | 
**category** | [**EmployeeCategory**](EmployeeCategory.md) |  | 
**employmentType** | [**EmploymentType**](EmploymentType.md) |  | 
**contractorName** | **String** |  | [optional] 
**preferredChannel** | [**PreferredChannel**](PreferredChannel.md) |  | [optional] 
**businessUnitId** | **String** | Drivers / loadmen belong to exactly one business unit | 
**uan** | **String** |  | [optional] 
**esicNo** | **String** |  | [optional] 
**pan** | **String** |  | [optional] 
**aadhaarLast4** | **String** |  | [optional] 
**bankAccount** | **String** |  | [optional] 
**ifsc** | **String** |  | [optional] 
**job** | [**JobInput**](JobInput.md) |  | 

[[Back to Model list]](../README.md#documentation-for-models) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to README]](../README.md)


