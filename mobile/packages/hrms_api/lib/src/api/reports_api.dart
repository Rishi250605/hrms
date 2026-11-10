//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

import 'dart:async';

// ignore: unused_import
import 'dart:convert';
import 'package:hrms_api/src/deserialize.dart';
import 'package:dio/dio.dart';

import 'package:hrms_api/src/model/approval_state.dart';
import 'package:hrms_api/src/model/attendance_report.dart';
import 'package:hrms_api/src/model/attendance_status.dart';
import 'package:hrms_api/src/model/dashboard.dart';
import 'package:hrms_api/src/model/error_response.dart';
import 'package:hrms_api/src/model/report_file.dart';
import 'package:hrms_api/src/model/report_group.dart';

class ReportsApi {
  final Dio _dio;

  const ReportsApi(this._dio);

  /// Attendance muster and per-employee summary (scoped by §11)
  /// Any authenticated manager.
  ///
  /// Parameters:
  /// * [businessUnitId]
  /// * [from] - Default: first day of the current month
  /// * [to] - Default: last day of the month of `from`
  /// * [role] - Drivers, loadmen, or managers of one role
  /// * [employeeId]
  /// * [status] - Only days with this status (and people who have one)
  /// * [approvalState] - Only days in this approval state (and people who have one)
  /// * [cancelToken] - A [CancelToken] that can be used to cancel the operation
  /// * [headers] - Can be used to add additional headers to the request
  /// * [extras] - Can be used to add flags to the request
  /// * [validateStatus] - A [ValidateStatus] callback that can be used to determine request success based on the HTTP status of the response
  /// * [onSendProgress] - A [ProgressCallback] that can be used to get the send progress
  /// * [onReceiveProgress] - A [ProgressCallback] that can be used to get the receive progress
  ///
  /// Returns a [Future] containing a [Response] with a [AttendanceReport] as data
  /// Throws [DioException] if API call or serialization fails
  Future<Response<AttendanceReport>> attendanceReport({
    String? businessUnitId,
    String? from,
    String? to,
    ReportGroup? role,
    String? employeeId,
    AttendanceStatus? status,
    ApprovalState? approvalState,
    CancelToken? cancelToken,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? extra,
    ValidateStatus? validateStatus,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    final _path = r'/reports/attendance';
    final _options = Options(
      method: r'GET',
      headers: <String, dynamic>{...?headers},
      extra: <String, dynamic>{
        'secure': <Map<String, String>>[
          {'type': 'http', 'scheme': 'bearer', 'name': 'bearerAuth'},
        ],
        ...?extra,
      },
      validateStatus: validateStatus,
    );

    final _queryParameters = <String, dynamic>{
      if (businessUnitId != null) r'businessUnitId': businessUnitId,
      if (from != null) r'from': from,
      if (to != null) r'to': to,
      if (role != null) r'role': role,
      if (employeeId != null) r'employeeId': employeeId,
      if (status != null) r'status': status,
      if (approvalState != null) r'approvalState': approvalState,
    };

    final _response = await _dio.request<Object>(
      _path,
      options: _options,
      queryParameters: _queryParameters,
      cancelToken: cancelToken,
      onSendProgress: onSendProgress,
      onReceiveProgress: onReceiveProgress,
    );

    AttendanceReport? _responseData;

    try {
      final rawData = _response.data;
      _responseData = rawData == null
          ? null
          : deserialize<AttendanceReport, AttendanceReport>(
              rawData,
              'AttendanceReport',
              growable: true,
            );
    } catch (error, stackTrace) {
      throw DioException(
        requestOptions: _response.requestOptions,
        response: _response,
        type: DioExceptionType.unknown,
        error: error,
        stackTrace: stackTrace,
      );
    }

    return Response<AttendanceReport>(
      data: _responseData,
      headers: _response.headers,
      isRedirect: _response.isRedirect,
      requestOptions: _response.requestOptions,
      redirects: _response.redirects,
      statusCode: _response.statusCode,
      statusMessage: _response.statusMessage,
      extra: _response.extra,
    );
  }

  /// Excel (muster + summary sheets) or PDF (landscape muster) download
  /// Generated server-side and returned as a signed URL (≤ 10 min). Every export is audit-logged.  Any authenticated manager.
  ///
  /// Parameters:
  /// * [format]
  /// * [businessUnitId]
  /// * [from] - Default: first day of the current month
  /// * [to] - Default: last day of the month of `from`
  /// * [role] - Drivers, loadmen, or managers of one role
  /// * [employeeId]
  /// * [status] - Only days with this status (and people who have one)
  /// * [approvalState] - Only days in this approval state (and people who have one)
  /// * [cancelToken] - A [CancelToken] that can be used to cancel the operation
  /// * [headers] - Can be used to add additional headers to the request
  /// * [extras] - Can be used to add flags to the request
  /// * [validateStatus] - A [ValidateStatus] callback that can be used to determine request success based on the HTTP status of the response
  /// * [onSendProgress] - A [ProgressCallback] that can be used to get the send progress
  /// * [onReceiveProgress] - A [ProgressCallback] that can be used to get the receive progress
  ///
  /// Returns a [Future] containing a [Response] with a [ReportFile] as data
  /// Throws [DioException] if API call or serialization fails
  Future<Response<ReportFile>> exportAttendanceReport({
    required String format,
    String? businessUnitId,
    String? from,
    String? to,
    ReportGroup? role,
    String? employeeId,
    AttendanceStatus? status,
    ApprovalState? approvalState,
    CancelToken? cancelToken,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? extra,
    ValidateStatus? validateStatus,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    final _path = r'/reports/attendance/export';
    final _options = Options(
      method: r'GET',
      headers: <String, dynamic>{...?headers},
      extra: <String, dynamic>{
        'secure': <Map<String, String>>[
          {'type': 'http', 'scheme': 'bearer', 'name': 'bearerAuth'},
        ],
        ...?extra,
      },
      validateStatus: validateStatus,
    );

    final _queryParameters = <String, dynamic>{
      if (businessUnitId != null) r'businessUnitId': businessUnitId,
      if (from != null) r'from': from,
      if (to != null) r'to': to,
      if (role != null) r'role': role,
      if (employeeId != null) r'employeeId': employeeId,
      if (status != null) r'status': status,
      if (approvalState != null) r'approvalState': approvalState,
      r'format': format,
    };

    final _response = await _dio.request<Object>(
      _path,
      options: _options,
      queryParameters: _queryParameters,
      cancelToken: cancelToken,
      onSendProgress: onSendProgress,
      onReceiveProgress: onReceiveProgress,
    );

    ReportFile? _responseData;

    try {
      final rawData = _response.data;
      _responseData = rawData == null
          ? null
          : deserialize<ReportFile, ReportFile>(
              rawData,
              'ReportFile',
              growable: true,
            );
    } catch (error, stackTrace) {
      throw DioException(
        requestOptions: _response.requestOptions,
        response: _response,
        type: DioExceptionType.unknown,
        error: error,
        stackTrace: stackTrace,
      );
    }

    return Response<ReportFile>(
      data: _responseData,
      headers: _response.headers,
      isRedirect: _response.isRedirect,
      requestOptions: _response.requestOptions,
      redirects: _response.redirects,
      statusCode: _response.statusCode,
      statusMessage: _response.statusMessage,
      extra: _response.extra,
    );
  }

  /// Home screen cards per business unit and my pending items
  /// Any authenticated manager.
  ///
  /// Parameters:
  /// * [businessUnitId]
  /// * [cancelToken] - A [CancelToken] that can be used to cancel the operation
  /// * [headers] - Can be used to add additional headers to the request
  /// * [extras] - Can be used to add flags to the request
  /// * [validateStatus] - A [ValidateStatus] callback that can be used to determine request success based on the HTTP status of the response
  /// * [onSendProgress] - A [ProgressCallback] that can be used to get the send progress
  /// * [onReceiveProgress] - A [ProgressCallback] that can be used to get the receive progress
  ///
  /// Returns a [Future] containing a [Response] with a [Dashboard] as data
  /// Throws [DioException] if API call or serialization fails
  Future<Response<Dashboard>> getDashboard({
    String? businessUnitId,
    CancelToken? cancelToken,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? extra,
    ValidateStatus? validateStatus,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    final _path = r'/reports/dashboard';
    final _options = Options(
      method: r'GET',
      headers: <String, dynamic>{...?headers},
      extra: <String, dynamic>{
        'secure': <Map<String, String>>[
          {'type': 'http', 'scheme': 'bearer', 'name': 'bearerAuth'},
        ],
        ...?extra,
      },
      validateStatus: validateStatus,
    );

    final _queryParameters = <String, dynamic>{
      if (businessUnitId != null) r'businessUnitId': businessUnitId,
    };

    final _response = await _dio.request<Object>(
      _path,
      options: _options,
      queryParameters: _queryParameters,
      cancelToken: cancelToken,
      onSendProgress: onSendProgress,
      onReceiveProgress: onReceiveProgress,
    );

    Dashboard? _responseData;

    try {
      final rawData = _response.data;
      _responseData = rawData == null
          ? null
          : deserialize<Dashboard, Dashboard>(
              rawData,
              'Dashboard',
              growable: true,
            );
    } catch (error, stackTrace) {
      throw DioException(
        requestOptions: _response.requestOptions,
        response: _response,
        type: DioExceptionType.unknown,
        error: error,
        stackTrace: stackTrace,
      );
    }

    return Response<Dashboard>(
      data: _responseData,
      headers: _response.headers,
      isRedirect: _response.isRedirect,
      requestOptions: _response.requestOptions,
      redirects: _response.redirects,
      statusCode: _response.statusCode,
      statusMessage: _response.statusMessage,
      extra: _response.extra,
    );
  }
}
