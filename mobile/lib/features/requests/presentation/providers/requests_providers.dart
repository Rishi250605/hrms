import 'package:hrms_api/hrms_api.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/session.dart';
import '../../data/requests_repository.dart';

part 'requests_providers.g.dart';

/// Leave / OD requests for a tab: mine | team | approvals | all.
@riverpod
Future<LeaveRequestPage> leaveRequests(Ref ref, String scope) =>
    ref.watch(requestsRepositoryProvider).list(scope: scope, businessUnitId: ref.watch(selectedBusinessUnitProvider));

@Riverpod(keepAlive: true)
Future<List<LeaveTypeItem>> leaveTypes(Ref ref) => ref.watch(requestsRepositoryProvider).leaveTypes();

@riverpod
Future<LeaveBalanceList> leaveBalances(Ref ref, String employeeId) => ref.watch(requestsRepositoryProvider).balances(employeeId);
