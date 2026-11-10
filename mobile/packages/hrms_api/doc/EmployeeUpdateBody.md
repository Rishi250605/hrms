# hrms_api.model.EmployeeUpdateBody

## Load the model package
```dart
import 'package:hrms_api/api.dart';
```

## Properties
Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**fullName** | **String** |  | [optional] 
**phone** | **String** | E.164, or a 10-digit Indian mobile number | [optional] 
**altPhone** | **String** | E.164, or a 10-digit Indian mobile number | [optional] 
**dob** | **String** | Calendar date (IST business date) | [optional] 
**gender** | [**Gender**](Gender.md) |  | [optional] 
**category** | [**EmployeeCategory**](EmployeeCategory.md) |  | [optional] 
**employmentType** | [**EmploymentType**](EmploymentType.md) |  | [optional] 
**contractorName** | **String** |  | [optional] 
**preferredChannel** | [**PreferredChannel**](PreferredChannel.md) |  | [optional] 
**uan** | **String** |  | [optional] 
**esicNo** | **String** |  | [optional] 
**pan** | **String** |  | [optional] 
**aadhaarLast4** | **String** |  | [optional] 
**status** | **String** | Suspend / reinstate. Exits go through POST /employees/{id}/exit. | [optional] 

[[Back to Model list]](../README.md#documentation-for-models) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to README]](../README.md)


