# hrms_api.model.AttendanceReportRowsInner

## Load the model package
```dart
import 'package:hrms_api/api.dart';
```

## Properties
Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**employee** | [**PayslipItemEmployee**](PayslipItemEmployee.md) |  | 
**businessUnitCode** | **String** |  | 
**codes** | **List&lt;String&gt;** | One per day: P, A, HD, L, OD, WO, H; suffix * = pending approval, ! = rejected; empty = no mark | 
**summary** | [**AttendanceReportSummary**](AttendanceReportSummary.md) |  | 

[[Back to Model list]](../README.md#documentation-for-models) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to README]](../README.md)


