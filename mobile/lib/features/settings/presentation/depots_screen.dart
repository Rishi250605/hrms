import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hrms_api/hrms_api.dart';

import '../../../app/l10n/app_localizations.dart';
import '../../../core/org/org_repository.dart';
import '../../../core/session.dart';
import '../../../core/widgets/async_view.dart';

/// Director: depots (each in one business unit and one region). Every employee and login needs a base depot.
class DepotsScreen extends ConsumerWidget {
  const DepotsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final depots = ref.watch(allDepotsProvider);
    return Scaffold(
      appBar: AppBar(title: Text(l10n.navDepots)),
      floatingActionButton: FloatingActionButton.extended(
        key: const Key('depots.add'),
        onPressed: () => showDialog<void>(context: context, builder: (_) => const _DepotDialog()),
        icon: const Icon(Icons.add),
        label: Text(l10n.addDepot),
      ),
      body: RefreshIndicator(
        onRefresh: () => ref.refresh(allDepotsProvider.future),
        child: AsyncView<List<DepotItem>>(
          value: depots,
          onRetry: () => ref.invalidate(allDepotsProvider),
          data: (items) => items.isEmpty
              ? ListView(children: [EmptyState(icon: Icons.warehouse_outlined, message: l10n.noDepotsYet)])
              : ListView.separated(
                  padding: const EdgeInsets.only(bottom: 96),
                  itemCount: items.length,
                  separatorBuilder: (_, _) => const Divider(height: 1),
                  itemBuilder: (_, i) {
                    final d = items[i];
                    return ListTile(
                      key: Key('depot.${d.code}'),
                      leading: const Icon(Icons.warehouse_outlined),
                      title: Text('${d.code} · ${d.name}'),
                      subtitle: Text('${d.businessUnitCode} · ${d.regionName} · ${d.state}'),
                    );
                  },
                ),
        ),
      ),
    );
  }
}

class _DepotDialog extends ConsumerStatefulWidget {
  const _DepotDialog();

  @override
  ConsumerState<_DepotDialog> createState() => _DepotDialogState();
}

class _DepotDialogState extends ConsumerState<_DepotDialog> {
  final _form = GlobalKey<FormState>();
  final _code = TextEditingController();
  final _name = TextEditingController();
  final _state = TextEditingController();
  String? _bu;
  String? _region;
  bool _busy = false;

  @override
  void dispose() {
    for (final c in [_code, _name, _state]) {
      c.dispose();
    }
    super.dispose();
  }

  Future<void> _newRegion() async {
    final l10n = AppLocalizations.of(context);
    final code = TextEditingController();
    final name = TextEditingController();
    final form = GlobalKey<FormState>();
    final ok = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(l10n.addRegion),
        content: Form(
          key: form,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                key: const Key('region.name'),
                controller: name,
                decoration: InputDecoration(labelText: l10n.regionName),
                validator: (v) => (v ?? '').trim().length < 2 ? l10n.required : null,
              ),
              TextFormField(
                key: const Key('region.code'),
                controller: code,
                textCapitalization: TextCapitalization.characters,
                inputFormatters: [FilteringTextInputFormatter.allow(RegExp('[A-Za-z0-9_-]')), LengthLimitingTextInputFormatter(16)],
                decoration: InputDecoration(labelText: l10n.codeLabel),
                validator: (v) => (v ?? '').trim().length < 2 ? l10n.required : null,
              ),
            ],
          ),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx, false), child: Text(l10n.cancel)),
          TextButton(
            key: const Key('region.save'),
            onPressed: () {
              if (form.currentState!.validate()) Navigator.pop(ctx, true);
            },
            child: Text(l10n.save),
          ),
        ],
      ),
    );
    if (ok != true) return;
    try {
      final r = await ref.read(orgRepositoryProvider).createRegion(code: code.text.trim().toUpperCase(), name: name.text.trim());
      ref.invalidate(regionsProvider);
      if (mounted) setState(() => _region = r.id);
    } catch (e) {
      if (mounted) showFailure(context, e);
    }
  }

  Future<void> _save() async {
    if (!_form.currentState!.validate()) return;
    final l10n = AppLocalizations.of(context);
    setState(() => _busy = true);
    try {
      await ref
          .read(orgRepositoryProvider)
          .createDepot(regionId: _region!, businessUnitId: _bu!, code: _code.text.trim().toUpperCase(), name: _name.text.trim(), state: _state.text.trim().toUpperCase());
      ref.invalidate(allDepotsProvider);
      ref.invalidate(depotsProvider);
      ref.invalidate(regionsProvider);
      if (mounted) {
        Navigator.pop(context);
        showMessage(context, l10n.depotCreated);
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
    final bus = ref.watch(businessUnitChoicesProvider).value ?? const [];
    final regions = ref.watch(regionsProvider).value ?? const <RegionItem>[];
    return AlertDialog(
      title: Text(l10n.addDepot),
      content: Form(
        key: _form,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              DropdownButtonFormField<String>(
                key: const Key('depot.bu'),
                isExpanded: true,
                initialValue: _bu,
                decoration: InputDecoration(labelText: l10n.businessUnit),
                items: [for (final b in bus) DropdownMenuItem(value: b.id, child: Text('${b.code} · ${b.name}'))],
                onChanged: (v) => setState(() => _bu = v),
                validator: (v) => v == null ? l10n.required : null,
              ),
              Row(
                children: [
                  Expanded(
                    child: DropdownButtonFormField<String>(
                      key: Key('depot.region.$_region.${regions.length}'),
                      isExpanded: true,
                      initialValue: regions.any((r) => r.id == _region) ? _region : null,
                      decoration: InputDecoration(labelText: l10n.region),
                      items: [for (final r in regions) DropdownMenuItem(value: r.id, child: Text(r.name))],
                      onChanged: (v) => setState(() => _region = v),
                      validator: (v) => v == null ? l10n.required : null,
                    ),
                  ),
                  IconButton(key: const Key('depot.newRegion'), tooltip: l10n.addRegion, onPressed: _busy ? null : _newRegion, icon: const Icon(Icons.add)),
                ],
              ),
              TextFormField(
                key: const Key('depot.name'),
                controller: _name,
                decoration: InputDecoration(labelText: l10n.depotName),
                validator: (v) => (v ?? '').trim().length < 2 ? l10n.required : null,
              ),
              TextFormField(
                key: const Key('depot.code'),
                controller: _code,
                textCapitalization: TextCapitalization.characters,
                inputFormatters: [FilteringTextInputFormatter.allow(RegExp('[A-Za-z0-9_-]')), LengthLimitingTextInputFormatter(16)],
                decoration: InputDecoration(labelText: l10n.codeLabel, hintText: 'PUN'),
                validator: (v) => (v ?? '').trim().length < 2 ? l10n.required : null,
              ),
              TextFormField(
                key: const Key('depot.state'),
                controller: _state,
                textCapitalization: TextCapitalization.characters,
                inputFormatters: [FilteringTextInputFormatter.allow(RegExp('[A-Za-z]')), LengthLimitingTextInputFormatter(2)],
                decoration: InputDecoration(labelText: l10n.stateCode, hintText: 'MH'),
                validator: (v) => (v ?? '').trim().length != 2 ? l10n.stateCode : null,
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(onPressed: _busy ? null : () => Navigator.pop(context), child: Text(l10n.cancel)),
        TextButton(key: const Key('depot.save'), onPressed: _busy ? null : _save, child: Text(l10n.save)),
      ],
    );
  }
}
