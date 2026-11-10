# hrms_api.model.UserItem

## Load the model package
```dart
import 'package:hrms_api/api.dart';
```

## Properties
Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**id** | **String** |  | 
**employeeId** | **String** |  | 
**empCode** | **String** |  | 
**name** | **String** |  | 
**phone** | **String** |  | 
**email** | **String** |  | 
**role** | [**Role**](Role.md) |  | 
**isActive** | **bool** |  | 
**hasPassword** | **bool** |  | 
**lockedUntil** | [**DateTime**](DateTime.md) |  | 
**lastLoginAt** | [**DateTime**](DateTime.md) |  | 
**reportingTo** | [**PersonRef**](PersonRef.md) |  | 
**businessUnits** | [**List&lt;BusinessUnitMembership&gt;**](BusinessUnitMembership.md) |  | 

[[Back to Model list]](../README.md#documentation-for-models) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to README]](../README.md)


