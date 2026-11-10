// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'employees_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(EmployeeFilterController)
final employeeFilterControllerProvider = EmployeeFilterControllerProvider._();

final class EmployeeFilterControllerProvider extends $NotifierProvider<EmployeeFilterController, EmployeeFilter> {
  EmployeeFilterControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'employeeFilterControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$employeeFilterControllerHash();

  @$internal
  @override
  EmployeeFilterController create() => EmployeeFilterController();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(EmployeeFilter value) {
    return $ProviderOverride(origin: this, providerOverride: $SyncValueProvider<EmployeeFilter>(value));
  }
}

String _$employeeFilterControllerHash() => r'5828a61116776a0af94f32fafb2e83681e23a5b4';

abstract class _$EmployeeFilterController extends $Notifier<EmployeeFilter> {
  EmployeeFilter build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<EmployeeFilter, EmployeeFilter>;
    final element = ref.element as $ClassProviderElement<AnyNotifier<EmployeeFilter, EmployeeFilter>, EmployeeFilter, Object?, Object?>;
    return element.handleCreate(ref, build);
  }
}

/// Cursor-paged employee list for the current filter.

@ProviderFor(EmployeeList)
final employeeListProvider = EmployeeListProvider._();

/// Cursor-paged employee list for the current filter.
final class EmployeeListProvider extends $AsyncNotifierProvider<EmployeeList, EmployeeListState> {
  /// Cursor-paged employee list for the current filter.
  EmployeeListProvider._()
    : super(from: null, argument: null, retry: null, name: r'employeeListProvider', isAutoDispose: true, dependencies: null, $allTransitiveDependencies: null);

  @override
  String debugGetCreateSourceHash() => _$employeeListHash();

  @$internal
  @override
  EmployeeList create() => EmployeeList();
}

String _$employeeListHash() => r'5c7f5737246973ff68adac9d5aba756fc6d083b7';

/// Cursor-paged employee list for the current filter.

abstract class _$EmployeeList extends $AsyncNotifier<EmployeeListState> {
  FutureOr<EmployeeListState> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<AsyncValue<EmployeeListState>, EmployeeListState>;
    final element =
        ref.element as $ClassProviderElement<AnyNotifier<AsyncValue<EmployeeListState>, EmployeeListState>, AsyncValue<EmployeeListState>, Object?, Object?>;
    return element.handleCreate(ref, build);
  }
}

@ProviderFor(employeeDetail)
final employeeDetailProvider = EmployeeDetailFamily._();

