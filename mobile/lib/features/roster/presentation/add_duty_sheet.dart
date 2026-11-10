import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hrms_api/hrms_api.dart';

import '../../../app/l10n/app_localizations.dart';
import '../../../core/format.dart';
import '../../../core/widgets/async_view.dart';
import '../data/roster_repository.dart';
import 'providers/roster_providers.dart';

/// New duty from a template (times + default route) or explicit times. Pops `true` when created.
class AddDutySheet extends ConsumerStatefulWidget {
  const AddDutySheet({super.key, required this.depotId, required this.date});

  final String depotId;
  final String date;

  @override
  ConsumerState<AddDutySheet> createState() => _AddDutySheetState();
}

class _AddDutySheetState extends ConsumerState<AddDutySheet> {
  String? _templateId;
  TimeOfDay _start = const TimeOfDay(hour: 6, minute: 0);
  TimeOfDay _end = const TimeOfDay(hour: 14, minute: 0);
  String? _routeId;
  String? _vehicleId;
  bool _saving = false;

  String _hhmm(TimeOfDay t) => '${t.hour.toString().padLeft(2, '0')}:${t.minute.toString().padLeft(2, '0')}';

  Future<void> _save() async {
    setState(() => _saving = true);
    try {
      await ref
          .read(rosterRepositoryProvider)
          .createDuty(
            DutyCreateBody(
              depotId: widget.depotId,
              dutyDate: widget.date,
              templateId: _templateId,
              startTime: _templateId == null ? _hhmm(_start) : null,
              endTime: _templateId == null ? _hhmm(_end) : null,
              routeId: _routeId,
              vehicleId: _vehicleId,
            ),
          );
      if (mounted) Navigator.pop(context, true);
    } catch (err) {
      if (mounted) {
        setState(() => _saving = false);
        showFailure(context, err);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final fleet = ref.watch(fleetDataProvider(widget.depotId));
    return Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.viewInsetsOf(context).bottom),
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: AsyncView(
          value: fleet,
          onRetry: () => ref.invalidate(fleetDataProvider(widget.depotId)),
          data: (f) => Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('${l10n.addDuty} · ${formatDate(widget.date)}', style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 16),
              DropdownButtonFormField<String?>(
                isExpanded: true,
                key: const Key('addDuty.template'),
                initialValue: _templateId,
                decoration: InputDecoration(labelText: l10n.dutyTemplate),
                items: [
                  DropdownMenuItem(value: null, child: Text(l10n.customTimes)),
                  for (final t in f.templates) DropdownMenuItem(value: t.id, child: Text('${t.name} (${t.startTime}–${t.endTime})')),
                ],
                onChanged: (v) => setState(() {
                  _templateId = v;
                  _routeId = v == null ? _routeId : f.templates.firstWhere((t) => t.id == v).route?.id;
                }),
              ),
              if (_templateId == null) ...[
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        key: const Key('addDuty.start'),
                        onPressed: () async {
                          final t = await showTimePicker(context: context, initialTime: _start);
                          if (t != null) setState(() => _start = t);
                        },
                        child: Text('${l10n.start}: ${_hhmm(_start)}'),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: OutlinedButton(
                        key: const Key('addDuty.end'),
                        onPressed: () async {
                          final t = await showTimePicker(context: context, initialTime: _end);
                          if (t != null) setState(() => _end = t);
                        },
                        child: Text('${l10n.end}: ${_hhmm(_end)}'),
                      ),
                    ),
                  ],
                ),
                if (_hhmm(_end).compareTo(_hhmm(_start)) < 0) Padding(padding: const EdgeInsets.only(top: 4), child: Text(l10n.endsNextDay)),
              ],
              const SizedBox(height: 12),
              DropdownButtonFormField<String?>(
                isExpanded: true,
                initialValue: _routeId,
                decoration: InputDecoration(labelText: l10n.route),
                items: [
                  DropdownMenuItem(value: null, child: Text(l10n.none)),
                  for (final r in f.routes) DropdownMenuItem(value: r.id, child: Text('${r.code} · ${r.name}')),
                ],
                onChanged: (v) => setState(() => _routeId = v),
              ),
              const SizedBox(height: 12),
              DropdownButtonFormField<String?>(
                isExpanded: true,
                initialValue: _vehicleId,
                decoration: InputDecoration(labelText: l10n.vehicle),
                items: [
                  DropdownMenuItem(value: null, child: Text(l10n.none)),
                  for (final v in f.vehicles.where((v) => v.status == VehicleStatus.ACTIVE))
                    DropdownMenuItem(value: v.id, child: Text('${v.regNo} · ${v.type}')),
                ],
                onChanged: (v) => setState(() => _vehicleId = v),
              ),
              const SizedBox(height: 16),
              FilledButton(key: const Key('addDuty.save'), onPressed: _saving ? null : _save, child: Text(l10n.save)),
            ],
          ),
        ),
      ),
    );
  }
}
