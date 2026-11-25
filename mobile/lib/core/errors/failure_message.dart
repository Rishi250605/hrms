import 'package:flutter/widgets.dart';

import '../../app/l10n/app_localizations.dart';
import 'api_failure.dart';

/// User-facing text for a failure. Server messages are shown as-is for now (English);
/// TODO(l10n): map well-known error codes to ARB strings when Hindi/Tamil are added.
String failureMessage(BuildContext context, ApiFailure failure) {
  final l10n = AppLocalizations.of(context);
  if (failure.isNetwork) return l10n.errorNetwork;
  if (failure.code == ApiFailure.unknownError) return l10n.errorUnknown;
  if (failure.code == 'VALIDATION_ERROR' && failure.details is List) {
    // Name the fields the server rejected, e.g. "depotId: A base depot is required".
    final issues = [
      for (final i in (failure.details as List).whereType<Map<String, dynamic>>().take(3))
        [if (i['path'] is List && (i['path'] as List).isNotEmpty) (i['path'] as List).join('.'), if (i['message'] != null) i['message']].join(': '),
    ].where((t) => t.isNotEmpty);
    if (issues.isNotEmpty) return '${failure.message} — ${issues.join('; ')}';
  }
  return failure.message;
}
