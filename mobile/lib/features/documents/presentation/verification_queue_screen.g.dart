// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'verification_queue_screen.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Pending documents, oldest first (HR works the queue FIFO).

@ProviderFor(verificationQueue)
final verificationQueueProvider = VerificationQueueProvider._();

/// Pending documents, oldest first (HR works the queue FIFO).

final class VerificationQueueProvider
    extends $FunctionalProvider<AsyncValue<List<DocumentWithEmployee>>, List<DocumentWithEmployee>, FutureOr<List<DocumentWithEmployee>>>
    with $FutureModifier<List<DocumentWithEmployee>>, $FutureProvider<List<DocumentWithEmployee>> {
  /// Pending documents, oldest first (HR works the queue FIFO).
  VerificationQueueProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'verificationQueueProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$verificationQueueHash();

  @$internal
  @override
  $FutureProviderElement<List<DocumentWithEmployee>> $createElement($ProviderPointer pointer) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<DocumentWithEmployee>> create(Ref ref) {
    return verificationQueue(ref);
  }
}

String _$verificationQueueHash() => r'08771d32aa294ddbde8dd24ece0d8af18d78e243';
