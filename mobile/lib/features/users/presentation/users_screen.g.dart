// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'users_screen.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(users)
final usersProvider = UsersFamily._();

final class UsersProvider extends $FunctionalProvider<AsyncValue<UserList>, UserList, FutureOr<UserList>>
    with $FutureModifier<UserList>, $FutureProvider<UserList> {
  UsersProvider._({required UsersFamily super.from, required String super.argument})
    : super(retry: null, name: r'usersProvider', isAutoDispose: true, dependencies: null, $allTransitiveDependencies: null);

  @override
  String debugGetCreateSourceHash() => _$usersHash();

  @override
  String toString() {
    return r'usersProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<UserList> $createElement($ProviderPointer pointer) => $FutureProviderElement(pointer);

  @override
  FutureOr<UserList> create(Ref ref) {
    final argument = this.argument as String;
    return users(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is UsersProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$usersHash() => r'617c71ab55931de749157af9178f14d57b0cbf26';

final class UsersFamily extends $Family with $FunctionalFamilyOverride<FutureOr<UserList>, String> {
  UsersFamily._() : super(retry: null, name: r'usersProvider', dependencies: null, $allTransitiveDependencies: null, isAutoDispose: true);

  UsersProvider call(String q) => UsersProvider._(argument: q, from: this);

  @override
  String toString() => r'usersProvider';
}
