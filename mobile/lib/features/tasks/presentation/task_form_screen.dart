import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hrms_api/hrms_api.dart';

import '../../../app/l10n/app_localizations.dart';
import '../../../core/format.dart';
import '../../../core/session.dart';
import '../../../core/widgets/async_view.dart';
import '../../../core/widgets/date_field.dart';
import '../../employees/data/employees_repository.dart';
import '../../employees/presentation/employee_picker.dart';
import '../data/tasks_repository.dart';
import 'tasks_screen.dart';

/// OM allots a task to one or more RMs reporting to them in a shared business unit (§8.1).
class TaskFormScreen extends ConsumerStatefulWidget {
  const TaskFormScreen({super.key});

  @override
  ConsumerState<TaskFormScreen> createState() => _TaskFormScreenState();
}

class _TaskFormScreenState extends ConsumerState<TaskFormScreen> {
  String _date = todayIso();
  String? _businessUnitId;
  final _title = TextEditingController();
  final _details = TextEditingController();
  bool _high = false;
  List<PickedEmployee> _rms = const [];
  bool _saving = false;
  bool _tried = false;

  @override
  void dispose() {
    _title.dispose();
    _details.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    final l10n = AppLocalizations.of(context);
    setState(() => _tried = true);
    final bu = _businessUnitId ?? ref.read(selectedBusinessUnitProvider) ?? ref.read(currentUserProvider)?.businessUnits.firstOrNull?.id;
    if (bu == null || _title.text.trim().length < 2 || _rms.isEmpty) return;
    setState(() => _saving = true);
    try {
      final created = await ref
          .read(tasksRepositoryProvider)
          .create(
            TaskCreateBody(
              date: _date,
              businessUnitId: bu,
              title: _title.text.trim(),
              details: _details.text.trim().isEmpty ? null : _details.text.trim(),
              priority: _high ? TaskPriority.HIGH : TaskPriority.NORMAL,
              assigneeEmployeeIds: [for (final r in _rms) r.id],
            ),
          );
      ref.invalidate(tasksProvider);
      if (!mounted) return;
      showMessage(context, l10n.tasksAllotted(created.length));
      Navigator.pop(context);
    } catch (e) {
      if (mounted) {
        setState(() => _saving = false);
        showFailure(context, e);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final user = ref.watch(currentUserProvider);
    if (user == null) return const SizedBox.shrink();
    final bu = _businessUnitId ?? ref.watch(selectedBusinessUnitProvider) ?? user.businessUnits.firstOrNull?.id;
    return Scaffold(
      appBar: AppBar(title: Text(l10n.allotTask)),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          DateField(
            label: l10n.date,
            value: _date,
            firstDate: DateTime.now(),
            lastDate: DateTime.now().add(const Duration(days: 60)),
            onChanged: (v) => setState(() => _date = v),
          ),
          const SizedBox(height: 12),
          if (user.businessUnits.length > 1)
            DropdownButtonFormField<String>(
              isExpanded: true,
              key: const Key('task.bu'),
              initialValue: bu,
              decoration: InputDecoration(labelText: l10n.businessUnit),
              items: [for (final b in user.businessUnits) DropdownMenuItem(value: b.id, child: Text('${b.code} · ${b.name}'))],
              onChanged: (v) => setState(() {
                _businessUnitId = v;
                _rms = const [];
              }),
            ),
          TextField(
            key: const Key('task.title'),
            controller: _title,
            decoration: InputDecoration(labelText: l10n.taskTitle, errorText: _tried && _title.text.trim().length < 2 ? l10n.required : null),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _details,
            maxLines: 3,
            decoration: InputDecoration(labelText: '${l10n.details} (${l10n.optional})'),
          ),
          SwitchListTile(
            key: const Key('task.high'),
            contentPadding: EdgeInsets.zero,
            title: Text(l10n.highPriority),
            value: _high,
            onChanged: (v) => setState(() => _high = v),
          ),
          ListTile(
            key: const Key('task.assignees'),
            contentPadding: EdgeInsets.zero,
            title: Text(_rms.isEmpty ? l10n.chooseRms : _rms.map((r) => r.name).join(', ')),
            subtitle: _tried && _rms.isEmpty ? Text(l10n.required, style: TextStyle(color: Theme.of(context).colorScheme.error)) : null,
            trailing: const Icon(Icons.group_add_outlined),
            onTap: () async {
              final picked = await showDialog<List<PickedEmployee>>(
                context: context,
                builder: (_) => EmployeeSearchDialog(
                  multiple: true,
                  initial: _rms,
                  filter: EmployeeFilter(role: Role.REGIONAL_MANAGER, reportingToEmployeeId: user.employeeId, businessUnitId: bu),
                ),
              );
              if (picked != null) setState(() => _rms = picked);
            },
          ),
          const SizedBox(height: 16),
          FilledButton(key: const Key('task.save'), onPressed: _saving ? null : _submit, child: Text(l10n.allotTask)),
        ],
      ),
    );
  }
}
