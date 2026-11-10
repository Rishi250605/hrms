import 'package:hrms_api/hrms_api.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/session.dart';
import '../../data/dashboard_repository.dart';

part 'dashboard_provider.g.dart';

/// Home screen data for the selected business unit (scoped by the API).
@riverpod
Future<Dashboard> dashboard(Ref ref) => ref.watch(dashboardRepositoryProvider).dashboard(businessUnitId: ref.watch(selectedBusinessUnitProvider));

@riverpod
Future<NotificationPage> notifications(Ref ref) =>
    ref.watch(dashboardRepositoryProvider).notifications(businessUnitId: ref.watch(selectedBusinessUnitProvider));
