# hrms_api.model.LeaveRequestCreateBody

## Load the model package
```dart
import 'package:hrms_api/api.dart';
```

## Properties
Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**subjectEmployeeId** | **String** | Whose leave / OD; omit for yourself. RMs raise for their drivers / loadmen. | [optional] 
**kind** | [**LeaveKind**](LeaveKind.md) |  | 
**leaveTypeId** | **String** | Required for LEAVE | [optional] 
**fromDate** | **String** | Calendar date (IST business date) | 
**toDate** | **String** | Calendar date (IST business date) | 
**fromHalf** | **bool** | Starts at mid-day on fromDate | [optional] 
**toHalf** | **bool** | Ends at mid-day on toDate | [optional] 
**reason** | **String** |  | 
**odLocation** | **String** | Required for OD | [optional] 
**odPurpose** | **String** | Required for OD | [optional] 
**odFromTime** | **String** |  | [optional] 
**odToTime** | **String** |  | [optional] 
**autoApprove** | **bool** | RM raising for their driver / loadman: \"Submit and approve\" | [optional] 

[[Back to Model list]](../README.md#documentation-for-models) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to README]](../README.md)


