import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:hrms_api/hrms_api.dart';

import '../../../app/l10n/app_localizations.dart';
import '../../../app/role_shell.dart';
import '../../../app/router.dart';
import '../../../core/labels.dart';
import '../../../core/session.dart';
import '../../../core/widgets/async_view.dart';
import '../../../core/widgets/status_chip.dart';
import '../../auth/domain/current_user.dart';
import 'employee_profile_screen.dart';
import 'providers/employees_providers.dart';

/// Employee list with search and compliance filter. On tablets the profile opens beside the list.
class EmployeesScreen extends ConsumerStatefulWidget {
  const EmployeesScreen({super.key});

  @override
  ConsumerState<EmployeesScreen> createState() => _EmployeesScreenState();
}

class _EmployeesScreenState extends ConsumerState<EmployeesScreen> {
  String? _selectedId;
  Timer? _debounce;

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final user = ref.watch(currentUserProvider);
    final wide = MediaQuery.sizeOf(context).width >= kWideLayoutBreakpoint;
    final filter = ref.watch(employeeFilterControllerProvider);
    final list = ref.watch(employeeListProvider);

    void open(String id) {
      if (wide) {
        setState(() => _selectedId = id);
      } else {
        context.push(Routes.employee(id));
      }
    }

    final listPane = Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(12, 8, 12, 4),
          child: TextField(
            key: const Key('employees.search'),
            decoration: InputDecoration(prefixIcon: const Icon(Icons.search), hintText: l10n.employeesSearchHint, isDense: true),
            onChanged: (v) {
              _debounce?.cancel();
              _debounce = Timer(const Duration(milliseconds: 350), () => ref.read(employeeFilterControllerProvider.notifier).search(v));
            },
          ),
        ),
        SizedBox(
          height: 44,
          child: ListView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 12),
            children: [
              for (final c in [null, ComplianceOverall.MISSING, ComplianceOverall.EXPIRED, ComplianceOverall.EXPIRING, ComplianceOverall.PENDING_VERIFICATION])
                Padding(
                  padding: const EdgeInsets.only(right: 6),
                  child: ChoiceChip(
                    label: Text(c == null ? l10n.filterAll : l10n.compliance(c)),
                    selected: filter.compliance == c,
                    onSelected: (_) => ref.read(employeeFilterControllerProvider.notifier).compliance(c),
                  ),
                ),
            ],
          ),
        ),
        Expanded(
          child: RefreshIndicator(
            onRefresh: () => ref.refreshFuture(employeeListProvider.future),
            child: AsyncView(
              value: list,
              onRetry: () => ref.invalidate(employeeListProvider),
              data: (state) => state.items.isEmpty
                  ? ListView(
                      children: [EmptyState(icon: Icons.badge_outlined, message: l10n.employeesEmpty)],
                    )
                  : NotificationListener<ScrollNotification>(
                      onNotification: (n) {
                        if (n.metrics.extentAfter < 300) ref.read(employeeListProvider.notifier).loadMore();
                        return false;
                      },
                      child: ListView.separated(
                        key: const Key('employees.list'),
                        itemCount: state.items.length + (state.hasMore ? 1 : 0),
                        separatorBuilder: (_, _) => const Divider(height: 1),
                        itemBuilder: (context, i) {
                          if (i >= state.items.length) {
                            return const Padding(
                              padding: EdgeInsets.all(16),
                              child: Center(child: CircularProgressIndicator()),
                            );
                          }
                          final e = state.items[i];
                          return EmployeeTile(employee: e, selected: wide && e.id == _selectedId, onTap: () => open(e.id));
                        },
                      ),
                    ),
            ),
          ),
        ),
      ],
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.navEmployees),
        actions: [
          if (user?.role == UserRole.hr)
            IconButton(
              key: const Key('employees.add'),
              tooltip: l10n.onboardTitle,
              icon: const Icon(Icons.person_add_alt_1),
              onPressed: () => context.push(Routes.newEmployee),
            ),
        ],
      ),
      body: wide
          ? Row(
              children: [
                SizedBox(width: 380, child: listPane),
                const VerticalDivider(width: 1),
                Expanded(
                  child: _selectedId == null
                      ? EmptyState(icon: Icons.person_search_outlined, message: l10n.employeesSelectHint)
                      : EmployeeProfileView(key: ValueKey(_selectedId), employeeId: _selectedId!),
                ),
              ],
            )
          : listPane,
    );
  }
}

class EmployeeTile extends StatelessWidget {
  const EmployeeTile({super.key, required this.employee, this.onTap, this.selected = false, this.trailing});

  final EmployeeListItem employee;
  final VoidCallback? onTap;
  final bool selected;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final e = employee;
    return ListTile(
      key: Key('employee.${e.id}'),
      selected: selected,
      onTap: onTap,
      leading: CircleAvatar(child: Text(e.fullName.isEmpty ? '?' : e.fullName[0])),
      title: Text(e.fullName),
      subtitle: Text([e.empCode, l10n.category(e.category), if (e.depot != null) e.depot!.code].join(' · ')),
      trailing: trailing ?? StatusChip(label: l10n.compliance(e.compliance), tone: complianceTone(e.compliance)),
    );
  }
}
