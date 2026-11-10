// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'roster_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Business date shown on the roster screen (defaults to tomorrow: managers build the next day's roster).

@ProviderFor(RosterDate)
final rosterDateProvider = RosterDateProvider._();

/// Business date shown on the roster screen (defaults to tomorrow: managers build the next day's roster).
final class RosterDateProvider extends $NotifierProvider<RosterDate, String> {
  /// Business date shown on the roster screen (defaults to tomorrow: managers build the next day's roster).
  RosterDateProvider._()
    : super(from: null, argument: null, retry: null, name: r'rosterDateProvider', isAutoDispose: false, dependencies: null, $allTransitiveDependencies: null);

  @override
  String debugGetCreateSourceHash() => _$rosterDateHash();

  @$internal
  @override
  RosterDate create() => RosterDate();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(String value) {
    return $ProviderOverride(origin: this, providerOverride: $SyncValueProvider<String>(value));
  }
}

String _$rosterDateHash() => r'f97dd2ed44dd4c8c1b9195c5ff13d3f1f5c5045a';

/// Business date shown on the roster screen (defaults to tomorrow: managers build the next day's roster).

abstract class _$RosterDate extends $Notifier<String> {
  String build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<String, String>;
    final element = ref.element as $ClassProviderElement<AnyNotifier<String, String>, String, Object?, Object?>;
    return element.handleCreate(ref, build);
  }
}

@ProviderFor(rosterDay)
final rosterDayProvider = RosterDayFamily._();

final class RosterDayProvider extends $FunctionalProvider<AsyncValue<RosterDay>, RosterDay, FutureOr<RosterDay>>
    with $FutureModifier<RosterDay>, $FutureProvider<RosterDay> {
  RosterDayProvider._({required RosterDayFamily super.from, required (String, String) super.argument})
    : super(retry: null, name: r'rosterDayProvider', isAutoDispose: true, dependencies: null, $allTransitiveDependencies: null);

  @override
  String debugGetCreateSourceHash() => _$rosterDayHash();

  @override
  String toString() {
    return r'rosterDayProvider'
        ''
        '$argument';
  }

  @$internal
  @override
  $FutureProviderElement<RosterDay> $createElement($ProviderPointer pointer) => $FutureProviderElement(pointer);

  @override
  FutureOr<RosterDay> create(Ref ref) {
    final argument = this.argument as (String, String);
    return rosterDay(ref, argument.$1, argument.$2);
  }

  @override
  bool operator ==(Object other) {
    return other is RosterDayProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$rosterDayHash() => r'987d40e60a3856df80f233072af74be6fcd2c82f';

final class RosterDayFamily extends $Family with $FunctionalFamilyOverride<FutureOr<RosterDay>, (String, String)> {
  RosterDayFamily._() : super(retry: null, name: r'rosterDayProvider', dependencies: null, $allTransitiveDependencies: null, isAutoDispose: true);

  RosterDayProvider call(String depotId, String date) => RosterDayProvider._(argument: (depotId, date), from: this);

  @override
  String toString() => r'rosterDayProvider';
}

@ProviderFor(spares)
final sparesProvider = SparesFamily._();

final class SparesProvider extends $FunctionalProvider<AsyncValue<List<SpareItem>>, List<SpareItem>, FutureOr<List<SpareItem>>>
    with $FutureModifier<List<SpareItem>>, $FutureProvider<List<SpareItem>> {
  SparesProvider._({required SparesFamily super.from, required (String, String, String, AssignmentRole) super.argument})
    : super(retry: null, name: r'sparesProvider', isAutoDispose: true, dependencies: null, $allTransitiveDependencies: null);

  @override
  String debugGetCreateSourceHash() => _$sparesHash();

  @override
  String toString() {
    return r'sparesProvider'
        ''
        '$argument';
  }

  @$internal
  @override
  $FutureProviderElement<List<SpareItem>> $createElement($ProviderPointer pointer) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<SpareItem>> create(Ref ref) {
    final argument = this.argument as (String, String, String, AssignmentRole);
    return spares(ref, argument.$1, argument.$2, argument.$3, argument.$4);
  }

  @override
  bool operator ==(Object other) {
    return other is SparesProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$sparesHash() => r'c102c571ecd00a03ccf5d167c828e3a595608386';

final class SparesFamily extends $Family with $FunctionalFamilyOverride<FutureOr<List<SpareItem>>, (String, String, String, AssignmentRole)> {
  SparesFamily._() : super(retry: null, name: r'sparesProvider', dependencies: null, $allTransitiveDependencies: null, isAutoDispose: true);

  SparesProvider call(String depotId, String date, String dutyId, AssignmentRole role) => SparesProvider._(argument: (depotId, date, dutyId, role), from: this);

  @override
  String toString() => r'sparesProvider';
}

@ProviderFor(fleetData)
final fleetDataProvider = FleetDataFamily._();

final class FleetDataProvider extends $FunctionalProvider<AsyncValue<FleetData>, FleetData, FutureOr<FleetData>>
    with $FutureModifier<FleetData>, $FutureProvider<FleetData> {
  FleetDataProvider._({required FleetDataFamily super.from, required String super.argument})
    : super(retry: null, name: r'fleetDataProvider', isAutoDispose: true, dependencies: null, $allTransitiveDependencies: null);

  @override
  String debugGetCreateSourceHash() => _$fleetDataHash();

  @override
  String toString() {
    return r'fleetDataProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<FleetData> $createElement($ProviderPointer pointer) => $FutureProviderElement(pointer);

  @override
  FutureOr<FleetData> create(Ref ref) {
    final argument = this.argument as String;
    return fleetData(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is FleetDataProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$fleetDataHash() => r'5d7c087e02602b64ddcb5a12f1a88e627c18fa42';

final class FleetDataFamily extends $Family with $FunctionalFamilyOverride<FutureOr<FleetData>, String> {
  FleetDataFamily._() : super(retry: null, name: r'fleetDataProvider', dependencies: null, $allTransitiveDependencies: null, isAutoDispose: true);

  FleetDataProvider call(String depotId) => FleetDataProvider._(argument: depotId, from: this);

  @override
  String toString() => r'fleetDataProvider';
}
