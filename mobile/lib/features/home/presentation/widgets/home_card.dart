import 'package:flutter/material.dart';

import '../../../../core/widgets/status_chip.dart';

/// Colours of a [Tone] for icons and accents (shared by cards and headers).
(Color background, Color foreground) toneColors(BuildContext context, Tone tone) {
  final scheme = Theme.of(context).colorScheme;
  return switch (tone) {
    Tone.good => (Colors.green.withValues(alpha: 0.14), Colors.green.shade700),
    Tone.warn => (Colors.orange.withValues(alpha: 0.16), Colors.orange.shade800),
    Tone.bad => (scheme.errorContainer, scheme.error),
    Tone.info => (scheme.primaryContainer, scheme.primary),
    Tone.neutral => (scheme.surfaceContainerHighest, scheme.onSurfaceVariant),
  };
}

/// A dashboard tile on a role home screen. [alert] switches the tone to "needs attention".
class HomeCard extends StatelessWidget {
  const HomeCard({
    super.key,
    required this.icon,
    required this.title,
    this.value,
    this.subtitle,
    this.onTap,
    this.alert = false,
    this.tone = Tone.info,
    this.footer,
  });

  final IconData icon;
  final String title;
  final String? value;
  final String? subtitle;
  final VoidCallback? onTap;
  final bool alert;
  final Tone tone;

  /// Optional extra content under the subtitle (e.g. a progress bar).
  final Widget? footer;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final (bg, fg) = toneColors(context, alert ? Tone.warn : tone);
    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(12)),
                    child: Icon(icon, size: 20, color: fg),
                  ),
                  const Spacer(),
                  if (onTap != null) Icon(Icons.chevron_right, size: 18, color: theme.colorScheme.outline),
                ],
              ),
              const SizedBox(height: 12),
              Text(
                value ?? '—',
                style: theme.textTheme.headlineSmall?.copyWith(color: alert ? fg : null),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 2),
              Text(
                title,
                style: theme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              if (subtitle != null) ...[
                const SizedBox(height: 4),
                Text(subtitle!, style: theme.textTheme.bodySmall?.copyWith(color: theme.colorScheme.onSurfaceVariant)),
              ],
              if (footer != null) ...[const SizedBox(height: 10), footer!],
            ],
          ),
        ),
      ),
    );
  }
}

/// Responsive grid of cards: 1 column on very narrow phones, 2 on phones, 3–4 on tablets.
class HomeCardGrid extends StatelessWidget {
  const HomeCardGrid({super.key, required this.cards});

  final List<Widget> cards;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;
        final columns = width >= 1100
            ? 4
            : width >= 700
            ? 3
            : width >= 340
            ? 2
            : 1;
        const gap = 12.0;
        final cardWidth = (width - gap * (columns - 1)) / columns;
        return Wrap(
          spacing: gap,
          runSpacing: gap,
          children: [for (final c in cards) SizedBox(width: cardWidth, child: c)],
        );
      },
    );
  }
}

/// Section title with an optional icon and trailing widget.
class SectionHeader extends StatelessWidget {
  const SectionHeader({super.key, required this.title, this.icon, this.trailing});

  final String title;
  final IconData? icon;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          if (icon != null) ...[Icon(icon, size: 20, color: theme.colorScheme.primary), const SizedBox(width: 8)],
          Expanded(child: Text(title, style: theme.textTheme.titleMedium)),
          ?trailing,
        ],
      ),
    );
  }
}

/// Stacked horizontal bar of today's attendance split (present / leave / absent / not marked …).
class AttendanceSplitBar extends StatelessWidget {
  const AttendanceSplitBar({super.key, required this.parts});

  final List<(int, Color)> parts;

  @override
  Widget build(BuildContext context) {
    final total = parts.fold<int>(0, (s, p) => s + p.$1);
    return ClipRRect(
      borderRadius: BorderRadius.circular(6),
      child: SizedBox(
        height: 8,
        child: total == 0
            ? ColoredBox(color: Theme.of(context).colorScheme.surfaceContainerHighest)
            : Row(
                children: [
                  for (final p in parts.where((p) => p.$1 > 0))
                    Expanded(
                      flex: p.$1,
                      child: ColoredBox(color: p.$2),
                    ),
                ],
              ),
      ),
    );
  }
}
