import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../app/l10n/app_localizations.dart';
import '../session.dart';

/// App-bar switcher between the user's business units (PHASE-2-FEATURES §2.4), with "All".
/// Hidden for users with a single business unit.
class BusinessUnitSwitcher extends ConsumerWidget {
  const BusinessUnitSwitcher({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final choices = ref.watch(businessUnitChoicesProvider).value ?? const [];
    final selected = ref.watch(selectedBusinessUnitProvider);
    if (choices.length < 2) return const SizedBox.shrink();
    final current = choices.where((b) => b.id == selected).firstOrNull;
    return PopupMenuButton<String>(
      key: const Key('buSwitcher'),
      tooltip: l10n.businessUnit,
      initialValue: selected ?? '',
      onSelected: (id) => ref.read(selectedBusinessUnitProvider.notifier).select(id.isEmpty ? null : id),
      itemBuilder: (_) => [
        PopupMenuItem(value: '', key: const Key('buSwitcher.all'), child: Text(l10n.allBusinessUnits)),
        for (final b in choices) PopupMenuItem(value: b.id, key: Key('buSwitcher.${b.code}'), child: Text('${b.code} · ${b.name}')),
      ],
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.business_outlined, size: 20),
            const SizedBox(width: 4),
            Text(current?.code ?? l10n.filterAll),
            const Icon(Icons.arrow_drop_down),
          ],
        ),
      ),
    );
  }
}
