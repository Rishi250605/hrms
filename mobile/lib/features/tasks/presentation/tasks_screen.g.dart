// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tasks_screen.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(tasks)
final tasksProvider = TasksFamily._();

final class TasksProvider extends $FunctionalProvider<AsyncValue<TaskPage>, TaskPage, FutureOr<TaskPage>>
    with $FutureModifier<TaskPage>, $FutureProvider<TaskPage> {
  TasksProvider._({required TasksFamily super.from, required TaskQuery super.argument})
    : super(retry: null, name: r'tasksProvider', isAutoDispose: true, dependencies: null, $allTransitiveDependencies: null);

  @override
  String debugGetCreateSourceHash() => _$tasksHash();

  @override
  String toString() {
    return r'tasksProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<TaskPage> $createElement($ProviderPointer pointer) => $FutureProviderElement(pointer);

  @override
  FutureOr<TaskPage> create(Ref ref) {
    final argument = this.argument as TaskQuery;
    return tasks(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is TasksProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$tasksHash() => r'46df9f68d1f954a7f2c270f12f1530f5554233de';

final class TasksFamily extends $Family with $FunctionalFamilyOverride<FutureOr<TaskPage>, TaskQuery> {
  TasksFamily._() : super(retry: null, name: r'tasksProvider', dependencies: null, $allTransitiveDependencies: null, isAutoDispose: true);

  TasksProvider call(TaskQuery q) => TasksProvider._(argument: q, from: this);

  @override
  String toString() => r'tasksProvider';
}
