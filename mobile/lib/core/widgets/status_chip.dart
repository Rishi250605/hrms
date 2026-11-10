import 'package:flutter/material.dart';

enum Tone { good, warn, bad, info, neutral }

/// Small coloured label for statuses (compliance, approval status, attendance, …).
class StatusChip extends StatelessWidget {
  const StatusChip({super.key, required this.label, this.tone = Tone.neutral, this.icon});

  final String label;
  final Tone tone;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final (bg, fg) = switch (tone) {
      Tone.good => (Colors.green.withValues(alpha: 0.15), Colors.green.shade800),
      Tone.warn => (Colors.orange.withValues(alpha: 0.18), Colors.orange.shade900),
      Tone.bad => (scheme.errorContainer, scheme.onErrorContainer),
      Tone.info => (scheme.primaryContainer, scheme.onPrimaryContainer),
      Tone.neutral => (scheme.surfaceContainerHighest, scheme.onSurfaceVariant),
    };
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(12)),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[Icon(icon, size: 14, color: fg), const SizedBox(width: 4)],
          Text(
            label,
            style: Theme.of(context).textTheme.labelSmall?.copyWith(color: fg, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}
