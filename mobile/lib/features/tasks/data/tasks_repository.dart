import 'package:hrms_api/hrms_api.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/api/api_providers.dart';
import '../../../core/api/guard.dart';

part 'tasks_repository.g.dart';

/// Daily tasks (PHASE-2-FEATURES §8).
class TasksRepository {
  TasksRepository(this._api);

  final HrmsApi _api;

  TasksApi get _t => _api.getTasksApi();

  /// [scope]: allotted (OM) | assigned (RM) | all (HR / director); [state]: open | submitted.
  Future<TaskPage> list({required String scope, String? state, String? date, String? businessUnitId, TaskStatus? status, String? cursor}) =>
      guardApi(() async => (await _t.listTasks(scope: scope, state: state, date: date, businessUnitId: businessUnitId, status: status, cursor: cursor)).data!);

  Future<TaskItem> get(String id) => guardApi(() async => (await _t.getTask(id: id)).data!);

  Future<List<TaskItem>> create(TaskCreateBody body) => guardApi(() async => (await _t.createTasks(taskCreateBody: body)).data!.items);

  Future<TaskItem> submit(String id, {required bool completed, String? reason, String? comment}) => guardApi(
    () async => (await _t.submitTask(
      id: id,
      taskSubmitBody: TaskSubmitBody(
        status: completed ? TaskSubmitBodyStatusEnum.COMPLETED : TaskSubmitBodyStatusEnum.NOT_DONE,
        reason: reason,
        comment: comment,
      ),
    )).data!,
  );

  Future<TaskItem> reopen(String id, String comment) => guardApi(
    () async => (await _t.reopenTask(
      id: id,
      taskReopenBody: TaskReopenBody(comment: comment),
    )).data!,
  );
}

@Riverpod(keepAlive: true)
TasksRepository tasksRepository(Ref ref) => TasksRepository(ref.watch(hrmsApiProvider));
