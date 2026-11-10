# hrms_api.api.OrgApi

## Load the API package
```dart
import 'package:hrms_api/api.dart';
```

All URIs are relative to */api/v1*

Method | HTTP request | Description
------------- | ------------- | -------------
[**archiveDepot**](OrgApi.md#archivedepot) | **DELETE** /depots/{id} | Archive (soft-delete) a depot
[**createBusinessUnit**](OrgApi.md#createbusinessunit) | **POST** /business-units | Create a business unit
[**createDepot**](OrgApi.md#createdepot) | **POST** /depots | Create a depot (in one business unit)
[**createRegion**](OrgApi.md#createregion) | **POST** /regions | Create a region
[**listBusinessUnits**](OrgApi.md#listbusinessunits) | **GET** /business-units | My business units (the director: all)
[**listDepots**](OrgApi.md#listdepots) | **GET** /depots | Depots of my business units
[**listRegions**](OrgApi.md#listregions) | **GET** /regions | Regions (geographic grouping of depots)
[**updateBusinessUnit**](OrgApi.md#updatebusinessunit) | **PATCH** /business-units/{id} | Rename, recode or deactivate a business unit
[**updateDepot**](OrgApi.md#updatedepot) | **PATCH** /depots/{id} | Update a depot
[**updateRegion**](OrgApi.md#updateregion) | **PATCH** /regions/{id} | Rename a region


# **archiveDepot**
> archiveDepot(id)

Archive (soft-delete) a depot

Roles: DIRECTOR.

### Example
```dart
import 'package:hrms_api/api.dart';

final api = HrmsApi().getOrgApi();
final String id = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 

try {
    api.archiveDepot(id);
} on DioException catch (e) {
    print('Exception when calling OrgApi->archiveDepot: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 

### Return type

void (empty response body)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **createBusinessUnit**
> BusinessUnitItem createBusinessUnit(businessUnitCreateBody)

Create a business unit

Roles: DIRECTOR.

### Example
```dart
import 'package:hrms_api/api.dart';

final api = HrmsApi().getOrgApi();
final BusinessUnitCreateBody businessUnitCreateBody = ; // BusinessUnitCreateBody | 

try {
    final response = api.createBusinessUnit(businessUnitCreateBody);
    print(response);
} on DioException catch (e) {
    print('Exception when calling OrgApi->createBusinessUnit: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **businessUnitCreateBody** | [**BusinessUnitCreateBody**](BusinessUnitCreateBody.md)|  | 

### Return type

[**BusinessUnitItem**](BusinessUnitItem.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **createDepot**
> DepotItem createDepot(depotCreateBody)

Create a depot (in one business unit)

Roles: DIRECTOR.

### Example
```dart
import 'package:hrms_api/api.dart';

final api = HrmsApi().getOrgApi();
final DepotCreateBody depotCreateBody = ; // DepotCreateBody | 

try {
    final response = api.createDepot(depotCreateBody);
    print(response);
} on DioException catch (e) {
    print('Exception when calling OrgApi->createDepot: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **depotCreateBody** | [**DepotCreateBody**](DepotCreateBody.md)|  | 

### Return type

[**DepotItem**](DepotItem.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **createRegion**
> RegionItem createRegion(regionCreateBody)

Create a region

Roles: DIRECTOR.

### Example
```dart
import 'package:hrms_api/api.dart';

final api = HrmsApi().getOrgApi();
final RegionCreateBody regionCreateBody = ; // RegionCreateBody | 

try {
    final response = api.createRegion(regionCreateBody);
    print(response);
} on DioException catch (e) {
    print('Exception when calling OrgApi->createRegion: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **regionCreateBody** | [**RegionCreateBody**](RegionCreateBody.md)|  | 

### Return type

[**RegionItem**](RegionItem.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **listBusinessUnits**
> BusinessUnitList listBusinessUnits()

My business units (the director: all)

Any authenticated manager.

### Example
```dart
import 'package:hrms_api/api.dart';

final api = HrmsApi().getOrgApi();

try {
    final response = api.listBusinessUnits();
    print(response);
} on DioException catch (e) {
    print('Exception when calling OrgApi->listBusinessUnits: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**BusinessUnitList**](BusinessUnitList.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **listDepots**
> DepotList listDepots(businessUnitId, regionId)

Depots of my business units

Any authenticated manager.

### Example
```dart
import 'package:hrms_api/api.dart';

final api = HrmsApi().getOrgApi();
final String businessUnitId = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 
final String regionId = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 

try {
    final response = api.listDepots(businessUnitId, regionId);
    print(response);
} on DioException catch (e) {
    print('Exception when calling OrgApi->listDepots: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **businessUnitId** | **String**|  | [optional] 
 **regionId** | **String**|  | [optional] 

### Return type

[**DepotList**](DepotList.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **listRegions**
> RegionList listRegions()

Regions (geographic grouping of depots)

Any authenticated manager.

### Example
```dart
import 'package:hrms_api/api.dart';

final api = HrmsApi().getOrgApi();

try {
    final response = api.listRegions();
    print(response);
} on DioException catch (e) {
    print('Exception when calling OrgApi->listRegions: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**RegionList**](RegionList.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **updateBusinessUnit**
> BusinessUnitItem updateBusinessUnit(id, businessUnitUpdateBody)

Rename, recode or deactivate a business unit

Changing the code does not renumber existing employee IDs.  Roles: DIRECTOR.

### Example
```dart
import 'package:hrms_api/api.dart';

final api = HrmsApi().getOrgApi();
final String id = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 
final BusinessUnitUpdateBody businessUnitUpdateBody = ; // BusinessUnitUpdateBody | 

try {
    final response = api.updateBusinessUnit(id, businessUnitUpdateBody);
    print(response);
} on DioException catch (e) {
    print('Exception when calling OrgApi->updateBusinessUnit: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 
 **businessUnitUpdateBody** | [**BusinessUnitUpdateBody**](BusinessUnitUpdateBody.md)|  | 

### Return type

[**BusinessUnitItem**](BusinessUnitItem.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **updateDepot**
> DepotItem updateDepot(id, depotUpdateBody)

Update a depot

Roles: DIRECTOR.

### Example
```dart
import 'package:hrms_api/api.dart';

final api = HrmsApi().getOrgApi();
final String id = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 
final DepotUpdateBody depotUpdateBody = ; // DepotUpdateBody | 

try {
    final response = api.updateDepot(id, depotUpdateBody);
    print(response);
} on DioException catch (e) {
    print('Exception when calling OrgApi->updateDepot: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 
 **depotUpdateBody** | [**DepotUpdateBody**](DepotUpdateBody.md)|  | 

### Return type

[**DepotItem**](DepotItem.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **updateRegion**
> RegionItem updateRegion(id, regionUpdateBody)

Rename a region

Roles: DIRECTOR.

### Example
```dart
import 'package:hrms_api/api.dart';

final api = HrmsApi().getOrgApi();
final String id = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 
final RegionUpdateBody regionUpdateBody = ; // RegionUpdateBody | 

try {
    final response = api.updateRegion(id, regionUpdateBody);
    print(response);
} on DioException catch (e) {
    print('Exception when calling OrgApi->updateRegion: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 
 **regionUpdateBody** | [**RegionUpdateBody**](RegionUpdateBody.md)|  | 

### Return type

[**RegionItem**](RegionItem.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

