// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(appConfig)
final appConfigProvider = AppConfigProvider._();

final class AppConfigProvider extends $FunctionalProvider<AppConfig, AppConfig, AppConfig> with $Provider<AppConfig> {
  AppConfigProvider._()
    : super(from: null, argument: null, retry: null, name: r'appConfigProvider', isAutoDispose: false, dependencies: null, $allTransitiveDependencies: null);

  @override
  String debugGetCreateSourceHash() => _$appConfigHash();

  @$internal
  @override
  $ProviderElement<AppConfig> $createElement($ProviderPointer pointer) => $ProviderElement(pointer);

  @override
  AppConfig create(Ref ref) {
    return appConfig(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AppConfig value) {
    return $ProviderOverride(origin: this, providerOverride: $SyncValueProvider<AppConfig>(value));
  }
}

String _$appConfigHash() => r'87f9d20a2d92252672162b2ce97547b7b2479239';

@ProviderFor(tokenStorage)
final tokenStorageProvider = TokenStorageProvider._();

final class TokenStorageProvider extends $FunctionalProvider<TokenStorage, TokenStorage, TokenStorage> with $Provider<TokenStorage> {
  TokenStorageProvider._()
    : super(from: null, argument: null, retry: null, name: r'tokenStorageProvider', isAutoDispose: false, dependencies: null, $allTransitiveDependencies: null);

  @override
  String debugGetCreateSourceHash() => _$tokenStorageHash();

  @$internal
  @override
  $ProviderElement<TokenStorage> $createElement($ProviderPointer pointer) => $ProviderElement(pointer);

  @override
  TokenStorage create(Ref ref) {
    return tokenStorage(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(TokenStorage value) {
    return $ProviderOverride(origin: this, providerOverride: $SyncValueProvider<TokenStorage>(value));
  }
}

String _$tokenStorageHash() => r'dd46faaf319c003e67245b3421a841d3c20ae63a';

/// Emits when the session can no longer be refreshed (refresh token rejected).
/// The session controller listens and sends the user back to login.

@ProviderFor(sessionExpiredEvents)
final sessionExpiredEventsProvider = SessionExpiredEventsProvider._();

/// Emits when the session can no longer be refreshed (refresh token rejected).
/// The session controller listens and sends the user back to login.

final class SessionExpiredEventsProvider extends $FunctionalProvider<StreamController<void>, StreamController<void>, StreamController<void>>
    with $Provider<StreamController<void>> {
  /// Emits when the session can no longer be refreshed (refresh token rejected).
  /// The session controller listens and sends the user back to login.
  SessionExpiredEventsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'sessionExpiredEventsProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$sessionExpiredEventsHash();

  @$internal
  @override
  $ProviderElement<StreamController<void>> $createElement($ProviderPointer pointer) => $ProviderElement(pointer);

  @override
  StreamController<void> create(Ref ref) {
    return sessionExpiredEvents(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(StreamController<void> value) {
    return $ProviderOverride(origin: this, providerOverride: $SyncValueProvider<StreamController<void>>(value));
  }
}

String _$sessionExpiredEventsHash() => r'60d16950ee4b45948e8370ac53a7e0ef35c79f73';

/// Dio without the auth interceptor: used for token refresh and for replaying requests after refresh.

@ProviderFor(bareDio)
final bareDioProvider = BareDioProvider._();

/// Dio without the auth interceptor: used for token refresh and for replaying requests after refresh.

final class BareDioProvider extends $FunctionalProvider<Dio, Dio, Dio> with $Provider<Dio> {
  /// Dio without the auth interceptor: used for token refresh and for replaying requests after refresh.
  BareDioProvider._()
    : super(from: null, argument: null, retry: null, name: r'bareDioProvider', isAutoDispose: false, dependencies: null, $allTransitiveDependencies: null);

  @override
  String debugGetCreateSourceHash() => _$bareDioHash();

  @$internal
  @override
  $ProviderElement<Dio> $createElement($ProviderPointer pointer) => $ProviderElement(pointer);

  @override
  Dio create(Ref ref) {
    return bareDio(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Dio value) {
    return $ProviderOverride(origin: this, providerOverride: $SyncValueProvider<Dio>(value));
  }
}

String _$bareDioHash() => r'f931029612c4878e739ad9c64976abb4bd82289e';

/// The Dio every repository uses (through [hrmsApiProvider]). Adds the bearer token and refreshes it on 401.

@ProviderFor(apiDio)
final apiDioProvider = ApiDioProvider._();

/// The Dio every repository uses (through [hrmsApiProvider]). Adds the bearer token and refreshes it on 401.

final class ApiDioProvider extends $FunctionalProvider<Dio, Dio, Dio> with $Provider<Dio> {
  /// The Dio every repository uses (through [hrmsApiProvider]). Adds the bearer token and refreshes it on 401.
  ApiDioProvider._()
    : super(from: null, argument: null, retry: null, name: r'apiDioProvider', isAutoDispose: false, dependencies: null, $allTransitiveDependencies: null);

  @override
  String debugGetCreateSourceHash() => _$apiDioHash();

  @$internal
  @override
  $ProviderElement<Dio> $createElement($ProviderPointer pointer) => $ProviderElement(pointer);

  @override
  Dio create(Ref ref) {
    return apiDio(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Dio value) {
    return $ProviderOverride(origin: this, providerOverride: $SyncValueProvider<Dio>(value));
  }
}

String _$apiDioHash() => r'bf5d086772bc0e4f831e923a7510ec8d9ff91a8b';

/// Generated OpenAPI client. Screens never use Dio directly: providers → repositories → this client.

@ProviderFor(hrmsApi)
final hrmsApiProvider = HrmsApiProvider._();

/// Generated OpenAPI client. Screens never use Dio directly: providers → repositories → this client.

final class HrmsApiProvider extends $FunctionalProvider<HrmsApi, HrmsApi, HrmsApi> with $Provider<HrmsApi> {
  /// Generated OpenAPI client. Screens never use Dio directly: providers → repositories → this client.
  HrmsApiProvider._()
    : super(from: null, argument: null, retry: null, name: r'hrmsApiProvider', isAutoDispose: false, dependencies: null, $allTransitiveDependencies: null);

  @override
  String debugGetCreateSourceHash() => _$hrmsApiHash();

  @$internal
  @override
  $ProviderElement<HrmsApi> $createElement($ProviderPointer pointer) => $ProviderElement(pointer);

  @override
  HrmsApi create(Ref ref) {
    return hrmsApi(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(HrmsApi value) {
    return $ProviderOverride(origin: this, providerOverride: $SyncValueProvider<HrmsApi>(value));
  }
}

String _$hrmsApiHash() => r'f0340d0ac504c79cd95d49553ca1ff48a9766882';
