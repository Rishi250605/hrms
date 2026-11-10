# hrms_api.model.LeaveBalanceItem

## Load the model package
```dart
import 'package:hrms_api/api.dart';
```

## Properties
Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**leaveTypeId** | **String** |  | 
**leaveTypeCode** | **String** |  | 
**leaveTypeName** | **String** |  | 
**year** | **int** |  | 
**tracksBalance** | **bool** |  | 
**annualQuota** | **num** | From the matching policy; null when no policy applies | 
**opening** | **num** |  | 
**accrued** | **num** |  | 
**used** | **num** |  | 
**encashed** | **num** |  | 
**closing** | **num** |  | 
**pending** | **num** | Days in pending requests | 
**available** | **num** | closing - pending | 

[[Back to Model list]](../README.md#documentation-for-models) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to README]](../README.md)


