# hrms_api.model.DocumentCreateBody

## Load the model package
```dart
import 'package:hrms_api/api.dart';
```

## Properties
Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**type** | [**DocumentType**](DocumentType.md) |  | 
**number** | **String** | For AADHAAR send the last 4 digits (a 12-digit number is truncated to its last 4). For PAN the full PAN (stored encrypted). | 
**licenceClass** | **String** |  | [optional] 
**issueDate** | **String** | Calendar date (IST business date) | [optional] 
**expiryDate** | **String** | Calendar date (IST business date) | [optional] 
**fileKey** | **String** | Key returned by POST /uploads/presign after the file was uploaded | 

[[Back to Model list]](../README.md#documentation-for-models) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to README]](../README.md)


