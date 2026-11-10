# hrms_api.model.TaskItem

## Load the model package
```dart
import 'package:hrms_api/api.dart';
```

## Properties
Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**id** | **String** |  | 
**groupId** | **String** |  | 
**date** | **String** | Calendar date (IST business date) | 
**businessUnit** | [**BusinessUnitRef**](BusinessUnitRef.md) |  | 
**title** | **String** |  | 
**details** | **String** |  | 
**priority** | [**TaskPriority**](TaskPriority.md) |  | 
**allottedBy** | [**PersonRef**](PersonRef.md) |  | 
**assignee** | [**PersonRef**](PersonRef.md) |  | 
**status** | [**TaskStatus**](TaskStatus.md) |  | 
**overdue** | **bool** | Still PENDING after its date (IST) | 
**reason** | **String** |  | 
**comment** | **String** |  | 
**submittedAt** | [**DateTime**](DateTime.md) |  | 
**reopenedAt** | [**DateTime**](DateTime.md) |  | 
**reopenComment** | **String** |  | 
**reopenCount** | **int** |  | 
**canSubmit** | **bool** |  | 
**canReopen** | **bool** |  | 
**createdAt** | [**DateTime**](DateTime.md) |  | 

[[Back to Model list]](../README.md#documentation-for-models) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to README]](../README.md)


