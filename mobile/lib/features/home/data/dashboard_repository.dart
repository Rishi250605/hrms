import 'package:hrms_api/hrms_api.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/api/api_providers.dart';
import '../../../core/api/guard.dart';

part 'dashboard_repository.g.dart';

class DashboardRepository {
  DashboardRepository(this._api);

  final HrmsApi _api;

  Future<Dashboard> dashboard({String? businessUnitId}) =>
      guardApi(() async => (await _api.getReportsApi().getDashboard(businessUnitId: businessUnitId)).data!);

  Future<NotificationPage> notifications({String? cursor, String? businessUnitId}) =>
      guardApi(() async => (await _api.getNotificationsApi().listMyNotifications(cursor: cursor, businessUnitId: businessUnitId)).data!);

  Future<void> markRead(String id) => guardApi(() => _api.getNotificationsApi().markNotificationRead(id: id));

  Future<void> markAllRead() => guardApi(() => _api.getNotificationsApi().markAllNotificationsRead());
}

@Riverpod(keepAlive: true)
DashboardRepository dashboardRepository(Ref ref) => DashboardRepository(ref.watch(hrmsApiProvider));
