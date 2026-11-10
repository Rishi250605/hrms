# hrms_api.model.DashboardBusinessUnitsInnerToday

## Load the model package
```dart
import 'package:hrms_api/api.dart';
```

## Properties
Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**headcount** | **int** |  | 
**present** | **int** |  | 
**absent** | **int** |  | 
**halfDay** | **int** |  | 
**onLeave** | **int** |  | 
**onDuty** | **int** |  | 
**weeklyOff** | **int** |  | 
**notMarked** | **int** |  | 
**pendingApproval** | **int** |  | 
**presentPct** | **num** | (present + onDuty + ½ halfDay) / (headcount − leave − weekly off) × 100 | 

[[Back to Model list]](../README.md#documentation-for-models) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to README]](../README.md)


