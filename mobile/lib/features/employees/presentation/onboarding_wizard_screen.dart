import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:hrms_api/hrms_api.dart';

import '../../../app/l10n/app_localizations.dart';
import '../../../app/router.dart';
import '../../../core/format.dart';
import '../../../core/labels.dart';
import '../../../core/widgets/async_view.dart';
import '../../../core/widgets/date_field.dart';
import '../../auth/domain/phone.dart';
import '../data/employees_repository.dart';
import 'providers/employees_providers.dart';

/// HR onboarding (CLAUDE.md §9): personal → job → statutory & bank → review. Creates the employee and the
/// first effective-dated job row in one call.
class OnboardingWizardScreen extends ConsumerStatefulWidget {
  const OnboardingWizardScreen({super.key});

  @override
  ConsumerState<OnboardingWizardScreen> createState() => _OnboardingWizardScreenState();
}

class _OnboardingWizardScreenState extends ConsumerState<OnboardingWizardScreen> {
  final _keys = List.generate(3, (_) => GlobalKey<FormState>());
  int _step = 0;
  bool _saving = false;

  // Personal
  final _empCode = TextEditingController();
  final _name = TextEditingController();
  final _phone = TextEditingController();
  String? _dob;
  Gender? _gender;
  EmployeeCategory _category = EmployeeCategory.DRIVER;
  EmploymentType _employmentType = EmploymentType.PERMANENT;
  final _contractor = TextEditingController();
  PreferredChannel _channel = PreferredChannel.WHATSAPP;

  // Job
  String _joining = todayIso();
  String? _depotId;
  final _designation = TextEditingController(text: 'Driver');
  final _grade = TextEditingController();
  String? _reportingToEmployeeId;

  // Statutory & bank
  final _uan = TextEditingController();
  final _esic = TextEditingController();
  final _pan = TextEditingController();
  final _aadhaar = TextEditingController();
  final _bank = TextEditingController();
  final _ifsc = TextEditingController();

  String? _opt(TextEditingController c) => c.text.trim().isEmpty ? null : c.text.trim();

  String? get _businessUnitId => ref.read(onboardingDepotsProvider).value?.where((d) => d.id == _depotId).firstOrNull?.businessUnitId;

  EmployeeCreateBody _body() => EmployeeCreateBody(
    businessUnitId: _businessUnitId ?? '',
    empCode: _empCode.text.trim().toUpperCase(),
    fullName: _name.text.trim(),
    phone: normalizeIndianMobile(_phone.text) ?? _phone.text.trim(),
    dob: _dob,
    gender: _gender,
    joiningDate: _joining,
    category: _category,
    employmentType: _employmentType,
    contractorName: _employmentType == EmploymentType.CONTRACT ? _opt(_contractor) : null,
    preferredChannel: _channel,
    uan: _opt(_uan),
    esicNo: _opt(_esic),
    pan: _opt(_pan)?.toUpperCase(),
    aadhaarLast4: _opt(_aadhaar),
    bankAccount: _opt(_bank),
    ifsc: _opt(_ifsc)?.toUpperCase(),
    job: JobInput(depotId: _depotId!, designation: _designation.text.trim(), grade: _opt(_grade), reportingToEmployeeId: _reportingToEmployeeId ?? ''),
  );

  Future<void> _submit() async {
    setState(() => _saving = true);
    try {
      final created = await ref.read(employeesRepositoryProvider).create(_body());
      ref.invalidate(employeeListProvider);
      if (!mounted) return;
      showMessage(context, AppLocalizations.of(context).employeeCreated(created.fullName));
      context.pushReplacement(Routes.employee(created.id));
    } catch (err) {
      if (mounted) {
        setState(() => _saving = false);
        showFailure(context, err);
      }
    }
  }

