import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../features/auth/domain/current_user.dart';
import '../features/auth/presentation/login_screen.dart' show CompanyLogo;
import 'destinations.dart';
import 'l10n/app_localizations.dart';

/// Width at which the shell switches from bottom navigation to a navigation rail
/// (and screens may show list + detail side by side).
const double kWideLayoutBreakpoint = 840;

/// The per-role app shell: bottom navigation on phones, navigation rail on tablets.
class AppShell extends StatelessWidget {
  const AppShell({super.key, required this.user, required this.location, required this.child});

  final CurrentUser user;
  final String location;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final destinations = destinationsFor(user.role);
    final index = destinations.indexWhere((d) => location.startsWith(d.path));
    // Screens opened from the More menu keep "More" highlighted.
    final selected = index >= 0 ? index : (location.startsWith(AppDestination.home.path) ? 0 : destinations.length - 1);
    void onSelect(int i) => context.go(destinations[i].path);

    final wide = MediaQuery.sizeOf(context).width >= kWideLayoutBreakpoint;
    if (wide) {
      return Scaffold(
        body: Row(
          children: [
            NavigationRail(
              key: const Key('shell.rail'),
              selectedIndex: selected,
              onDestinationSelected: onSelect,
              labelType: NavigationRailLabelType.all,
              leading: const Padding(padding: EdgeInsets.symmetric(vertical: 12), child: CompanyLogo(size: 40)),
              destinations: [
                for (final d in destinations) NavigationRailDestination(icon: Icon(d.icon), selectedIcon: Icon(d.selectedIcon), label: Text(d.label(l10n))),
              ],
            ),
            const VerticalDivider(width: 1),
            Expanded(child: child),
          ],
        ),
      );
    }
    return Scaffold(
      body: child,
      bottomNavigationBar: NavigationBar(
        key: const Key('shell.bottomNav'),
        selectedIndex: selected,
        onDestinationSelected: onSelect,
        destinations: [for (final d in destinations) NavigationDestination(icon: Icon(d.icon), selectedIcon: Icon(d.selectedIcon), label: d.label(l10n))],
      ),
    );
  }
}
