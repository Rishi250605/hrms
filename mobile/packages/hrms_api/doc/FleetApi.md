# hrms_api.api.FleetApi

## Load the API package
```dart
import 'package:hrms_api/api.dart';
```

All URIs are relative to */api/v1*

Method | HTTP request | Description
------------- | ------------- | -------------
[**createDutyTemplate**](FleetApi.md#createdutytemplate) | **POST** /duty-templates | Add a duty template
[**createRoute**](FleetApi.md#createroute) | **POST** /routes | Add a route
[**createVehicle**](FleetApi.md#createvehicle) | **POST** /vehicles | Add a vehicle
[**listDutyTemplates**](FleetApi.md#listdutytemplates) | **GET** /duty-templates | Duty templates (shifts) in my scope
[**listRoutes**](FleetApi.md#listroutes) | **GET** /routes | Routes in my scope
[**listVehicles**](FleetApi.md#listvehicles) | **GET** /vehicles | Vehicles in my scope
[**updateDutyTemplate**](FleetApi.md#updatedutytemplate) | **PATCH** /duty-templates/{id} | Update or archive a duty template
[**updateRoute**](FleetApi.md#updateroute) | **PATCH** /routes/{id} | Update or archive a route
[**updateVehicle**](FleetApi.md#updatevehicle) | **PATCH** /vehicles/{id} | Update a vehicle (status, depot, …)


# **createDutyTemplate**
> DutyTemplateItem createDutyTemplate(dutyTemplateCreateBody)

Add a duty template

Any authenticated manager.

### Example
```dart
import 'package:hrms_api/api.dart';

final api = HrmsApi().getFleetApi();
final DutyTemplateCreateBody dutyTemplateCreateBody = ; // DutyTemplateCreateBody | 

try {
    final response = api.createDutyTemplate(dutyTemplateCreateBody);
    print(response);
} on DioException catch (e) {
    print('Exception when calling FleetApi->createDutyTemplate: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **dutyTemplateCreateBody** | [**DutyTemplateCreateBody**](DutyTemplateCreateBody.md)|  | 

### Return type

[**DutyTemplateItem**](DutyTemplateItem.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **createRoute**
> RouteItem createRoute(routeCreateBody)

Add a route

Any authenticated manager.

### Example
```dart
import 'package:hrms_api/api.dart';

final api = HrmsApi().getFleetApi();
final RouteCreateBody routeCreateBody = ; // RouteCreateBody | 

try {
    final response = api.createRoute(routeCreateBody);
    print(response);
} on DioException catch (e) {
    print('Exception when calling FleetApi->createRoute: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **routeCreateBody** | [**RouteCreateBody**](RouteCreateBody.md)|  | 

### Return type

[**RouteItem**](RouteItem.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **createVehicle**
> VehicleItem createVehicle(vehicleCreateBody)

Add a vehicle

Any authenticated manager.

### Example
```dart
import 'package:hrms_api/api.dart';

final api = HrmsApi().getFleetApi();
final VehicleCreateBody vehicleCreateBody = ; // VehicleCreateBody | 

try {
    final response = api.createVehicle(vehicleCreateBody);
    print(response);
} on DioException catch (e) {
    print('Exception when calling FleetApi->createVehicle: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **vehicleCreateBody** | [**VehicleCreateBody**](VehicleCreateBody.md)|  | 

### Return type

[**VehicleItem**](VehicleItem.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **listDutyTemplates**
> DutyTemplateList listDutyTemplates(businessUnitId, depotId, includeInactive)

Duty templates (shifts) in my scope

Any authenticated manager.

### Example
```dart
import 'package:hrms_api/api.dart';

final api = HrmsApi().getFleetApi();
final String businessUnitId = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 
final String depotId = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 
final bool includeInactive = true; // bool | Include retired vehicles / archived routes and templates

try {
    final response = api.listDutyTemplates(businessUnitId, depotId, includeInactive);
    print(response);
} on DioException catch (e) {
    print('Exception when calling FleetApi->listDutyTemplates: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **businessUnitId** | **String**|  | [optional] 
 **depotId** | **String**|  | [optional] 
 **includeInactive** | **bool**| Include retired vehicles / archived routes and templates | [optional] 

### Return type

[**DutyTemplateList**](DutyTemplateList.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **listRoutes**
> RouteList listRoutes(businessUnitId, depotId, includeInactive)

Routes in my scope

Any authenticated manager.

### Example
```dart
import 'package:hrms_api/api.dart';

final api = HrmsApi().getFleetApi();
final String businessUnitId = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 
final String depotId = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 
final bool includeInactive = true; // bool | Include retired vehicles / archived routes and templates

try {
    final response = api.listRoutes(businessUnitId, depotId, includeInactive);
    print(response);
} on DioException catch (e) {
    print('Exception when calling FleetApi->listRoutes: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **businessUnitId** | **String**|  | [optional] 
 **depotId** | **String**|  | [optional] 
 **includeInactive** | **bool**| Include retired vehicles / archived routes and templates | [optional] 

### Return type

[**RouteList**](RouteList.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **listVehicles**
> VehicleList listVehicles(businessUnitId, depotId, includeInactive)

Vehicles in my scope

Any authenticated manager.

### Example
```dart
import 'package:hrms_api/api.dart';

final api = HrmsApi().getFleetApi();
final String businessUnitId = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 
final String depotId = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 
final bool includeInactive = true; // bool | Include retired vehicles / archived routes and templates

try {
    final response = api.listVehicles(businessUnitId, depotId, includeInactive);
    print(response);
} on DioException catch (e) {
    print('Exception when calling FleetApi->listVehicles: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **businessUnitId** | **String**|  | [optional] 
 **depotId** | **String**|  | [optional] 
 **includeInactive** | **bool**| Include retired vehicles / archived routes and templates | [optional] 

### Return type

[**VehicleList**](VehicleList.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **updateDutyTemplate**
> DutyTemplateItem updateDutyTemplate(id, dutyTemplateUpdateBody)

Update or archive a duty template

Any authenticated manager.

### Example
```dart
import 'package:hrms_api/api.dart';

final api = HrmsApi().getFleetApi();
final String id = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 
final DutyTemplateUpdateBody dutyTemplateUpdateBody = ; // DutyTemplateUpdateBody | 

try {
    final response = api.updateDutyTemplate(id, dutyTemplateUpdateBody);
    print(response);
} on DioException catch (e) {
    print('Exception when calling FleetApi->updateDutyTemplate: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 
 **dutyTemplateUpdateBody** | [**DutyTemplateUpdateBody**](DutyTemplateUpdateBody.md)|  | 

### Return type

[**DutyTemplateItem**](DutyTemplateItem.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **updateRoute**
> RouteItem updateRoute(id, routeUpdateBody)

Update or archive a route

Any authenticated manager.

### Example
```dart
import 'package:hrms_api/api.dart';

final api = HrmsApi().getFleetApi();
final String id = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 
final RouteUpdateBody routeUpdateBody = ; // RouteUpdateBody | 

try {
    final response = api.updateRoute(id, routeUpdateBody);
    print(response);
} on DioException catch (e) {
    print('Exception when calling FleetApi->updateRoute: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 
 **routeUpdateBody** | [**RouteUpdateBody**](RouteUpdateBody.md)|  | 

### Return type

[**RouteItem**](RouteItem.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **updateVehicle**
> VehicleItem updateVehicle(id, vehicleUpdateBody)

Update a vehicle (status, depot, …)

Any authenticated manager.

### Example
```dart
import 'package:hrms_api/api.dart';

final api = HrmsApi().getFleetApi();
final String id = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 
final VehicleUpdateBody vehicleUpdateBody = ; // VehicleUpdateBody | 

try {
    final response = api.updateVehicle(id, vehicleUpdateBody);
    print(response);
} on DioException catch (e) {
    print('Exception when calling FleetApi->updateVehicle: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 
 **vehicleUpdateBody** | [**VehicleUpdateBody**](VehicleUpdateBody.md)|  | 

### Return type

[**VehicleItem**](VehicleItem.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

