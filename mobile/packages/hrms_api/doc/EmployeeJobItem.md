# hrms_api.model.EmployeeJobItem

## Load the model package
```dart
import 'package:hrms_api/api.dart';
```

## Properties
Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**id** | **String** |  | 
**depot** | [**DepotSummary**](DepotSummary.md) |  | 
**designation** | **String** |  | 
**grade** | **String** |  | 
**reportingTo** | [**PersonRef**](PersonRef.md) |  | 
**effectiveFrom** | **String** | Calendar date (IST business date) | 
**effectiveTo** | **String** | Exclusive; null = open | 
**changeReason** | **String** |  | 

[[Back to Model list]](../README.md#documentation-for-models) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to README]](../README.md)


