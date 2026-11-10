// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dashboard_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Home screen data for the selected business unit (scoped by the API).

@ProviderFor(dashboard)
final dashboardProvider = DashboardProvider._();

/// Home screen data for the selected business unit (scoped by the API).

final class DashboardProvider extends $FunctionalProvider<AsyncValue<Dashboard>, Dashboard, FutureOr<Dashboard>>
    with $FutureModifier<Dashboard>, $FutureProvider<Dashboard> {
  /// Home screen data for the selected business unit (scoped by the API).
  DashboardProvider._()
    : super(from: null, argument: null, retry: null, name: r'dashboardProvider', isAutoDispose: true, dependencies: null, $allTransitiveDependencies: null);

  @override
  String debugGetCreateSourceHash() => _$dashboardHash();

  @$internal
  @override
  $FutureProviderElement<Dashboard> $createElement($ProviderPointer pointer) => $FutureProviderElement(pointer);

  @override
  FutureOr<Dashboard> create(Ref ref) {
    return dashboard(ref);
  }
}

String _$dashboardHash() => r'3e76684879d4fdbe3b63aaf6e581ab8387c25226';

@ProviderFor(notifications)
final notificationsProvider = NotificationsProvider._();

final class NotificationsProvider extends $FunctionalProvider<AsyncValue<NotificationPage>, NotificationPage, FutureOr<NotificationPage>>
    with $FutureModifier<NotificationPage>, $FutureProvider<NotificationPage> {
  NotificationsProvider._()
    : super(from: null, argument: null, retry: null, name: r'notificationsProvider', isAutoDispose: true, dependencies: null, $allTransitiveDependencies: null);

  @override
  String debugGetCreateSourceHash() => _$notificationsHash();

  @$internal
  @override
  $FutureProviderElement<NotificationPage> $createElement($ProviderPointer pointer) => $FutureProviderElement(pointer);

  @override
  FutureOr<NotificationPage> create(Ref ref) {
    return notifications(ref);
  }
}

String _$notificationsHash() => r'1ed565e5e66ffbea46d62337326fbf537e96a46d';
