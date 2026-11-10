import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hrms_api/hrms_api.dart';

import '../../../app/l10n/app_localizations.dart';
import '../../../core/labels.dart';
import '../data/employees_repository.dart';

typedef PickedEmployee = ({String id, String name});

/// Field that opens an employee search (scoped by the API) and returns the chosen employee.
class EmployeePickerField extends ConsumerWidget {
  const EmployeePickerField({super.key, required this.value, required this.onChanged, this.errorText, this.filter = const EmployeeFilter(), this.label});

  final PickedEmployee? value;
  final ValueChanged<PickedEmployee> onChanged;
  final String? errorText;
  final EmployeeFilter filter;
  final String? label;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    return InkWell(
      key: key == null ? const Key('employeePicker') : null,
      onTap: () async {
        final picked = await showDialog<List<PickedEmployee>>(
          context: context,
          builder: (_) => EmployeeSearchDialog(filter: filter),
        );
        if (picked != null && picked.isNotEmpty) onChanged(picked.first);
      },
      child: InputDecorator(
        decoration: InputDecoration(labelText: label ?? l10n.employee, suffixIcon: const Icon(Icons.search), errorText: errorText),
        child: Text(value?.name ?? ''),
      ),
    );
  }
}

/// Search dialog; returns the chosen employee(s). With [multiple], tap to toggle and confirm with OK.
class EmployeeSearchDialog extends ConsumerStatefulWidget {
  const EmployeeSearchDialog({super.key, this.filter = const EmployeeFilter(), this.multiple = false, this.initial = const []});

  final EmployeeFilter filter;
  final bool multiple;
  final List<PickedEmployee> initial;

  @override
  ConsumerState<EmployeeSearchDialog> createState() => _EmployeeSearchDialogState();
}

class _EmployeeSearchDialogState extends ConsumerState<EmployeeSearchDialog> {
  Timer? _debounce;
  List<EmployeeListItem> _items = const [];
  bool _loading = true;
  late final Map<String, PickedEmployee> _chosen = {for (final p in widget.initial) p.id: p};

  @override
  void initState() {
    super.initState();
    _search('');
  }

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }

  Future<void> _search(String q) async {
    setState(() => _loading = true);
    try {
      final page = await ref.read(employeesRepositoryProvider).list(widget.filter.copyWith(q: q.trim()));
      if (mounted) setState(() => _items = page.items);
    } catch (_) {
      if (mounted) setState(() => _items = const []);
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return AlertDialog(
      title: Text(widget.multiple ? l10n.chooseEmployees : l10n.employee),
      content: SizedBox(
        width: 420,
        height: 420,
        child: Column(
          children: [
            TextField(
              key: const Key('employeePicker.search'),
              decoration: InputDecoration(prefixIcon: const Icon(Icons.search), hintText: l10n.employeesSearchHint),
              onChanged: (v) {
                _debounce?.cancel();
                _debounce = Timer(const Duration(milliseconds: 300), () => _search(v));
              },
            ),
            if (_loading) const LinearProgressIndicator(),
            Expanded(
              child: ListView(
                children: [
                  for (final e in _items)
                    widget.multiple
                        ? CheckboxListTile(
                            key: Key('employeePicker.${e.id}'),
                            value: _chosen.containsKey(e.id),
                            title: Text(e.fullName),
                            subtitle: Text('${e.empCode} · ${l10n.personKind(e.role, e.category.value)}'),
                            onChanged: (v) => setState(() => v == true ? _chosen[e.id] = (id: e.id, name: e.fullName) : _chosen.remove(e.id)),
                          )
                        : ListTile(
                            key: Key('employeePicker.${e.id}'),
                            title: Text(e.fullName),
                            subtitle: Text(
                              '${e.empCode} · ${l10n.personKind(e.role, e.category.value)}${e.businessUnit != null ? ' · ${e.businessUnit!.code}' : ''}',
                            ),
                            onTap: () => Navigator.pop(context, [(id: e.id, name: e.fullName)]),
                          ),
                  if (!_loading && _items.isEmpty)
                    Padding(
                      padding: const EdgeInsets.all(24),
                      child: Text(l10n.employeesEmpty, textAlign: TextAlign.center),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(onPressed: () => Navigator.pop(context), child: Text(l10n.cancel)),
        if (widget.multiple)
          FilledButton(
            key: const Key('employeePicker.ok'),
            onPressed: () => Navigator.pop(context, _chosen.values.toList()),
            child: Text(l10n.selectedCount(_chosen.length)),
          ),
      ],
    );
  }
}
