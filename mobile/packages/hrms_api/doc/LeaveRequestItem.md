# hrms_api.model.LeaveRequestItem

## Load the model package
```dart
import 'package:hrms_api/api.dart';
```

## Properties
Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**id** | **String** |  | 
**kind** | [**LeaveKind**](LeaveKind.md) |  | 
**employee** | [**PersonRef**](PersonRef.md) |  | 
**businessUnit** | [**BusinessUnitRef**](BusinessUnitRef.md) |  | 
**leaveType** | [**LeaveRequestItemLeaveType**](LeaveRequestItemLeaveType.md) |  | 
**fromDate** | **String** | Calendar date (IST business date) | 
**toDate** | **String** | Calendar date (IST business date) | 
**fromHalf** | **bool** |  | 
**toHalf** | **bool** |  | 
**days** | **num** |  | 
**reason** | **String** |  | 
**odLocation** | **String** |  | 
**odPurpose** | **String** |  | 
**odFromTime** | **String** |  | 
**odToTime** | **String** |  | 
**status** | [**RequestStatus**](RequestStatus.md) |  | 
**raisedByName** | **String** |  | 
**approver** | [**PersonRef**](PersonRef.md) |  | 
**decidedAt** | [**DateTime**](DateTime.md) |  | 
**decidedByName** | **String** |  | 
**rejectionReason** | **String** |  | 
**canDecide** | **bool** |  | 
**canCancel** | **bool** |  | 
**warnings** | **List&lt;String&gt;** | e.g. INSUFFICIENT_BALANCE when the balance setting is WARN | 
**createdAt** | [**DateTime**](DateTime.md) |  | 

[[Back to Model list]](../README.md#documentation-for-models) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to README]](../README.md)


