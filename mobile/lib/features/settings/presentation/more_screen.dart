import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../app/destinations.dart';
import '../../../app/l10n/app_localizations.dart';
import '../../../core/session.dart';
import '../../../core/widgets/profile_avatar.dart';
import '../../auth/domain/phone.dart';
import '../../auth/presentation/providers/session_controller.dart';

part 'more_screen.g.dart';

/// "1.2.0 (7)", or null where the platform cannot tell (tests, unsupported platforms).
@Riverpod(keepAlive: true)
Future<String?> appVersion(Ref ref) async {
  try {
    final info = await PackageInfo.fromPlatform();
    return info.buildNumber.isEmpty ? info.version : '${info.version} (${info.buildNumber})';
  } catch (_) {
    return null;
  }
}

Future<void> _confirmSignOut(BuildContext context, WidgetRef ref) async {
  final l10n = AppLocalizations.of(context);
  final ok = await showDialog<bool>(
    context: context,
    builder: (ctx) => AlertDialog(
      title: Text(l10n.logout),
      content: Text(l10n.signOutConfirm),
      actions: [
        TextButton(onPressed: () => Navigator.pop(ctx, false), child: Text(l10n.cancel)),
        TextButton(key: const Key('signOut.confirm'), onPressed: () => Navigator.pop(ctx, true), child: Text(l10n.logout)),
      ],
    ),
  );
  if (ok == true) await ref.read(sessionControllerProvider.notifier).logout();
}

/// Secondary screens of the role and sign out.
class MoreScreen extends ConsumerWidget {
  const MoreScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(currentUserProvider);
    if (user == null) return const SizedBox.shrink();
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(title: Text(l10n.navMore)),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
        children: [
          Card(
            child: ListTile(
              key: const Key('more.header'),
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              leading: InitialsAvatar(name: user.name, radius: 24),
              title: Text(user.name, style: theme.textTheme.titleMedium),
              subtitle: Text('${user.empCode} · ${roleLabel(l10n, user.role)}'),
              trailing: const Icon(Icons.chevron_right),
              onTap: () => context.push(AppDestination.profile.path),
            ),
          ),
          const SizedBox(height: 16),
          Card(
            child: Column(
              children: [
                for (final d in secondaryDestinationsFor(user.role).where((d) => d != AppDestination.profile))
                  ListTile(
                    key: Key('more.${d.name}'),
                    leading: Icon(d.icon, color: theme.colorScheme.primary),
                    title: Text(d.label(l10n)),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () => context.push(d.path),
                  ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Card(
            child: ListTile(
              key: const Key('more.logout'),
              leading: Icon(Icons.logout, color: theme.colorScheme.error),
              title: Text(
                l10n.logout,
                style: TextStyle(color: theme.colorScheme.error, fontWeight: FontWeight.w600),
              ),
              onTap: () => _confirmSignOut(context, ref),
            ),
          ),
        ],
      ),
    );
  }
}

/// My Profile (PHASE-2-FEATURES §3): employee ID, name, role, phone, reporting-to, business units, app version.
class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(currentUserProvider);
    if (user == null) return const SizedBox.shrink();
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final version = ref.watch(appVersionProvider).value;
    Widget row(IconData icon, String label, String value, {Key? key}) => ListTile(
      key: key,
      leading: Icon(icon),
      title: Text(label, style: theme.textTheme.bodySmall?.copyWith(color: theme.colorScheme.onSurfaceVariant)),
      subtitle: Text(value, style: theme.textTheme.bodyLarge),
    );
    return Scaffold(
      appBar: AppBar(title: Text(l10n.profileTitle)),
      body: RefreshIndicator(
        onRefresh: () => ref.read(sessionControllerProvider.notifier).reloadUser(),
        child: ListView(
          key: const Key('profile'),
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
          children: [
            Center(child: InitialsAvatar(name: user.name, radius: 40)),
            const SizedBox(height: 12),
            Text(user.name, textAlign: TextAlign.center, style: theme.textTheme.headlineSmall),
            Text(
              roleLabel(l10n, user.role),
              textAlign: TextAlign.center,
              style: theme.textTheme.titleSmall?.copyWith(color: theme.colorScheme.primary),
            ),
            const SizedBox(height: 20),
            Card(
              child: Column(
                children: [
                  row(Icons.badge_outlined, l10n.empCode, user.empCode),
                  row(Icons.phone_android, l10n.phoneLabel, formatIndianMobile(user.phone)),
                  if (user.email != null) row(Icons.email_outlined, l10n.email, user.email!),
                  row(
                    Icons.supervisor_account_outlined,
                    l10n.reportingManager,
                    user.reportingToName == null
                        ? l10n.none
                        : [
                            '${user.reportingToName} (${user.reportingToCode})',
                            if (user.reportingToRole != null) roleLabel(l10n, user.reportingToRole!),
                          ].join(' · '),
                    key: const Key('profile.reportsTo'),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(l10n.businessUnits, style: theme.textTheme.titleSmall),
                    const SizedBox(height: 10),
                    if (user.isDirector)
                      Chip(label: Text(l10n.allBusinessUnits))
                    else
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: [
                          for (final b in user.businessUnits)
                            Chip(
                              key: Key('profile.bu.${b.code}'),
                              avatar: b.isPrimary ? Icon(Icons.star, size: 18, color: theme.colorScheme.primary) : null,
                              label: Text(b.isPrimary ? '${b.name} (${b.code}) · ${l10n.primary}' : '${b.name} (${b.code})'),
                            ),
                        ],
                      ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text(l10n.passwordByDirector, textAlign: TextAlign.center, style: theme.textTheme.bodySmall),
            if (version != null) Text(l10n.appVersion(version), textAlign: TextAlign.center, style: theme.textTheme.bodySmall),
            const SizedBox(height: 16),
            OutlinedButton.icon(
              key: const Key('profile.signOut'),
              onPressed: () => _confirmSignOut(context, ref),
              icon: Icon(Icons.logout, color: theme.colorScheme.error),
              label: Text(l10n.logout, style: TextStyle(color: theme.colorScheme.error)),
            ),
          ],
        ),
      ),
    );
  }
}
