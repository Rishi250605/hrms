# hrms_api.model.TaskCreateBody

## Load the model package
```dart
import 'package:hrms_api/api.dart';
```

## Properties
Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**date** | **String** | Default today (IST); future dates allowed | [optional] 
**businessUnitId** | **String** |  | 
**title** | **String** |  | 
**details** | **String** |  | [optional] 
**priority** | [**TaskPriority**](TaskPriority.md) |  | [optional] 
**assigneeEmployeeIds** | **List&lt;String&gt;** | RMs reporting to you in this business unit; one task each | 

[[Back to Model list]](../README.md#documentation-for-models) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to README]](../README.md)


