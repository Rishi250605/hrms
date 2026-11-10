import 'package:hrms_api/hrms_api.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/session.dart';
import '../../data/allowances_repository.dart';

part 'allowances_providers.g.dart';

@riverpod
Future<AllowancePage> allowances(Ref ref, String scope) =>
    ref.watch(allowancesRepositoryProvider).list(scope: scope, businessUnitId: ref.watch(selectedBusinessUnitProvider));

@Riverpod(keepAlive: true)
Future<List<AllowanceTypeItem>> allowanceTypes(Ref ref) => ref.watch(allowancesRepositoryProvider).types();

@riverpod
Future<AllowanceSummary> allowanceSummary(Ref ref, String month) =>
    ref.watch(allowancesRepositoryProvider).summary(month, businessUnitId: ref.watch(selectedBusinessUnitProvider));
