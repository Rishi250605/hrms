import 'package:hrms_api/hrms_api.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/api/api_providers.dart';
import '../../../core/api/guard.dart';

part 'performance_repository.g.dart';

/// Performance ratings (1–5 by HR / director) and the director's weekly metric values.
class PerformanceRepository {
  PerformanceRepository(this._api);

  final HrmsApi _api;

  PerformanceApi get _p => _api.getPerformanceApi();

  Future<PerformanceSummary> summary(String employeeId, {int weeks = 12}) =>
      guardApi(() async => (await _p.getPerformance(employeeId: employeeId, weeks: weeks)).data!);

  Future<List<PerformancePersonItem>> people({String? businessUnitId}) =>
      guardApi(() async => (await _p.listPerformancePeople(businessUnitId: businessUnitId)).data!.items);

  Future<PerformanceRatingItem> rate(String employeeId, int rating, String? comment) => guardApi(
    () async => (await _p.ratePerformance(
      employeeId: employeeId,
      performanceRatingCreateBody: PerformanceRatingCreateBody(rating: rating, comment: comment),
    )).data!,
  );

  /// [values]: metricId → value (null removes it).
  Future<PerformanceSummary> putWeek(String employeeId, String weekStart, Map<String, num?> values) => guardApi(
    () async => (await _p.putPerformanceWeek(
      employeeId: employeeId,
      weekStart: weekStart,
      performanceWeekBody: PerformanceWeekBody(values: [for (final e in values.entries) PerformanceWeekBodyValuesInner(metricId: e.key, value: e.value)]),
    )).data!,
  );

  Future<List<PerformanceMetricItem>> metrics() => guardApi(() async => (await _p.listPerformanceMetrics()).data!.items);

  Future<PerformanceMetricItem> createMetric(String code, String name, String? unit) => guardApi(
    () async => (await _p.createPerformanceMetric(
      performanceMetricCreateBody: PerformanceMetricCreateBody(code: code, name: name, unit: unit),
    )).data!,
  );

  Future<PerformanceMetricItem> updateMetric(String id, {String? name, String? unit, bool? isActive}) => guardApi(
    () async => (await _p.updatePerformanceMetric(
      id: id,
      performanceMetricUpdateBody: PerformanceMetricUpdateBody(name: name, unit: unit, isActive: isActive),
    )).data!,
  );
}

@Riverpod(keepAlive: true)
PerformanceRepository performanceRepository(Ref ref) => PerformanceRepository(ref.watch(hrmsApiProvider));
