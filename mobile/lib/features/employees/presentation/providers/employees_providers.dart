import 'package:hrms_api/hrms_api.dart';
import 'package:image_picker/image_picker.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/session.dart';
import '../../data/employees_repository.dart';

part 'employees_providers.g.dart';

@riverpod
class EmployeeFilterController extends _$EmployeeFilterController {
  @override
  EmployeeFilter build() => EmployeeFilter(businessUnitId: ref.watch(selectedBusinessUnitProvider));

  void search(String q) => state = state.copyWith(q: q.trim());
  void compliance(ComplianceOverall? c) => state = c == null ? state.copyWith(clearCompliance: true) : state.copyWith(compliance: c);
}

class EmployeeListState {
  const EmployeeListState({required this.items, required this.nextCursor, this.loadingMore = false});

  final List<EmployeeListItem> items;
  final String? nextCursor;
  final bool loadingMore;

  bool get hasMore => nextCursor != null;
}

/// Cursor-paged employee list for the current filter.
@riverpod
class EmployeeList extends _$EmployeeList {
  @override
  Future<EmployeeListState> build() async {
    final filter = ref.watch(employeeFilterControllerProvider);
    final page = await ref.watch(employeesRepositoryProvider).list(filter);
    return EmployeeListState(items: page.items, nextCursor: page.nextCursor);
  }

  Future<void> loadMore() async {
    final current = state.value;
    if (current == null || !current.hasMore || current.loadingMore) return;
    state = AsyncData(EmployeeListState(items: current.items, nextCursor: current.nextCursor, loadingMore: true));
    try {
      final page = await ref.read(employeesRepositoryProvider).list(ref.read(employeeFilterControllerProvider), cursor: current.nextCursor);
      state = AsyncData(EmployeeListState(items: [...current.items, ...page.items], nextCursor: page.nextCursor));
    } catch (_) {
      state = AsyncData(current);
    }
  }
}

@riverpod
Future<EmployeeDetail> employeeDetail(Ref ref, String id) => ref.watch(employeesRepositoryProvider).get(id);

@riverpod
Future<List<DocumentItem>> employeeDocuments(Ref ref, String id) => ref.watch(employeesRepositoryProvider).documents(id);

@riverpod
Future<List<DepotItem>> onboardingDepots(Ref ref) => ref.watch(employeesRepositoryProvider).depots();

/// Regional managers of a business unit (who a new driver / loadman can report to).
@riverpod
Future<List<UserItem>> businessUnitRms(Ref ref, String businessUnitId) =>
    ref.watch(employeesRepositoryProvider).managersOf(Role.REGIONAL_MANAGER, businessUnitId);

/// Camera / gallery picker, injectable for tests. Returns null when the user cancels.
typedef FilePickerFn = Future<PickedUpload?> Function({required bool camera});

@Riverpod(keepAlive: true)
FilePickerFn filePicker(Ref ref) => ({required bool camera}) async {
  final picker = ImagePicker();
  final x = await picker.pickImage(source: camera ? ImageSource.camera : ImageSource.gallery, maxWidth: 2000, imageQuality: 80);
  if (x == null) return null;
  final bytes = await x.readAsBytes();
  final name = x.name.toLowerCase();
  final type = name.endsWith('.png') ? 'image/png' : (name.endsWith('.webp') ? 'image/webp' : 'image/jpeg');
  return PickedUpload(bytes: bytes, contentType: type);
};
