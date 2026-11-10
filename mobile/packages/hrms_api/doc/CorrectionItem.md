# hrms_api.model.CorrectionItem

## Load the model package
```dart
import 'package:hrms_api/api.dart';
```

## Properties
Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**id** | **String** |  | 
**employee** | [**AttendanceEmployee**](AttendanceEmployee.md) |  | 
**businessUnit** | [**BusinessUnitRef**](BusinessUnitRef.md) |  | 
**date** | **String** | Calendar date (IST business date) | 
**fromStatus** | [**AttendanceStatus**](AttendanceStatus.md) |  | 
**toStatus** | [**AttendanceStatus**](AttendanceStatus.md) |  | 
**reason** | **String** |  | 
**status** | [**RequestStatus**](RequestStatus.md) |  | 
**raisedByName** | **String** |  | 
**approver** | [**PersonRef**](PersonRef.md) |  | 
**decidedAt** | [**DateTime**](DateTime.md) |  | 
**rejectionReason** | **String** |  | 
**canDecide** | **bool** |  | 
**createdAt** | [**DateTime**](DateTime.md) |  | 

[[Back to Model list]](../README.md#documentation-for-models) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to README]](../README.md)


