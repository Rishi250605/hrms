# hrms_api.model.MeResponse

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
**lastLoginAt** | [**DateTime**](DateTime.md) |  | 
**passwordChangedAt** | [**DateTime**](DateTime.md) |  | 
**reportingTo** | [**PersonRef**](PersonRef.md) | Null for the director | 
**businessUnits** | [**List&lt;BusinessUnitMembership&gt;**](BusinessUnitMembership.md) | The director gets every active BU (none primary) | 

[[Back to Model list]](../README.md#documentation-for-models) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to README]](../README.md)


