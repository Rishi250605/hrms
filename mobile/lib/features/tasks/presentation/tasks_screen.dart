import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:hrms_api/hrms_api.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../app/l10n/app_localizations.dart';
import '../../../app/router.dart';
import '../../../core/format.dart';
import '../../../core/labels.dart';
import '../../../core/session.dart';
import '../../../core/widgets/async_view.dart';
import '../../../core/widgets/bu_switcher.dart';
import '../../../core/widgets/depot_selector.dart' show DateStepper;
import '../../../core/widgets/status_chip.dart';
import '../../home/presentation/providers/dashboard_provider.dart';
import '../data/tasks_repository.dart';

part 'tasks_screen.g.dart';

/// Query of one task list: scope (allotted | assigned | all), state (open | submitted) and an optional date.
typedef TaskQuery = ({String scope, String? state, String? date});

@riverpod
Future<TaskPage> tasks(Ref ref, TaskQuery q) =>
    ref.watch(tasksRepositoryProvider).list(scope: q.scope, state: q.state, date: q.date, businessUnitId: ref.watch(selectedBusinessUnitProvider));

/// Tasks (§8.2): RM "Allotted" / "Completed" tabs; OM allots and follows by date; HR / director read all by date.
class TasksScreen extends ConsumerStatefulWidget {
  const TasksScreen({super.key, this.openTaskId});

  final String? openTaskId;

  @override
  ConsumerState<TasksScreen> createState() => _TasksScreenState();
}

class _TasksScreenState extends ConsumerState<TasksScreen> {
  String _date = todayIso();

  @override
  void initState() {
    super.initState();
    final id = widget.openTaskId;
    if (id != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        try {
          final task = await ref.read(tasksRepositoryProvider).get(id);
          if (mounted) await showTaskSheet(context, task);
        } catch (_) {}
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final user = ref.watch(currentUserProvider);
    if (user == null) return const SizedBox.shrink();
    if (user.isRm) {
      return DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            title: Text(l10n.navTasks),
            actions: const [BusinessUnitSwitcher()],
            bottom: TabBar(
              tabs: [
                Tab(key: const Key('tasks.tab.open'), text: l10n.tabAllotted),
                Tab(key: const Key('tasks.tab.submitted'), text: l10n.tabCompleted),
              ],
            ),
          ),
          body: const TabBarView(
            children: [
              _TaskList(query: (scope: 'assigned', state: 'open', date: null)),
              _TaskList(query: (scope: 'assigned', state: 'submitted', date: null)),
            ],
          ),
        ),
      );
    }
    final scope = user.isOm ? 'allotted' : 'all';
    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.navTasks),
        actions: const [BusinessUnitSwitcher()],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(48),
          child: DateStepper(date: parseIsoDate(_date), label: formatDate(_date), onChanged: (d) => setState(() => _date = isoDate(d))),
        ),
      ),
      floatingActionButton: user.isOm
          ? FloatingActionButton.extended(
              key: const Key('tasks.new'),
              onPressed: () => context.push(Routes.newTask),
              icon: const Icon(Icons.add_task),
              label: Text(l10n.allotTask),
            )
          : null,
      body: _TaskList(query: (scope: scope, state: null, date: _date), showAssignee: true),
    );
  }
}

class _TaskList extends ConsumerWidget {
  const _TaskList({required this.query, this.showAssignee = false});

  final TaskQuery query;
  final bool showAssignee;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final page = ref.watch(tasksProvider(query));
    return RefreshIndicator(
      onRefresh: () => ref.refreshFuture(tasksProvider(query).future),
      child: AsyncView(
        value: page,
        onRetry: () => ref.invalidate(tasksProvider(query)),
        data: (p) => p.items.isEmpty
            ? ListView(
                children: [EmptyState(icon: Icons.task_alt, message: l10n.noTasks)],
              )
            : ListView.separated(
                padding: const EdgeInsets.only(bottom: 88),
                itemCount: p.items.length,
                separatorBuilder: (_, _) => const Divider(height: 1),
                itemBuilder: (context, i) {
                  final t = p.items[i];
                  return ListTile(
                    key: Key('task.${t.id}'),
                    leading: Icon(
                      t.priority == TaskPriority.HIGH ? Icons.priority_high : Icons.task_alt,
                      color: t.priority == TaskPriority.HIGH ? Theme.of(context).colorScheme.error : null,
                    ),
                    title: Text(t.title),
                    subtitle: Text(
                      [
                        formatDate(t.date),
                        if (showAssignee) t.assignee.name else t.allottedBy.name,
                        t.businessUnit.code,
                        if (t.reason != null) t.reason!,
                      ].join(' · '),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    trailing: StatusChip(
                      label: l10n.taskStatus(t.status, overdue: t.overdue),
                      tone: taskTone(t.status, overdue: t.overdue),
                    ),
                    tileColor: t.overdue ? Theme.of(context).colorScheme.errorContainer.withValues(alpha: 0.25) : null,
                    onTap: () => showTaskSheet(context, t),
                  );
                },
              ),
      ),
    );
  }
}

