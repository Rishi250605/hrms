# hrms_api.model.EmployeeListItem

## Load the model package
```dart
import 'package:hrms_api/api.dart';
```

## Properties
Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**id** | **String** |  | 
**empCode** | **String** |  | 
**fullName** | **String** |  | 
**phone** | **String** |  | 
**category** | [**EmployeeCategory**](EmployeeCategory.md) |  | 
**role** | [**Role**](Role.md) | Login role; null for drivers / loadmen and other non-login staff | 
**employmentType** | [**EmploymentType**](EmploymentType.md) |  | 
**status** | [**EmployeeStatus**](EmployeeStatus.md) |  | 
**designation** | **String** |  | 
**depot** | [**DepotSummary**](DepotSummary.md) |  | 
**businessUnit** | [**BusinessUnitRef**](BusinessUnitRef.md) | Primary business unit | 
**reportingTo** | [**PersonRef**](PersonRef.md) |  | 
**compliance** | [**ComplianceOverall**](ComplianceOverall.md) |  | 

[[Back to Model list]](../README.md#documentation-for-models) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to README]](../README.md)


