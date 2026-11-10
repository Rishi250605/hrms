# hrms_api.model.AllowanceItem

## Load the model package
```dart
import 'package:hrms_api/api.dart';
```

## Properties
Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**id** | **String** |  | 
**batchId** | **String** |  | 
**beneficiary** | [**PersonRef**](PersonRef.md) |  | 
**raisedBy** | [**PersonRef**](PersonRef.md) |  | 
**businessUnit** | [**BusinessUnitRef**](BusinessUnitRef.md) |  | 
**allowanceType** | [**AllowanceItemAllowanceType**](AllowanceItemAllowanceType.md) |  | 
**requestedAmountPaise** | **int** |  | 
**approvedAmountPaise** | **int** |  | 
**fromDate** | **String** | Calendar date (IST business date) | 
**toDate** | **String** | Calendar date (IST business date) | 
**comment** | **String** |  | 
**hasVoiceNote** | **bool** |  | 
**hasReceipt** | **bool** |  | 
**status** | [**RequestStatus**](RequestStatus.md) |  | 
**approver** | [**PersonRef**](PersonRef.md) |  | 
**decidedAt** | [**DateTime**](DateTime.md) |  | 
**decidedByName** | **String** |  | 
**decisionComment** | **String** |  | 
**rejectionReason** | **String** |  | 
**canDecide** | **bool** |  | 
**createdAt** | [**DateTime**](DateTime.md) |  | 

[[Back to Model list]](../README.md#documentation-for-models) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to README]](../README.md)


