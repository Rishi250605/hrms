// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'performance_screens.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(performanceSummary)
final performanceSummaryProvider = PerformanceSummaryFamily._();

final class PerformanceSummaryProvider
    extends
        $FunctionalProvider<
          AsyncValue<PerformanceSummary>,
          PerformanceSummary,
          FutureOr<PerformanceSummary>
        >
    with
        $FutureModifier<PerformanceSummary>,
        $FutureProvider<PerformanceSummary> {
  PerformanceSummaryProvider._({
    required PerformanceSummaryFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'performanceSummaryProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$performanceSummaryHash();

  @override
  String toString() {
    return r'performanceSummaryProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<PerformanceSummary> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<PerformanceSummary> create(Ref ref) {
    final argument = this.argument as String;
    return performanceSummary(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is PerformanceSummaryProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$performanceSummaryHash() =>
    r'dde2de1ee7a2e06d91d81871a9a18cd6633e0955';

final class PerformanceSummaryFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<PerformanceSummary>, String> {
  PerformanceSummaryFamily._()
    : super(
        retry: null,
        name: r'performanceSummaryProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  PerformanceSummaryProvider call(String employeeId) =>
      PerformanceSummaryProvider._(argument: employeeId, from: this);

  @override
  String toString() => r'performanceSummaryProvider';
}

@ProviderFor(performancePeople)
final performancePeopleProvider = PerformancePeopleProvider._();

final class PerformancePeopleProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<PerformancePersonItem>>,
          List<PerformancePersonItem>,
          FutureOr<List<PerformancePersonItem>>
        >
    with
        $FutureModifier<List<PerformancePersonItem>>,
        $FutureProvider<List<PerformancePersonItem>> {
  PerformancePeopleProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'performancePeopleProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$performancePeopleHash();

  @$internal
  @override
  $FutureProviderElement<List<PerformancePersonItem>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<PerformancePersonItem>> create(Ref ref) {
    return performancePeople(ref);
  }
}

String _$performancePeopleHash() => r'e113de146940b98db587438469fcefed185ea709';

@ProviderFor(performanceMetrics)
final performanceMetricsProvider = PerformanceMetricsProvider._();

final class PerformanceMetricsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<PerformanceMetricItem>>,
          List<PerformanceMetricItem>,
          FutureOr<List<PerformanceMetricItem>>
        >
    with
        $FutureModifier<List<PerformanceMetricItem>>,
        $FutureProvider<List<PerformanceMetricItem>> {
  PerformanceMetricsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'performanceMetricsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$performanceMetricsHash();

  @$internal
  @override
  $FutureProviderElement<List<PerformanceMetricItem>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<PerformanceMetricItem>> create(Ref ref) {
    return performanceMetrics(ref);
  }
}

String _$performanceMetricsHash() =>
    r'5033bb7adbe2f2702294457d15916c2addbf1092';
