import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hrms_api/hrms_api.dart';

import '../../../app/l10n/app_localizations.dart';
import '../../../core/labels.dart';
import '../../../core/org/org_repository.dart';
import '../../../core/session.dart';
import '../../../core/widgets/async_view.dart';
import '../../auth/domain/current_user.dart';
import '../../employees/data/employees_repository.dart';
import '../../employees/presentation/employee_picker.dart';
import '../data/users_repository.dart';
import 'users_screen.dart';

/// Role a new login reports to (§1.2): RM → OM, OM → HR, HR → director.
Role? reportsToRole(Role role) => switch (role) {
  Role.REGIONAL_MANAGER => Role.OPERATIONAL_MANAGER,
  Role.OPERATIONAL_MANAGER => Role.HR,
  Role.HR => Role.DIRECTOR,
  Role.DIRECTOR => null,
};

/// Director creates a login with a new employee record (employee code = BU prefix + digits, §Q3).
class UserFormScreen extends ConsumerStatefulWidget {
  const UserFormScreen({super.key});

  @override
  ConsumerState<UserFormScreen> createState() => _UserFormScreenState();
}

class _UserFormScreenState extends ConsumerState<UserFormScreen> {
  Role _role = Role.REGIONAL_MANAGER;
  final Set<String> _bus = {};
  String? _primary;
  final _code = TextEditingController();
  final _name = TextEditingController();
  final _phone = TextEditingController();
  final _designation = TextEditingController();
  final _password = TextEditingController();
  PickedEmployee? _reportsTo;
  String? _depotId;
  bool _saving = false;
  bool _tried = false;

  @override
  void dispose() {
    for (final c in [_code, _name, _phone, _designation, _password]) {
      c.dispose();
    }
    super.dispose();
  }

  Future<void> _suggestCode() async {
    if (_primary == null) return;
    try {
      final code = await ref.read(employeesRepositoryProvider).nextEmpCode(_primary!);
      if (mounted && _code.text.isEmpty) setState(() => _code.text = code);
    } catch (_) {}
  }

