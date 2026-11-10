# hrms_api.model.SpareItem

## Load the model package
```dart
import 'package:hrms_api/api.dart';
```

## Properties
Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**employee** | [**RosterEmployee**](RosterEmployee.md) |  | 
**designation** | **String** |  | 
**compliance** | [**ComplianceOverall**](ComplianceOverall.md) |  | 
**dutyMinutesLast7Days** | **int** |  | 
**dutiesOnDate** | **int** |  | 
**warnings** | [**List&lt;RosterWarning&gt;**](RosterWarning.md) | Rule warnings if assigned to dutyId (empty when dutyId is not given) | 

[[Back to Model list]](../README.md#documentation-for-models) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to README]](../README.md)


