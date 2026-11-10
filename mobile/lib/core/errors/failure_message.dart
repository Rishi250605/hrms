import 'package:flutter/widgets.dart';

import '../../app/l10n/app_localizations.dart';
import 'api_failure.dart';

/// User-facing text for a failure. Server messages are shown as-is for now (English);
/// TODO(l10n): map well-known error codes to ARB strings when Hindi/Tamil are added.
String failureMessage(BuildContext context, ApiFailure failure) {
  final l10n = AppLocalizations.of(context);
  if (failure.isNetwork) return l10n.errorNetwork;
  if (failure.code == ApiFailure.unknownError) return l10n.errorUnknown;
  return failure.message;
}