  void _next() {
    if (_step < 3 && !_keys[_step].currentState!.validate()) return;
    if (_step == 3) {
      _submit();
    } else {
      setState(() => _step += 1);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    String? required(String? v) => (v ?? '').trim().isEmpty ? l10n.required : null;
    String? pattern(String? v, RegExp re, String message) => (v ?? '').trim().isEmpty || re.hasMatch(v!.trim().toUpperCase()) ? null : message;

    return Scaffold(
      appBar: AppBar(title: Text(l10n.onboardTitle)),
      body: Stepper(
        key: const Key('onboard.stepper'),
        currentStep: _step,
        onStepTapped: (i) => setState(() => _step = i < _step ? i : _step),
        onStepContinue: _saving ? null : _next,
        onStepCancel: _step == 0 ? null : () => setState(() => _step -= 1),
        controlsBuilder: (context, details) => Padding(
          padding: const EdgeInsets.only(top: 16),
          child: Row(
            children: [
              Expanded(
                child: FilledButton(
                  key: Key('onboard.next.${details.stepIndex}'),
                  onPressed: details.onStepContinue,
                  child: _saving
                      ? const SizedBox(height: 20, width: 20, child: CircularProgressIndicator(strokeWidth: 2))
                      : Text(details.stepIndex == 3 ? l10n.createEmployee : l10n.next),
                ),
              ),
              if (details.onStepCancel != null) ...[const SizedBox(width: 12), TextButton(onPressed: details.onStepCancel, child: Text(l10n.back))],
            ],
          ),
        ),
        steps: [
          Step(
            title: Text(l10n.stepPersonal),
            isActive: _step >= 0,
            content: Form(
              key: _keys[0],
              child: Column(
                children: [
                  TextFormField(
                    key: const Key('onboard.empCode'),
                    controller: _empCode,
                    decoration: InputDecoration(labelText: l10n.empCode),
                    validator: required,
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    key: const Key('onboard.name'),
                    controller: _name,
                    decoration: InputDecoration(labelText: l10n.fullName),
                    validator: required,
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    key: const Key('onboard.phone'),
                    controller: _phone,
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(labelText: l10n.phoneLabel, prefixText: '+91 '),
                    validator: (v) => normalizeIndianMobile(v ?? '') == null ? l10n.phoneInvalid : null,
                  ),
                  const SizedBox(height: 12),
                  DropdownButtonFormField<EmployeeCategory>(
                    isExpanded: true,
                    key: const Key('onboard.category'),
                    initialValue: _category,
                    decoration: InputDecoration(labelText: l10n.categoryLabel),
                    items: [for (final c in EmployeeCategory.values) DropdownMenuItem(value: c, child: Text(l10n.category(c)))],
                    onChanged: (c) => setState(() => _category = c ?? _category),
                  ),
                  const SizedBox(height: 12),
                  DropdownButtonFormField<EmploymentType>(
                    isExpanded: true,
                    initialValue: _employmentType,
                    decoration: InputDecoration(labelText: l10n.employmentTypeLabel),
                    items: [for (final t in EmploymentType.values) DropdownMenuItem(value: t, child: Text(l10n.employmentType(t)))],
                    onChanged: (t) => setState(() => _employmentType = t ?? _employmentType),
                  ),
                  if (_employmentType == EmploymentType.CONTRACT) ...[
                    const SizedBox(height: 12),
                    TextFormField(
                      controller: _contractor,
                      decoration: InputDecoration(labelText: l10n.contractor),
                      validator: required,
                    ),
                  ],
                  const SizedBox(height: 12),
                  DateField(label: l10n.dob, value: _dob, lastDate: DateTime.now(), onChanged: (v) => setState(() => _dob = v)),
                  const SizedBox(height: 12),
                  DropdownButtonFormField<Gender>(
                    isExpanded: true,
                    initialValue: _gender,
                    decoration: InputDecoration(labelText: l10n.gender),
                    items: [
                      DropdownMenuItem(value: Gender.MALE, child: Text(l10n.genderMale)),
                      DropdownMenuItem(value: Gender.FEMALE, child: Text(l10n.genderFemale)),
                      DropdownMenuItem(value: Gender.OTHER, child: Text(l10n.genderOther)),
                    ],
                    onChanged: (g) => setState(() => _gender = g),
                  ),
                  const SizedBox(height: 12),
                  SegmentedButton<PreferredChannel>(
                    segments: [
                      ButtonSegment(value: PreferredChannel.WHATSAPP, label: Text(l10n.channelWhatsapp)),
                      ButtonSegment(value: PreferredChannel.SMS, label: Text(l10n.channelSms)),
                    ],
                    selected: {_channel},
                    onSelectionChanged: (s) => setState(() => _channel = s.first),
                  ),
                ],
              ),
            ),
          ),
          Step(
            title: Text(l10n.stepJob),
            isActive: _step >= 1,
            content: Form(key: _keys[1], child: _jobFields(l10n, required)),
          ),
          Step(
            title: Text(l10n.stepStatutory),
            subtitle: Text(l10n.optional),
            isActive: _step >= 2,
            content: Form(
              key: _keys[2],
              child: Column(
                children: [
                  TextFormField(
                    controller: _uan,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(labelText: 'UAN'),
                    validator: (v) => pattern(v, RegExp(r'^\d{12}$'), l10n.invalidValue),
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: _esic,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(labelText: 'ESIC'),
                    validator: (v) => pattern(v, RegExp(r'^\d{10,17}$'), l10n.invalidValue),
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: _pan,
                    textCapitalization: TextCapitalization.characters,
                    decoration: const InputDecoration(labelText: 'PAN'),
                    validator: (v) => pattern(v, RegExp(r'^[A-Z]{5}[0-9]{4}[A-Z]$'), l10n.invalidValue),
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: _aadhaar,
                    keyboardType: TextInputType.number,
                    maxLength: 4,
                    decoration: InputDecoration(labelText: l10n.aadhaarLast4, helperText: l10n.aadhaarHelper),
                    validator: (v) => pattern(v, RegExp(r'^\d{4}$'), l10n.aadhaarLast4Invalid),
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: _bank,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(labelText: l10n.bankAccount),
                    validator: (v) => pattern(v, RegExp(r'^\d{9,18}$'), l10n.invalidValue),
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: _ifsc,
                    textCapitalization: TextCapitalization.characters,
                    decoration: const InputDecoration(labelText: 'IFSC'),
                    validator: (v) {
                      if (_bank.text.trim().isNotEmpty && (v ?? '').trim().isEmpty) return l10n.required;
                      return pattern(v, RegExp(r'^[A-Z]{4}0[A-Z0-9]{6}$'), l10n.invalidValue);
                    },
                  ),
                ],
              ),
            ),
          ),
          Step(title: Text(l10n.stepReview), isActive: _step >= 3, content: _step == 3 ? _review(l10n) : const SizedBox.shrink()),
        ],
      ),
    );
  }

  Widget _jobFields(AppLocalizations l10n, String? Function(String?) required) {
    final depots = ref.watch(onboardingDepotsProvider);
    final bu = depots.value?.where((d) => d.id == _depotId).firstOrNull?.businessUnitId;
    final managers = bu == null ? null : ref.watch(businessUnitRmsProvider(bu));
    return Column(
      children: [
        DateField(key: const Key('onboard.joining'), label: l10n.joiningDate, value: _joining, onChanged: (v) => setState(() => _joining = v)),
        const SizedBox(height: 12),
        AsyncView(
          value: depots,
          data: (items) => DropdownButtonFormField<String>(
            isExpanded: true,
            key: const Key('onboard.depot'),
            initialValue: _depotId,
            decoration: InputDecoration(labelText: l10n.depot),
            items: [for (final d in items) DropdownMenuItem(value: d.id, child: Text('${d.name} (${d.code}) · ${d.businessUnitCode}'))],
            validator: (v) => v == null ? l10n.required : null,
            onChanged: (v) => setState(() {
              _depotId = v;
              _reportingToEmployeeId = null;
            }),
          ),
        ),
        const SizedBox(height: 12),
        TextFormField(
          key: const Key('onboard.designation'),
          controller: _designation,
          decoration: InputDecoration(labelText: l10n.designation),
          validator: required,
        ),
        const SizedBox(height: 12),
        TextFormField(
          controller: _grade,
          decoration: InputDecoration(labelText: l10n.grade),
        ),
        const SizedBox(height: 12),
        if (managers != null)
          AsyncView(
            value: managers,
            data: (items) => DropdownButtonFormField<String>(
              isExpanded: true,
              key: const Key('onboard.reportsTo'),
              initialValue: _reportingToEmployeeId,
              decoration: InputDecoration(labelText: l10n.reportingManager),
              items: [for (final u in items.where((u) => u.isActive)) DropdownMenuItem(value: u.employeeId, child: Text('${u.name} (${u.empCode})'))],
              validator: (v) => v == null ? l10n.required : null,
              onChanged: (v) => setState(() => _reportingToEmployeeId = v),
            ),
          ),
      ],
    );
  }

  Widget _review(AppLocalizations l10n) {
    final b = _body();
    final depot = ref.read(onboardingDepotsProvider).value?.where((d) => d.id == _depotId).firstOrNull;
    Widget row(String k, String? v) => v == null ? const SizedBox.shrink() : ListTile(dense: true, title: Text(k), trailing: Text(v));
    return Column(
      key: const Key('onboard.review'),
      children: [
        row(l10n.empCode, b.empCode),
        row(l10n.fullName, b.fullName),
        row(l10n.phoneLabel, formatIndianMobile(b.phone)),
        row(l10n.categoryLabel, l10n.category(b.category)),
        row(l10n.employmentTypeLabel, l10n.employmentType(b.employmentType)),
        row(l10n.joiningDate, formatDate(b.joiningDate)),
        row(l10n.depot, depot == null ? null : '${depot.name} (${depot.code})'),
        row(l10n.designation, b.job.designation),
        row('PAN', b.pan == null ? null : 'XXXXXX${b.pan!.substring(b.pan!.length - 4)}'),
        row(l10n.aadhaarLast4, b.aadhaarLast4),
        row(l10n.bankAccount, b.bankAccount == null ? null : 'XXXX${b.bankAccount!.substring(b.bankAccount!.length - 4)}'),
      ],
    );
  }
}
