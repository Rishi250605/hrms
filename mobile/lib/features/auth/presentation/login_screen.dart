import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../app/l10n/app_localizations.dart';
import '../../../core/errors/api_failure.dart';
import '../../../core/errors/failure_message.dart';
import '../domain/session_state.dart';
import 'providers/login_controller.dart';
import 'providers/session_controller.dart';

/// Company logo (PHASE-2-FEATURES §3): replace assets/branding/logo.png; falls back to an icon.
class CompanyLogo extends StatelessWidget {
  const CompanyLogo({super.key, this.size = 72});

  final double size;

  @override
  Widget build(BuildContext context) => Image.asset(
    'assets/branding/logo.png',
    key: const Key('login.logo'),
    height: size,
    errorBuilder: (_, _, _) => Icon(Icons.local_shipping_rounded, size: size, color: Theme.of(context).colorScheme.primary),
  );
}

/// Employee code + password. Users never change their own password (assumption §13.10): the director resets it.
class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _code = TextEditingController();
  final _password = TextEditingController();
  final _form = GlobalKey<FormState>();
  bool _obscure = true;

  @override
  void dispose() {
    _code.dispose();
    _password.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_form.currentState!.validate()) return;
    FocusScope.of(context).unfocus();
    await ref.read(loginControllerProvider.notifier).login(_code.text, _password.text);
  }

  String _message(AppLocalizations l10n, ApiFailure f) {
    if (f.code == 'INVALID_CREDENTIALS' || f.statusCode == 401) return l10n.loginInvalid;
    if (f.code == 'ACCOUNT_LOCKED') {
      final minutes = f.details is Map ? (f.details as Map)['minutes'] : null;
      return l10n.loginLocked(minutes is num ? minutes.toInt() : 15);
    }
    if (f.code == 'ACCOUNT_DISABLED') return l10n.loginDisabled;
    return failureMessage(context, f);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final state = ref.watch(loginControllerProvider);
    final session = ref.watch(sessionControllerProvider).value;
    final expired = session is SignedOut && session.expired;

    final scheme = theme.colorScheme;
    return Scaffold(
      body: DecoratedBox(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [scheme.primaryContainer.withValues(alpha: 0.7), scheme.surface, scheme.surface],
          ),
        ),
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 420),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const CompanyLogo(size: 84),
                    const SizedBox(height: 16),
                    Text(l10n.appTitle, textAlign: TextAlign.center, style: theme.textTheme.headlineSmall),
                    const SizedBox(height: 4),
                    Text(
                      l10n.loginSubtitle,
                      textAlign: TextAlign.center,
                      style: theme.textTheme.bodyMedium?.copyWith(color: scheme.onSurfaceVariant),
                    ),
                    const SizedBox(height: 28),
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Form(
                          key: _form,
                          child: AutofillGroup(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Text(l10n.loginTitle, style: theme.textTheme.titleLarge),
                                const SizedBox(height: 16),
                                if (expired && state.failure == null) ...[
                                  _Banner(text: l10n.errorSessionExpired, color: scheme.secondaryContainer, icon: Icons.schedule),
                                  const SizedBox(height: 16),
                                ],
                                if (state.failure != null) ...[
                                  _Banner(
                                    key: const Key('login.error'),
                                    text: _message(l10n, state.failure!),
                                    color: scheme.errorContainer,
                                    icon: Icons.error_outline,
                                  ),
                                  const SizedBox(height: 16),
                                ],
                                TextFormField(
                                  key: const Key('login.empCode'),
                                  controller: _code,
                                  textCapitalization: TextCapitalization.characters,
                                  autofillHints: const [AutofillHints.username],
                                  inputFormatters: [FilteringTextInputFormatter.allow(RegExp('[A-Za-z0-9]')), LengthLimitingTextInputFormatter(20)],
                                  decoration: InputDecoration(labelText: l10n.empCode, hintText: 'NLS001', prefixIcon: const Icon(Icons.badge_outlined)),
                                  validator: (v) => RegExp(r'^[A-Za-z]{2,6}\d{1,6}$').hasMatch((v ?? '').trim()) ? null : l10n.empCodeInvalid,
                                  textInputAction: TextInputAction.next,
                                ),
                                const SizedBox(height: 16),
                                TextFormField(
                                  key: const Key('login.password'),
                                  controller: _password,
                                  obscureText: _obscure,
                                  autofillHints: const [AutofillHints.password],
                                  decoration: InputDecoration(
                                    labelText: l10n.password,
                                    prefixIcon: const Icon(Icons.lock_outline),
                                    suffixIcon: IconButton(
                                      tooltip: _obscure ? l10n.showPassword : l10n.hidePassword,
                                      icon: Icon(_obscure ? Icons.visibility_outlined : Icons.visibility_off_outlined),
                                      onPressed: () => setState(() => _obscure = !_obscure),
                                    ),
                                  ),
                                  validator: (v) => (v ?? '').isEmpty ? l10n.passwordRequired : null,
                                  onFieldSubmitted: (_) => _submit(),
                                ),
                                const SizedBox(height: 24),
                                FilledButton(
                                  key: const Key('login.submit'),
                                  onPressed: state.submitting ? null : _submit,
                                  child: state.submitting
                                      ? const SizedBox.square(dimension: 20, child: CircularProgressIndicator(strokeWidth: 2))
                                      : Text(l10n.signIn),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      l10n.forgotPasswordHint,
                      textAlign: TextAlign.center,
                      style: theme.textTheme.bodySmall?.copyWith(color: scheme.onSurfaceVariant),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _Banner extends StatelessWidget {
  const _Banner({super.key, required this.text, required this.color, required this.icon});

  final String text;
  final Color color;
  final IconData icon;

  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(12)),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 20),
        const SizedBox(width: 10),
        Expanded(child: Text(text)),
      ],
    ),
  );
}
