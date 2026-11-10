import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/misc.dart' show Refreshable;

import '../../app/l10n/app_localizations.dart';
import '../errors/api_failure.dart';
import '../errors/failure_message.dart';

/// Renders an [AsyncValue]: spinner while loading (unless there is previous data), an error with a
/// retry button, or [data].
class AsyncView<T> extends StatelessWidget {
  const AsyncView({super.key, required this.value, required this.data, this.onRetry});

  final AsyncValue<T> value;
  final Widget Function(T data) data;
  final VoidCallback? onRetry;

  @override
  Widget build(BuildContext context) {
    final current = value.value;
    if (current != null && !value.hasError) return data(current);
    if (value.hasError) {
      return ErrorPanel(failure: ApiFailure.fromObject(value.error!), onRetry: onRetry);
    }
    return const Center(
      child: Padding(padding: EdgeInsets.all(24), child: CircularProgressIndicator()),
    );
  }
}

class ErrorPanel extends StatelessWidget {
  const ErrorPanel({super.key, required this.failure, this.onRetry});

  final ApiFailure failure;
  final VoidCallback? onRetry;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(failure.isNetwork ? Icons.cloud_off : Icons.error_outline, size: 40, color: Theme.of(context).colorScheme.error),
            const SizedBox(height: 12),
            Text(failureMessage(context, failure), textAlign: TextAlign.center),
            if (onRetry != null) ...[
              const SizedBox(height: 12),
              OutlinedButton.icon(onPressed: onRetry, icon: const Icon(Icons.refresh), label: Text(l10n.retry)),
            ],
          ],
        ),
      ),
    );
  }
}

class EmptyState extends StatelessWidget {
  const EmptyState({super.key, required this.icon, required this.message});

  final IconData icon;
  final String message;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 48),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(color: theme.colorScheme.primaryContainer.withValues(alpha: 0.5), shape: BoxShape.circle),
              child: Icon(icon, size: 40, color: theme.colorScheme.primary),
            ),
            const SizedBox(height: 16),
            Text(
              message,
              textAlign: TextAlign.center,
              style: theme.textTheme.bodyLarge?.copyWith(color: theme.colorScheme.onSurfaceVariant),
            ),
          ],
        ),
      ),
    );
  }
}

/// Shows a failure (or success text) in a snackbar.
void showMessage(BuildContext context, String text, {bool error = false}) {
  final messenger = ScaffoldMessenger.maybeOf(context);
  messenger?.hideCurrentSnackBar();
  messenger?.showSnackBar(
    SnackBar(content: Text(text), backgroundColor: error ? Theme.of(context).colorScheme.error : null, behavior: SnackBarBehavior.floating),
  );
}

void showFailure(BuildContext context, Object error) => showMessage(context, failureMessage(context, ApiFailure.fromObject(error)), error: true);

/// Extension to refresh a provider and wait for it (pull-to-refresh).
extension RefreshAndWait on WidgetRef {
  Future<void> refreshFuture<T>(Refreshable<Future<T>> provider) async {
    try {
      final future = refresh(provider);
      await future;
    } catch (_) {
      // The error is rendered by the AsyncView.
    }
  }
}
