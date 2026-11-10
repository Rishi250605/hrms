# hrms_api.model.PayslipUploadResult

## Load the model package
```dart
import 'package:hrms_api/api.dart';
```

## Properties
Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**period** | **String** |  | 
**matched** | [**List&lt;PayslipUploadMatch&gt;**](PayslipUploadMatch.md) |  | 
**replaced** | [**List&lt;PayslipUploadMatch&gt;**](PayslipUploadMatch.md) | Matched files that replaced an earlier upload (new version) | 
**unmatched** | **List&lt;String&gt;** | File names whose employee code is unknown or outside your business units | 
**invalid** | [**List&lt;PayslipUploadResultInvalidInner&gt;**](PayslipUploadResultInvalidInner.md) |  | 
**duplicates** | **List&lt;String&gt;** | Several files for the same employee in one upload; none of them was stored | 

[[Back to Model list]](../README.md#documentation-for-models) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to README]](../README.md)


