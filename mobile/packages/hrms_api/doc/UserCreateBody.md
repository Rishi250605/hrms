# hrms_api.model.UserCreateBody

## Load the model package
```dart
import 'package:hrms_api/api.dart';
```

## Properties
Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**existingEmployeeId** | **String** | Give a login to an existing employee (e.g. a driver promoted to RM). Omit to create a new employee. | [optional] 
**empCode** | **String** | Required for a new employee: BU code + digits, e.g. NLS001 | [optional] 
**fullName** | **String** |  | [optional] 
**phone** | **String** | E.164, or a 10-digit Indian mobile number | 
**email** | **String** |  | [optional] 
**role** | [**Role**](Role.md) |  | 
**businessUnitIds** | **List&lt;String&gt;** | Required except for the director | [optional] 
**primaryBusinessUnitId** | **String** |  | [optional] 
**reportingToEmployeeId** | **String** | One role up, sharing a BU (none for the director) | [optional] 
**depotId** | **String** | Base depot for a new employee (must be in one of the BUs) | [optional] 
**designation** | **String** |  | [optional] 
**joiningDate** | **String** | Calendar date (IST business date) | [optional] 
**password** | **String** |  | 

[[Back to Model list]](../README.md#documentation-for-models) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to README]](../README.md)