  Future<void> _submit() async {
    final l10n = AppLocalizations.of(context);
    setState(() => _tried = true);
    final phone = _phone.text.replaceAll(RegExp(r'\s'), '');
    if (_bus.isEmpty ||
        _primary == null ||
        _code.text.trim().isEmpty ||
        _name.text.trim().length < 2 ||
        phone.length < 10 ||
        _password.text.length < kMinPasswordLength ||
        _depotId == null) {
      return;
    }
    if (reportsToRole(_role) != Role.DIRECTOR && _reportsTo == null) return;
    setState(() => _saving = true);
    try {
      await ref
          .read(usersRepositoryProvider)
          .create(
            UserCreateBody(
              empCode: _code.text.trim().toUpperCase(),
              fullName: _name.text.trim(),
              phone: phone.startsWith('+') ? phone : '+91$phone',
              role: _role,
              businessUnitIds: _bus.toList(),
              primaryBusinessUnitId: _primary,
              depotId: _depotId,
              reportingToEmployeeId: _reportsTo?.id ?? (reportsToRole(_role) == Role.DIRECTOR ? ref.read(currentUserProvider)?.employeeId : null),
              designation: _designation.text.trim().isEmpty ? null : _designation.text.trim(),
              password: _password.text,
            ),
          );
      ref.invalidate(usersProvider);
      if (!mounted) return;
      showMessage(context, l10n.userCreated(_name.text.trim()));
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
    final choices = ref.watch(businessUnitChoicesProvider);
    final boss = reportsToRole(_role);
    String? err(bool bad) => _tried && bad ? l10n.required : null;
    return Scaffold(
      appBar: AppBar(title: Text(l10n.newUser)),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          DropdownButtonFormField<Role>(
            isExpanded: true,
            key: const Key('user.role'),
            initialValue: _role,
            decoration: InputDecoration(labelText: l10n.role),
            items: [
              for (final r in [Role.REGIONAL_MANAGER, Role.OPERATIONAL_MANAGER, Role.HR]) DropdownMenuItem(value: r, child: Text(l10n.apiRole(r))),
            ],
            onChanged: (r) => setState(() {
              _role = r ?? _role;
              _reportsTo = null;
            }),
          ),
          const SizedBox(height: 12),
          Text(l10n.businessUnits, style: Theme.of(context).textTheme.titleSmall),
          AsyncView<List<BuRef>>(
            value: choices,
            onRetry: () => ref.invalidate(businessUnitChoicesProvider),
            data: (list) => RadioGroup<String>(
              groupValue: _primary,
              onChanged: (v) => setState(() => _primary = v),
              child: Column(
                children: [
                  for (final b in list)
                    CheckboxListTile(
                      key: Key('user.bu.${b.code}'),
                      contentPadding: EdgeInsets.zero,
                      value: _bus.contains(b.id),
                      title: Text('${b.code} · ${b.name}'),
                      secondary: _bus.contains(b.id) ? Radio<String>(key: Key('user.primary.${b.code}'), value: b.id) : null,
                      onChanged: (v) {
                        setState(() {
                          if (v == true) {
                            _bus.add(b.id);
                            _primary ??= b.id;
                          } else {
                            _bus.remove(b.id);
                            if (_primary == b.id) _primary = _bus.firstOrNull;
                          }
                        });
                        _suggestCode();
                      },
                    ),
                  if (_tried && _bus.isEmpty) Text(l10n.required, style: TextStyle(color: Theme.of(context).colorScheme.error)),
                  if (_bus.length > 1) Text(l10n.primaryHint, style: Theme.of(context).textTheme.bodySmall),
                ],
              ),
            ),
          ),
          const SizedBox(height: 12),
          TextField(
            key: const Key('user.code'),
            controller: _code,
            textCapitalization: TextCapitalization.characters,
            decoration: InputDecoration(labelText: l10n.empCode, errorText: err(_code.text.trim().isEmpty)),
          ),
          TextField(
            key: const Key('user.name'),
            controller: _name,
            decoration: InputDecoration(labelText: l10n.fullName, errorText: err(_name.text.trim().length < 2)),
          ),
          TextField(
            key: const Key('user.phone'),
            controller: _phone,
            keyboardType: TextInputType.phone,
            decoration: InputDecoration(labelText: l10n.phoneLabel, errorText: err(_phone.text.trim().length < 10)),
          ),
          TextField(
            controller: _designation,
            decoration: InputDecoration(labelText: '${l10n.designation} (${l10n.optional})'),
          ),
          const SizedBox(height: 12),
          _depotField(context, l10n),
          const SizedBox(height: 12),
          if (boss != null && boss != Role.DIRECTOR)
            EmployeePickerField(
              key: const Key('user.reportsTo'),
              label: l10n.reportsToLabel(l10n.apiRole(boss)),
              value: _reportsTo,
              errorText: err(_reportsTo == null),
              filter: EmployeeFilter(role: boss, businessUnitId: _primary),
              onChanged: (e) => setState(() => _reportsTo = e),
            ),
          TextField(
            key: const Key('user.password'),
            controller: _password,
            decoration: InputDecoration(
              labelText: l10n.initialPassword,
              helperText: l10n.passwordRule(kMinPasswordLength),
              errorText: _tried && _password.text.length < kMinPasswordLength ? l10n.passwordRule(kMinPasswordLength) : null,
            ),
          ),
          const SizedBox(height: 16),
          FilledButton(key: const Key('user.save'), onPressed: _saving ? null : _submit, child: Text(l10n.createUser)),
        ],
      ),
    );
  }

  /// Base depot (required by the API): depots of the primary business unit.
  Widget _depotField(BuildContext context, AppLocalizations l10n) {
    final all = ref.watch(allDepotsProvider);
    return AsyncView<List<DepotItem>>(
      value: all,
      onRetry: () => ref.invalidate(allDepotsProvider),
      data: (list) {
        final depots = list.where((d) => d.businessUnitId == _primary).toList();
        // Keep the choice valid for the primary BU; pick the only depot automatically.
        final value = depots.any((d) => d.id == _depotId) ? _depotId : (depots.length == 1 ? depots.first.id : null);
        if (value != _depotId) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (mounted) setState(() => _depotId = value);
          });
        }
        if (_primary != null && depots.isEmpty) {
          return Text(l10n.noDepotsForBu, key: const Key('user.noDepots'), style: TextStyle(color: Theme.of(context).colorScheme.error));
        }
        return DropdownButtonFormField<String>(
          key: Key('user.depot.$_primary.$value'),
          isExpanded: true,
          initialValue: value,
          decoration: InputDecoration(labelText: l10n.baseDepot, errorText: _tried && _depotId == null ? l10n.required : null),
          items: [for (final d in depots) DropdownMenuItem(value: d.id, child: Text('${d.code} · ${d.name}'))],
          onChanged: (v) => setState(() => _depotId = v),
        );
      },
    );
  }
}
