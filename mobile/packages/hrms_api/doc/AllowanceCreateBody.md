# hrms_api.model.AllowanceCreateBody

## Load the model package
```dart
import 'package:hrms_api/api.dart';
```

## Properties
Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**beneficiaryEmployeeIds** | **List&lt;String&gt;** | RM: drivers / loadmen reporting to them (one request each, same batch). Omit for yourself. | [optional] 
**allowanceTypeId** | **String** |  | 
**amountPaise** | **int** | Per beneficiary, in paise | 
**fromDate** | **String** | Calendar date (IST business date) | 
**toDate** | **String** | Calendar date (IST business date) | [optional] 
**comment** | **String** |  | [optional] 
**voiceNoteKey** | **String** | From POST /uploads/presign (purpose VOICE_NOTE), max 2 minutes | [optional] 
**receiptKey** | **String** | From POST /uploads/presign (purpose RECEIPT) | [optional] 

[[Back to Model list]](../README.md#documentation-for-models) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to README]](../README.md)


