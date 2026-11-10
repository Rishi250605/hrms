// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'requests_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Leave / OD requests for a tab: mine | team | approvals | all.

@ProviderFor(leaveRequests)
final leaveRequestsProvider = LeaveRequestsFamily._();

/// Leave / OD requests for a tab: mine | team | approvals | all.

final class LeaveRequestsProvider extends $FunctionalProvider<AsyncValue<LeaveRequestPage>, LeaveRequestPage, FutureOr<LeaveRequestPage>>
    with $FutureModifier<LeaveRequestPage>, $FutureProvider<LeaveRequestPage> {
  /// Leave / OD requests for a tab: mine | team | approvals | all.
  LeaveRequestsProvider._({required LeaveRequestsFamily super.from, required String super.argument})
    : super(retry: null, name: r'leaveRequestsProvider', isAutoDispose: true, dependencies: null, $allTransitiveDependencies: null);

  @override
  String debugGetCreateSourceHash() => _$leaveRequestsHash();

  @override
  String toString() {
    return r'leaveRequestsProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<LeaveRequestPage> $createElement($ProviderPointer pointer) => $FutureProviderElement(pointer);

  @override
  FutureOr<LeaveRequestPage> create(Ref ref) {
    final argument = this.argument as String;
    return leaveRequests(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is LeaveRequestsProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$leaveRequestsHash() => r'613579a3dd5ccd4b11e04530ce0ddf1c402c8ff6';

/// Leave / OD requests for a tab: mine | team | approvals | all.

final class LeaveRequestsFamily extends $Family with $FunctionalFamilyOverride<FutureOr<LeaveRequestPage>, String> {
  LeaveRequestsFamily._() : super(retry: null, name: r'leaveRequestsProvider', dependencies: null, $allTransitiveDependencies: null, isAutoDispose: true);

  /// Leave / OD requests for a tab: mine | team | approvals | all.

  LeaveRequestsProvider call(String scope) => LeaveRequestsProvider._(argument: scope, from: this);

  @override
  String toString() => r'leaveRequestsProvider';
}

@ProviderFor(leaveTypes)
final leaveTypesProvider = LeaveTypesProvider._();

final class LeaveTypesProvider extends $FunctionalProvider<AsyncValue<List<LeaveTypeItem>>, List<LeaveTypeItem>, FutureOr<List<LeaveTypeItem>>>
    with $FutureModifier<List<LeaveTypeItem>>, $FutureProvider<List<LeaveTypeItem>> {
  LeaveTypesProvider._()
    : super(from: null, argument: null, retry: null, name: r'leaveTypesProvider', isAutoDispose: false, dependencies: null, $allTransitiveDependencies: null);

  @override
  String debugGetCreateSourceHash() => _$leaveTypesHash();

  @$internal
  @override
  $FutureProviderElement<List<LeaveTypeItem>> $createElement($ProviderPointer pointer) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<LeaveTypeItem>> create(Ref ref) {
    return leaveTypes(ref);
  }
}

String _$leaveTypesHash() => r'b69ef2d5d6655b3d6a9ed532fc484c260bcc6ae1';

@ProviderFor(leaveBalances)
final leaveBalancesProvider = LeaveBalancesFamily._();

final class LeaveBalancesProvider extends $FunctionalProvider<AsyncValue<LeaveBalanceList>, LeaveBalanceList, FutureOr<LeaveBalanceList>>
    with $FutureModifier<LeaveBalanceList>, $FutureProvider<LeaveBalanceList> {
  LeaveBalancesProvider._({required LeaveBalancesFamily super.from, required String super.argument})
    : super(retry: null, name: r'leaveBalancesProvider', isAutoDispose: true, dependencies: null, $allTransitiveDependencies: null);

  @override
  String debugGetCreateSourceHash() => _$leaveBalancesHash();

  @override
  String toString() {
    return r'leaveBalancesProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<LeaveBalanceList> $createElement($ProviderPointer pointer) => $FutureProviderElement(pointer);

  @override
  FutureOr<LeaveBalanceList> create(Ref ref) {
    final argument = this.argument as String;
    return leaveBalances(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is LeaveBalancesProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$leaveBalancesHash() => r'65f0dd954e0cf3d478a914de67caa9402f82b355';

final class LeaveBalancesFamily extends $Family with $FunctionalFamilyOverride<FutureOr<LeaveBalanceList>, String> {
  LeaveBalancesFamily._() : super(retry: null, name: r'leaveBalancesProvider', dependencies: null, $allTransitiveDependencies: null, isAutoDispose: true);

  LeaveBalancesProvider call(String employeeId) => LeaveBalancesProvider._(argument: employeeId, from: this);

  @override
  String toString() => r'leaveBalancesProvider';
}
