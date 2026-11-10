import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:hrms_api/hrms_api.dart';

import '../../../app/l10n/app_localizations.dart';
import '../../../app/router.dart';
import '../../../core/format.dart';
import '../../../core/labels.dart';
import '../../../core/session.dart';
import '../../../core/widgets/async_view.dart';
import '../../../core/widgets/status_chip.dart';
import '../../home/presentation/providers/dashboard_provider.dart';
import '../data/attendance_repository.dart';
import 'attendance_screen.dart';

const kSelfStatuses = [
  SelfMarkBodyStatusEnum.PRESENT,
  SelfMarkBodyStatusEnum.HALF_DAY,
  SelfMarkBodyStatusEnum.ON_DUTY,
  SelfMarkBodyStatusEnum.WEEKLY_OFF,
  SelfMarkBodyStatusEnum.HOLIDAY,
  SelfMarkBodyStatusEnum.ABSENT,
];

AttendanceStatus _asStatus(SelfMarkBodyStatusEnum s) => AttendanceStatus.values.firstWhere((a) => a.value == s.value);

/// Self-marking (§4.2): today's status goes to my reporting manager for approval; history below.
/// Leave is raised from Leave & OD, not here.
class SelfAttendanceTab extends ConsumerStatefulWidget {
  const SelfAttendanceTab({super.key});

  @override
  ConsumerState<SelfAttendanceTab> createState() => _SelfAttendanceTabState();
}

class _SelfAttendanceTabState extends ConsumerState<SelfAttendanceTab> {
  SelfMarkBodyStatusEnum _status = SelfMarkBodyStatusEnum.PRESENT;
  final _note = TextEditingController();
  bool _saving = false;

  @override
  void dispose() {
    _note.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    final l10n = AppLocalizations.of(context);
    setState(() => _saving = true);
    try {
      await ref.read(attendanceRepositoryProvider).markSelf(todayIso(), _status, note: _note.text.trim().isEmpty ? null : _note.text.trim());
      ref.invalidate(myAttendanceProvider);
      ref.invalidate(dashboardProvider);
      if (mounted) showMessage(context, l10n.selfMarkSent);
    } catch (e) {
      if (mounted) showFailure(context, e);
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final user = ref.watch(currentUserProvider);
    final marks = ref.watch(myAttendanceProvider);
    final today = todayIso();
    return RefreshIndicator(
      onRefresh: () => ref.refreshFuture(myAttendanceProvider.future),
      child: AsyncView(
        value: marks,
        onRetry: () => ref.invalidate(myAttendanceProvider),
        data: (items) {
          final todayMark = items.where((m) => m.date == today).firstOrNull;
          final canMark = todayMark == null || todayMark.approvalState == ApprovalState.REJECTED;
          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              Card(
                key: const Key('self.today'),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(l10n.todayDate(formatDate(today)), style: theme.textTheme.titleMedium),
                      if (user?.reportingToName != null) Text(l10n.approvedBy(user!.reportingToName!), style: theme.textTheme.bodySmall),
                      const SizedBox(height: 12),
                      if (todayMark != null) ...[
                        Row(
                          children: [
                            Text(l10n.attendanceStatus(todayMark.status), style: theme.textTheme.titleLarge),
                            const SizedBox(width: 8),
                            StatusChip(label: l10n.approvalState(todayMark.approvalState), tone: approvalStateTone(todayMark.approvalState)),
                          ],
                        ),
                        if (todayMark.rejectionReason != null)
                          Text(l10n.rejectedBecause(todayMark.rejectionReason!), style: TextStyle(color: theme.colorScheme.error)),
                        const SizedBox(height: 12),
                      ],
                      if (canMark) ...[
                        Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: [
                            for (final s in kSelfStatuses)
                              ChoiceChip(
                                key: Key('self.${s.value}'),
                                label: Text(l10n.attendanceStatus(_asStatus(s))),
                                selected: _status == s,
                                onSelected: (_) => setState(() => _status = s),
                              ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        TextField(
                          controller: _note,
                          decoration: InputDecoration(labelText: '${l10n.comment} (${l10n.optional})', border: const OutlineInputBorder()),
                        ),
                        const SizedBox(height: 12),
                        FilledButton.icon(
                          key: const Key('self.submit'),
                          onPressed: _saving ? null : _submit,
                          icon: const Icon(Icons.send_outlined),
                          label: Text(l10n.submitForApproval),
                        ),
                      ],
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Text(l10n.last31Days, style: theme.textTheme.titleSmall),
              if (items.isEmpty) Padding(padding: const EdgeInsets.all(16), child: Text(l10n.noMarksYet)),
              for (final m in items.where((m) => m.date != today))
                ListTile(
                  key: Key('self.history.${m.date}'),
                  title: Text('${formatDate(m.date)} · ${l10n.attendanceStatus(m.status)}'),
                  subtitle: m.rejectionReason != null ? Text(l10n.rejectedBecause(m.rejectionReason!)) : null,
                  trailing: StatusChip(label: l10n.approvalState(m.approvalState), tone: approvalStateTone(m.approvalState)),
                  onLongPress: () => context.push(
                    Uri(
                      path: Routes.newCorrection,
                      queryParameters: {'employeeId': m.employee.id, 'employeeName': m.employee.fullName, 'date': m.date},
                    ).toString(),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}
