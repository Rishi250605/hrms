# hrms_api.model.EmployeeDetail

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
**altPhone** | **String** |  | 
**dob** | **String** | Calendar date (IST business date) | 
**gender** | [**Gender**](Gender.md) |  | 
**joiningDate** | **String** | Calendar date (IST business date) | 
**exitDate** | **String** | Calendar date (IST business date) | 
**exitReason** | **String** |  | 
**contractorName** | **String** |  | 
**uan** | **String** |  | 
**esicNo** | **String** |  | 
**aadhaarLast4** | **String** |  | 
**panMasked** | **String** | HR / director only | 
**hasBankDetails** | **bool** | HR / director only; false for other roles | 
**preferredChannel** | [**PreferredChannel**](PreferredChannel.md) |  | 
**hasPhoto** | **bool** |  | 
**hasLogin** | **bool** |  | 
**businessUnits** | [**List&lt;BusinessUnitMembership&gt;**](BusinessUnitMembership.md) |  | 
**currentJob** | [**EmployeeJobItem**](EmployeeJobItem.md) |  | 
**jobs** | [**List&lt;EmployeeJobItem&gt;**](EmployeeJobItem.md) | Full job history, newest first | 
**compliance** | [**Compliance**](Compliance.md) |  | 

[[Back to Model list]](../README.md#documentation-for-models) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to README]](../README.md)


