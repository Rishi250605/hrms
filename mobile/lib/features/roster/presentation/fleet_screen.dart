import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hrms_api/hrms_api.dart';

import '../../../app/l10n/app_localizations.dart';
import '../../../core/session.dart';
import '../../../core/widgets/async_view.dart';
import '../../../core/widgets/depot_selector.dart';
import '../../../core/widgets/status_chip.dart';
import '../data/roster_repository.dart';
import 'providers/roster_providers.dart';

/// Vehicles, routes and duty templates of a depot (master data for the roster).
class FleetScreen extends ConsumerWidget {
  const FleetScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final depotId = ref.watch(selectedDepotProvider);
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text(l10n.navFleet),
          actions: const [DepotSelector()],
          bottom: TabBar(
            tabs: [
              Tab(text: l10n.vehicles),
              Tab(text: l10n.routes),
              Tab(text: l10n.dutyTemplates),
            ],
          ),
        ),
        floatingActionButton: depotId == null
            ? null
            : Builder(
                builder: (context) => FloatingActionButton(
                  key: const Key('fleet.add'),
                  onPressed: () async {
                    final tab = DefaultTabController.of(context).index;
                    final ok = await showDialog<bool>(
                      context: context,
                      builder: (_) => _AddFleetDialog(depotId: depotId, tab: tab),
                    );
                    if (ok == true) ref.invalidate(fleetDataProvider(depotId));
                  },
                  child: const Icon(Icons.add),
                ),
              ),
        body: depotId == null
            ? EmptyState(icon: Icons.warehouse_outlined, message: l10n.scopeNone)
            : AsyncView(
                value: ref.watch(fleetDataProvider(depotId)),
                onRetry: () => ref.invalidate(fleetDataProvider(depotId)),
                data: (f) => TabBarView(
                  children: [
                    ListView(
                      children: [
                        for (final v in f.vehicles)
                          ListTile(
                            leading: const Icon(Icons.directions_bus_outlined),
                            title: Text(v.regNo),
                            subtitle: Text('${v.type}${v.capacity != null ? ' · ${v.capacity}' : ''}'),
                            trailing: StatusChip(label: v.status.value, tone: v.status == VehicleStatus.ACTIVE ? Tone.good : Tone.warn),
                          ),
                      ],
                    ),
                    ListView(
                      children: [
                        for (final r in f.routes)
                          ListTile(
                            leading: const Icon(Icons.alt_route),
                            title: Text('${r.code} · ${r.name}'),
                            subtitle: Text('${r.origin} → ${r.destination} · ${l10n.minutes(r.standardMinutes)}'),
                          ),
                      ],
                    ),
                    ListView(
                      children: [
                        for (final t in f.templates)
                          ListTile(
                            leading: const Icon(Icons.schedule),
                            title: Text(t.name),
                            subtitle: Text('${t.startTime}–${t.endTime}${t.crossesMidnight ? ' (+1)' : ''}${t.route != null ? ' · ${t.route!.code}' : ''}'),
                          ),
                      ],
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}

class _AddFleetDialog extends ConsumerStatefulWidget {
  const _AddFleetDialog({required this.depotId, required this.tab});

  final String depotId;
  final int tab;

  @override
  ConsumerState<_AddFleetDialog> createState() => _AddFleetDialogState();
}

class _AddFleetDialogState extends ConsumerState<_AddFleetDialog> {
  final _a = TextEditingController();
  final _b = TextEditingController();
  final _c = TextEditingController();
  final _d = TextEditingController();

  Future<void> _save() async {
    final repo = ref.read(rosterRepositoryProvider);
    try {
      switch (widget.tab) {
        case 0:
          await repo.createVehicle(
            VehicleCreateBody(regNo: _a.text.trim(), type: _b.text.trim(), capacity: int.tryParse(_c.text.trim()), depotId: widget.depotId),
          );
        case 1:
          await repo.createRoute(
            RouteCreateBody(
              code: _a.text.trim(),
              name: _b.text.trim(),
              origin: _c.text.trim(),
              destination: _d.text.trim(),
              standardMinutes: 480,
              depotId: widget.depotId,
            ),
          );
        default:
          await repo.createTemplate(DutyTemplateCreateBody(depotId: widget.depotId, name: _a.text.trim(), startTime: _b.text.trim(), endTime: _c.text.trim()));
      }
      if (mounted) Navigator.pop(context, true);
    } catch (err) {
      if (mounted) showFailure(context, err);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final (title, labels) = switch (widget.tab) {
      0 => (l10n.addVehicle, [l10n.regNo, l10n.vehicleType, l10n.capacity]),
      1 => (l10n.addRoute, [l10n.code, l10n.name, l10n.origin, l10n.destination]),
      _ => (l10n.addTemplate, [l10n.name, '${l10n.start} (HH:MM)', '${l10n.end} (HH:MM)']),
    };
    final controllers = [_a, _b, _c, _d];
    return AlertDialog(
      title: Text(title),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          for (var i = 0; i < labels.length; i++)
            Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: TextField(
                controller: controllers[i],
                decoration: InputDecoration(labelText: labels[i]),
              ),
            ),
        ],
      ),
      actions: [
        TextButton(onPressed: () => Navigator.pop(context), child: Text(l10n.cancel)),
        FilledButton(onPressed: _save, child: Text(l10n.save)),
      ],
    );
  }
}
