// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'more_screen.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// "1.2.0 (7)", or null where the platform cannot tell (tests, unsupported platforms).

@ProviderFor(appVersion)
final appVersionProvider = AppVersionProvider._();

/// "1.2.0 (7)", or null where the platform cannot tell (tests, unsupported platforms).

final class AppVersionProvider extends $FunctionalProvider<AsyncValue<String?>, String?, FutureOr<String?>>
    with $FutureModifier<String?>, $FutureProvider<String?> {
  /// "1.2.0 (7)", or null where the platform cannot tell (tests, unsupported platforms).
  AppVersionProvider._()
    : super(from: null, argument: null, retry: null, name: r'appVersionProvider', isAutoDispose: false, dependencies: null, $allTransitiveDependencies: null);

  @override
  String debugGetCreateSourceHash() => _$appVersionHash();

  @$internal
  @override
  $FutureProviderElement<String?> $createElement($ProviderPointer pointer) => $FutureProviderElement(pointer);

  @override
  FutureOr<String?> create(Ref ref) {
    return appVersion(ref);
  }
}

String _$appVersionHash() => r'738c4d321fe8c545dce2b90de57c193ca694597a';
