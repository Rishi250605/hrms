# hrms_api.model.PerformanceSummary

## Load the model package
```dart
import 'package:hrms_api/api.dart';
```

## Properties
Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**person** | [**PersonRef**](PersonRef.md) |  | 
**businessUnit** | [**BusinessUnitRef**](BusinessUnitRef.md) |  | 
**latestRating** | [**PerformanceRatingItem**](PerformanceRatingItem.md) |  | 
**ratings** | [**List&lt;PerformanceRatingItem&gt;**](PerformanceRatingItem.md) | Rating history, newest first (last 50) | 
**weeks** | [**List&lt;PerformanceWeek&gt;**](PerformanceWeek.md) | Weeks with at least one value, newest first | 
**canRate** | **bool** |  | 
**canEnterMetrics** | **bool** |  | 

[[Back to Model list]](../README.md#documentation-for-models) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to README]](../README.md)


