# hrms_api.model.DutyItem

## Load the model package
```dart
import 'package:hrms_api/api.dart';
```

## Properties
Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**id** | **String** |  | 
**depotId** | **String** |  | 
**dutyDate** | **String** | Calendar date (IST business date) | 
**status** | [**DutyStatus**](DutyStatus.md) |  | 
**scheduledStart** | [**DateTime**](DateTime.md) |  | 
**scheduledEnd** | [**DateTime**](DateTime.md) |  | 
**startTime** | **String** |  | 
**endTime** | **String** |  | 
**crossesMidnight** | **bool** |  | 
**durationMinutes** | **int** |  | 
**route** | [**LeaveRequestItemLeaveType**](LeaveRequestItemLeaveType.md) |  | 
**vehicle** | [**DutyItemVehicle**](DutyItemVehicle.md) |  | 
**template** | [**DutyItemTemplate**](DutyItemTemplate.md) |  | 
**notes** | **String** |  | 
**filled** | **bool** |  | 
**assignments** | [**List&lt;AssignmentItem&gt;**](AssignmentItem.md) |  | 

[[Back to Model list]](../README.md#documentation-for-models) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to README]](../README.md)


