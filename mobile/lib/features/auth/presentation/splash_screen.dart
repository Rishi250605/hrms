import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../app/l10n/app_localizations.dart';
import 'login_screen.dart' show CompanyLogo;
import 'providers/session_controller.dart';

/// Shown while the stored session is restored, or when the server could not be reached.
class SplashScreen extends ConsumerWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final session = ref.watch(sessionControllerProvider);
    final theme = Theme.of(context);

    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const CompanyLogo(size: 80),
              const SizedBox(height: 16),
              Text(l10n.appTitle, style: theme.textTheme.headlineSmall),
              const SizedBox(height: 24),
              if (session.hasError && !session.isLoading) ...[
                Text(l10n.sessionLoadFailed, textAlign: TextAlign.center),
                const SizedBox(height: 16),
                FilledButton.icon(onPressed: () => ref.invalidate(sessionControllerProvider), icon: const Icon(Icons.refresh), label: Text(l10n.retry)),
              ] else ...[
                const CircularProgressIndicator(),
                const SizedBox(height: 12),
                Text(l10n.loadingSession),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
