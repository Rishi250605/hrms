import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:hrms_api/hrms_api.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../app/l10n/app_localizations.dart';
import '../../../app/router.dart';
import '../../../core/format.dart';
import '../../../core/labels.dart';
import '../../../core/session.dart';
import '../../../core/widgets/async_view.dart';
import '../../../core/widgets/bu_switcher.dart';
import '../../../core/widgets/status_chip.dart';
import '../data/users_repository.dart';

part 'users_screen.g.dart';

@riverpod
Future<UserList> users(Ref ref, String q) =>
    ref.watch(usersRepositoryProvider).list(q: q.isEmpty ? null : q, businessUnitId: ref.watch(selectedBusinessUnitProvider));

/// Minimum password length the app asks for. TODO(business): password policy (PHASE-2-FEATURES §3).
const kMinPasswordLength = 8;

Future<String?> askNewPassword(BuildContext context) {
  final l10n = AppLocalizations.of(context);
  final controller = TextEditingController();
  return showDialog<String>(
    context: context,
    builder: (ctx) => AlertDialog(
      title: Text(l10n.resetPassword),
      content: TextField(
        key: const Key('password.field'),
        controller: controller,
        autofocus: true,
        decoration: InputDecoration(labelText: l10n.newPassword, helperText: l10n.passwordRule(kMinPasswordLength)),
      ),
      actions: [
        TextButton(onPressed: () => Navigator.pop(ctx), child: Text(l10n.cancel)),
        FilledButton(
          key: const Key('password.ok'),
          onPressed: () {
            if (controller.text.length >= kMinPasswordLength) Navigator.pop(ctx, controller.text);
          },
          child: Text(l10n.save),
        ),
      ],
    ),
  );
}

class UsersScreen extends ConsumerStatefulWidget {
  const UsersScreen({super.key});

  @override
  ConsumerState<UsersScreen> createState() => _UsersScreenState();
}

class _UsersScreenState extends ConsumerState<UsersScreen> {
  String _q = '';
  Timer? _debounce;

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final users = ref.watch(usersProvider(_q));
    return Scaffold(
      appBar: AppBar(title: Text(l10n.navUsers), actions: const [BusinessUnitSwitcher()]),
      floatingActionButton: FloatingActionButton.extended(
        key: const Key('users.new'),
        onPressed: () => context.push(Routes.newUser),
        icon: const Icon(Icons.person_add_alt),
        label: Text(l10n.newUser),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: TextField(
              key: const Key('users.search'),
              decoration: InputDecoration(prefixIcon: const Icon(Icons.search), hintText: l10n.employeesSearchHint, border: const OutlineInputBorder()),
              onChanged: (v) {
                _debounce?.cancel();
                _debounce = Timer(const Duration(milliseconds: 300), () => setState(() => _q = v.trim()));
              },
            ),
          ),
          Expanded(
            child: RefreshIndicator(
              onRefresh: () => ref.refreshFuture(usersProvider(_q).future),
              child: AsyncView(
                value: users,
                onRetry: () => ref.invalidate(usersProvider(_q)),
                data: (list) => list.items.isEmpty
                    ? ListView(
                        children: [EmptyState(icon: Icons.manage_accounts_outlined, message: l10n.employeesEmpty)],
                      )
                    : ListView.separated(
                        padding: const EdgeInsets.only(bottom: 88),
                        itemCount: list.items.length,
                        separatorBuilder: (_, _) => const Divider(height: 1),
                        itemBuilder: (context, i) => _UserTile(user: list.items[i], q: _q),
                      ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _UserTile extends ConsumerWidget {
  const _UserTile({required this.user, required this.q});

  final UserItem user;
  final String q;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final u = user;
    final locked = u.lockedUntil != null && u.lockedUntil!.isAfter(DateTime.now());
    final repo = ref.read(usersRepositoryProvider);

    Future<void> run(Future<Object?> Function() action, String done) async {
      try {
        await action();
        ref.invalidate(usersProvider(q));
        if (context.mounted) showMessage(context, done);
      } catch (e) {
        if (context.mounted) showFailure(context, e);
      }
    }

    return ListTile(
      key: Key('user.${u.id}'),
      title: Text('${u.name} (${u.empCode})'),
      subtitle: Text(
        [
          l10n.apiRole(u.role),
          u.businessUnits.map((b) => b.isPrimary ? '${b.code}*' : b.code).join(', '),
          if (u.reportingTo != null) l10n.reportsTo(u.reportingTo!.name),
          if (u.lastLoginAt != null) l10n.lastLogin(formatDateTime(u.lastLoginAt!)),
        ].where((s) => s.isNotEmpty).join(' · '),
      ),
      isThreeLine: true,
      leading: !u.isActive
          ? StatusChip(label: l10n.inactive, tone: Tone.neutral)
          : locked
          ? StatusChip(label: l10n.locked, tone: Tone.bad, icon: Icons.lock)
          : null,
      trailing: PopupMenuButton<String>(
        key: Key('user.menu.${u.id}'),
        onSelected: (action) async {
          switch (action) {
            case 'reset':
              final pw = await askNewPassword(context);
              if (pw != null) await run(() => repo.resetPassword(u.id, pw), l10n.passwordReset);
            case 'unlock':
              await run(() => repo.unlock(u.id), l10n.unlocked);
            case 'toggle':
              await run(() => repo.setActive(u.id, !u.isActive), u.isActive ? l10n.deactivated : l10n.activated);
          }
        },
        itemBuilder: (_) => [
          PopupMenuItem(value: 'reset', key: const Key('user.reset'), child: Text(l10n.resetPassword)),
          if (locked) PopupMenuItem(value: 'unlock', key: const Key('user.unlock'), child: Text(l10n.unlock)),
          PopupMenuItem(value: 'toggle', child: Text(u.isActive ? l10n.deactivate : l10n.activate)),
        ],
      ),
    );
  }
}
