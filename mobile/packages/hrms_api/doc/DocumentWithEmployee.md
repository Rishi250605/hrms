# hrms_api.model.DocumentWithEmployee

## Load the model package
```dart
import 'package:hrms_api/api.dart';
```

## Properties
Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**id** | **String** |  | 
**employeeId** | **String** |  | 
**type** | [**DocumentType**](DocumentType.md) |  | 
**number** | **String** | Masked for PAN; last 4 digits for Aadhaar | 
**licenceClass** | **String** |  | 
**issueDate** | **String** | Calendar date (IST business date) | 
**expiryDate** | **String** | Calendar date (IST business date) | 
**status** | [**DocumentStatus**](DocumentStatus.md) |  | 
**hasFile** | **bool** |  | 
**verifiedAt** | [**DateTime**](DateTime.md) |  | 
**verifiedByName** | **String** |  | 
**rejectionReason** | **String** |  | 
**createdAt** | [**DateTime**](DateTime.md) |  | 
**daysToExpiry** | **int** | From today (IST); negative when already expired | 
**employee** | [**DocumentEmployee**](DocumentEmployee.md) |  | 

[[Back to Model list]](../README.md#documentation-for-models) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to README]](../README.md)