final class EmployeeDetailProvider extends $FunctionalProvider<AsyncValue<EmployeeDetail>, EmployeeDetail, FutureOr<EmployeeDetail>>
    with $FutureModifier<EmployeeDetail>, $FutureProvider<EmployeeDetail> {
  EmployeeDetailProvider._({required EmployeeDetailFamily super.from, required String super.argument})
    : super(retry: null, name: r'employeeDetailProvider', isAutoDispose: true, dependencies: null, $allTransitiveDependencies: null);

  @override
  String debugGetCreateSourceHash() => _$employeeDetailHash();

  @override
  String toString() {
    return r'employeeDetailProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<EmployeeDetail> $createElement($ProviderPointer pointer) => $FutureProviderElement(pointer);

  @override
  FutureOr<EmployeeDetail> create(Ref ref) {
    final argument = this.argument as String;
    return employeeDetail(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is EmployeeDetailProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$employeeDetailHash() => r'6a09f6e2c66f885a426e2c6ffcad92b5f62e257d';

final class EmployeeDetailFamily extends $Family with $FunctionalFamilyOverride<FutureOr<EmployeeDetail>, String> {
  EmployeeDetailFamily._() : super(retry: null, name: r'employeeDetailProvider', dependencies: null, $allTransitiveDependencies: null, isAutoDispose: true);

  EmployeeDetailProvider call(String id) => EmployeeDetailProvider._(argument: id, from: this);

  @override
  String toString() => r'employeeDetailProvider';
}

@ProviderFor(employeeDocuments)
final employeeDocumentsProvider = EmployeeDocumentsFamily._();

final class EmployeeDocumentsProvider extends $FunctionalProvider<AsyncValue<List<DocumentItem>>, List<DocumentItem>, FutureOr<List<DocumentItem>>>
    with $FutureModifier<List<DocumentItem>>, $FutureProvider<List<DocumentItem>> {
  EmployeeDocumentsProvider._({required EmployeeDocumentsFamily super.from, required String super.argument})
    : super(retry: null, name: r'employeeDocumentsProvider', isAutoDispose: true, dependencies: null, $allTransitiveDependencies: null);

  @override
  String debugGetCreateSourceHash() => _$employeeDocumentsHash();

  @override
  String toString() {
    return r'employeeDocumentsProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<List<DocumentItem>> $createElement($ProviderPointer pointer) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<DocumentItem>> create(Ref ref) {
    final argument = this.argument as String;
    return employeeDocuments(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is EmployeeDocumentsProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$employeeDocumentsHash() => r'73cf797ed72f00f9e6aa1492cbfa85af02a6632c';

final class EmployeeDocumentsFamily extends $Family with $FunctionalFamilyOverride<FutureOr<List<DocumentItem>>, String> {
  EmployeeDocumentsFamily._()
    : super(retry: null, name: r'employeeDocumentsProvider', dependencies: null, $allTransitiveDependencies: null, isAutoDispose: true);

  EmployeeDocumentsProvider call(String id) => EmployeeDocumentsProvider._(argument: id, from: this);

  @override
  String toString() => r'employeeDocumentsProvider';
}

@ProviderFor(onboardingDepots)
final onboardingDepotsProvider = OnboardingDepotsProvider._();

final class OnboardingDepotsProvider extends $FunctionalProvider<AsyncValue<List<DepotItem>>, List<DepotItem>, FutureOr<List<DepotItem>>>
    with $FutureModifier<List<DepotItem>>, $FutureProvider<List<DepotItem>> {
  OnboardingDepotsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'onboardingDepotsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$onboardingDepotsHash();

  @$internal
  @override
  $FutureProviderElement<List<DepotItem>> $createElement($ProviderPointer pointer) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<DepotItem>> create(Ref ref) {
    return onboardingDepots(ref);
  }
}

String _$onboardingDepotsHash() => r'e86370cd71405cb3aba5f6653bc15c25064674d3';

/// Regional managers of a business unit (who a new driver / loadman can report to).

@ProviderFor(businessUnitRms)
final businessUnitRmsProvider = BusinessUnitRmsFamily._();

/// Regional managers of a business unit (who a new driver / loadman can report to).

final class BusinessUnitRmsProvider extends $FunctionalProvider<AsyncValue<List<UserItem>>, List<UserItem>, FutureOr<List<UserItem>>>
    with $FutureModifier<List<UserItem>>, $FutureProvider<List<UserItem>> {
  /// Regional managers of a business unit (who a new driver / loadman can report to).
  BusinessUnitRmsProvider._({required BusinessUnitRmsFamily super.from, required String super.argument})
    : super(retry: null, name: r'businessUnitRmsProvider', isAutoDispose: true, dependencies: null, $allTransitiveDependencies: null);

  @override
  String debugGetCreateSourceHash() => _$businessUnitRmsHash();

  @override
  String toString() {
    return r'businessUnitRmsProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<List<UserItem>> $createElement($ProviderPointer pointer) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<UserItem>> create(Ref ref) {
    final argument = this.argument as String;
    return businessUnitRms(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is BusinessUnitRmsProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$businessUnitRmsHash() => r'be3e8f3f8cbd1cc62653fea289993a6adbe817c4';

/// Regional managers of a business unit (who a new driver / loadman can report to).

final class BusinessUnitRmsFamily extends $Family with $FunctionalFamilyOverride<FutureOr<List<UserItem>>, String> {
  BusinessUnitRmsFamily._() : super(retry: null, name: r'businessUnitRmsProvider', dependencies: null, $allTransitiveDependencies: null, isAutoDispose: true);

  /// Regional managers of a business unit (who a new driver / loadman can report to).

  BusinessUnitRmsProvider call(String businessUnitId) => BusinessUnitRmsProvider._(argument: businessUnitId, from: this);

  @override
  String toString() => r'businessUnitRmsProvider';
}

@ProviderFor(filePicker)
final filePickerProvider = FilePickerProvider._();

final class FilePickerProvider extends $FunctionalProvider<FilePickerFn, FilePickerFn, FilePickerFn> with $Provider<FilePickerFn> {
  FilePickerProvider._()
    : super(from: null, argument: null, retry: null, name: r'filePickerProvider', isAutoDispose: false, dependencies: null, $allTransitiveDependencies: null);

  @override
  String debugGetCreateSourceHash() => _$filePickerHash();

  @$internal
  @override
  $ProviderElement<FilePickerFn> $createElement($ProviderPointer pointer) => $ProviderElement(pointer);

  @override
  FilePickerFn create(Ref ref) {
    return filePicker(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(FilePickerFn value) {
    return $ProviderOverride(origin: this, providerOverride: $SyncValueProvider<FilePickerFn>(value));
  }
}

String _$filePickerHash() => r'bcc7c1d07f46f63aa7cc65979a2b658446efbddc';