Future<void> showTaskSheet(BuildContext context, TaskItem task) => showModalBottomSheet<void>(
  context: context,
  isScrollControlled: true,
  builder: (_) => TaskSheet(task: task),
);

/// Task detail: the RM submits Completed / Not done (reason required); the OM reopens a submitted task.
class TaskSheet extends ConsumerStatefulWidget {
  const TaskSheet({super.key, required this.task});

  final TaskItem task;

  @override
  ConsumerState<TaskSheet> createState() => _TaskSheetState();
}

class _TaskSheetState extends ConsumerState<TaskSheet> {
  bool _completed = true;
  final _reason = TextEditingController();
  final _comment = TextEditingController();
  bool _busy = false;
  String? _error;

  @override
  void dispose() {
    _reason.dispose();
    _comment.dispose();
    super.dispose();
  }

  Future<void> _run(Future<Object?> Function() action, String done) async {
    setState(() => _busy = true);
    try {
      await action();
      ref.invalidate(tasksProvider);
      ref.invalidate(dashboardProvider);
      if (mounted) {
        Navigator.pop(context);
        showMessage(context, done);
      }
    } catch (e) {
      if (mounted) {
        setState(() => _busy = false);
        showFailure(context, e);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final t = widget.task;
    final repo = ref.read(tasksRepositoryProvider);
    String? text(TextEditingController c) => c.text.trim().isEmpty ? null : c.text.trim();
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.fromLTRB(16, 16, 16, 16 + MediaQuery.viewInsetsOf(context).bottom),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(child: Text(t.title, style: theme.textTheme.titleMedium)),
                  StatusChip(
                    label: l10n.taskStatus(t.status, overdue: t.overdue),
                    tone: taskTone(t.status, overdue: t.overdue),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              Text('${formatDate(t.date)} · ${t.businessUnit.code}${t.priority == TaskPriority.HIGH ? ' · ${l10n.highPriority}' : ''}'),
              Text('${l10n.allottedBy}: ${t.allottedBy.name} → ${t.assignee.name}'),
              if (t.details != null) Padding(padding: const EdgeInsets.only(top: 8), child: Text(t.details!)),
              if (t.reopenComment != null)
                Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: Text('${l10n.reopened}: ${t.reopenComment}', style: TextStyle(color: theme.colorScheme.tertiary)),
                ),
              if (t.status != TaskStatus.PENDING) ...[
                const SizedBox(height: 8),
                if (t.reason != null) Text('${l10n.reason}: ${t.reason}'),
                if (t.comment != null) Text('${l10n.comment}: ${t.comment}'),
                if (t.submittedAt != null) Text(l10n.submittedAt(formatDateTime(t.submittedAt!)), style: theme.textTheme.bodySmall),
              ],
              if (t.canSubmit) ...[
                const Divider(height: 24),
                SegmentedButton<bool>(
                  key: const Key('task.outcome'),
                  segments: [
                    ButtonSegment(value: true, label: Text(l10n.taskCompleted)),
                    ButtonSegment(value: false, label: Text(l10n.taskNotDone)),
                  ],
                  selected: {_completed},
                  onSelectionChanged: (s) => setState(() => _completed = s.first),
                ),
                if (!_completed)
                  TextField(
                    key: const Key('task.reason'),
                    controller: _reason,
                    decoration: InputDecoration(labelText: l10n.reason),
                  ),
                TextField(
                  key: const Key('task.comment'),
                  controller: _comment,
                  decoration: InputDecoration(labelText: '${l10n.comment} (${l10n.optional})'),
                ),
                if (_error != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Text(_error!, style: TextStyle(color: theme.colorScheme.error)),
                  ),
                const SizedBox(height: 12),
                Align(
                  alignment: Alignment.centerRight,
                  child: FilledButton(
                    key: const Key('task.submit'),
                    onPressed: _busy
                        ? null
                        : () {
                            if (!_completed && _reason.text.trim().length < 3) return setState(() => _error = l10n.reasonRequiredNotDone);
                            _run(() => repo.submit(t.id, completed: _completed, reason: text(_reason), comment: text(_comment)), l10n.taskSubmitted);
                          },
                    child: Text(l10n.submit),
                  ),
                ),
              ],
              if (t.canReopen) ...[
                const Divider(height: 24),
                TextField(
                  key: const Key('task.reopenComment'),
                  controller: _comment,
                  onChanged: (_) => setState(() {}),
                  decoration: InputDecoration(labelText: l10n.reopenComment),
                ),
                const SizedBox(height: 12),
                Align(
                  alignment: Alignment.centerRight,
                  child: OutlinedButton(
                    key: const Key('task.reopen'),
                    onPressed: _busy || _comment.text.trim().length < 3 ? null : () => _run(() => repo.reopen(t.id, _comment.text.trim()), l10n.reopened),
                    child: Text(l10n.reopen),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
