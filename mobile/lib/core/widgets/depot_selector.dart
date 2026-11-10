import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../app/l10n/app_localizations.dart';
import '../org/org_repository.dart';
import '../session.dart';

/// Depot dropdown for app bars (depots of the selected business unit). Hidden when there is only one.
class DepotSelector extends ConsumerWidget {
  const DepotSelector({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final depots = ref.watch(depotsProvider).value ?? const [];
    final selected = ref.watch(selectedDepotProvider);
    if (depots.length < 2) return const SizedBox.shrink();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          key: const Key('depotSelector'),
          value: depots.any((d) => d.id == selected) ? selected : null,
          hint: Text(AppLocalizations.of(context).depot),
          items: [for (final d in depots) DropdownMenuItem(value: d.id, child: Text(d.code))],
          onChanged: (id) {
            if (id != null) ref.read(selectedDepotProvider.notifier).select(id);
          },
        ),
      ),
    );
  }
}

/// Day navigation: ‹ date › with a date picker on tap.
class DateStepper extends StatelessWidget {
  const DateStepper({super.key, required this.date, required this.label, required this.onChanged, this.firstDate, this.lastDate});

  final DateTime date;
  final String label;
  final ValueChanged<DateTime> onChanged;
  final DateTime? firstDate;
  final DateTime? lastDate;

  @override
  Widget build(BuildContext context) {
    final first = firstDate ?? DateTime(2020);
    final last = lastDate ?? DateTime(2100);
    final prev = DateTime(date.year, date.month, date.day - 1);
    final next = DateTime(date.year, date.month, date.day + 1);
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(key: const Key('date.prev'), icon: const Icon(Icons.chevron_left), onPressed: prev.isBefore(first) ? null : () => onChanged(prev)),
        TextButton(
          key: const Key('date.pick'),
          onPressed: () async {
            final picked = await showDatePicker(context: context, initialDate: date, firstDate: first, lastDate: last);
            if (picked != null) onChanged(picked);
          },
          child: Text(label),
        ),
        IconButton(key: const Key('date.next'), icon: const Icon(Icons.chevron_right), onPressed: next.isAfter(last) ? null : () => onChanged(next)),
      ],
    );
  }
}

/// Month navigation: ‹ November 2026 ›. [month] is 'YYYY-MM'.
class MonthStepper extends StatelessWidget {
  const MonthStepper({super.key, required this.month, required this.onChanged, this.label, this.allowFuture = false});

  final String month;
  final ValueChanged<String> onChanged;
  final String? label;
  final bool allowFuture;

  static String shift(String month, int delta) {
    final y = int.parse(month.substring(0, 4));
    final m = int.parse(month.substring(5, 7)) - 1 + delta;
    final d = DateTime(y, m + 1);
    return '${d.year.toString().padLeft(4, '0')}-${d.month.toString().padLeft(2, '0')}';
  }

  static String current([DateTime? now]) {
    final d = now ?? DateTime.now();
    return '${d.year}-${d.month.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    final next = shift(month, 1);
    final canNext = allowFuture || next.compareTo(current()) <= 0;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(key: const Key('month.prev'), icon: const Icon(Icons.chevron_left), onPressed: () => onChanged(shift(month, -1))),
        Text(label ?? month, key: const Key('month.label')),
        IconButton(key: const Key('month.next'), icon: const Icon(Icons.chevron_right), onPressed: canNext ? () => onChanged(next) : null),
      ],
    );
  }
}
