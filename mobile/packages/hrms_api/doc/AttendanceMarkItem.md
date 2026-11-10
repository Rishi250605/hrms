# hrms_api.model.AttendanceMarkItem

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
**status** | [**AttendanceStatus**](AttendanceStatus.md) |  | 
**approvalState** | [**ApprovalState**](ApprovalState.md) |  | 
**source_** | [**AttendanceSource**](AttendanceSource.md) |  | 
**note** | **String** |  | 
**markedAt** | [**DateTime**](DateTime.md) |  | 
**markedByName** | **String** |  | 
**approver** | [**PersonRef**](PersonRef.md) |  | 
**decidedAt** | [**DateTime**](DateTime.md) |  | 
**decidedByName** | **String** |  | 
**rejectionReason** | **String** |  | 
**canDecide** | **bool** | True when the caller may approve / reject it | 
**clientMutationId** | **String** |  | 

[[Back to Model list]](../README.md#documentation-for-models) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to README]](../README.md)


