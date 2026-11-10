/// Client-side mirror of the API's phone normalisation (api/src/modules/auth/phone.ts).
/// Accepts a 10-digit Indian mobile number (optionally with 0 / 91 / +91) and returns E.164,
/// or null if the input is not a valid number. The API remains the authority.
String? normalizeIndianMobile(String input) {
  final digits = input.replaceAll(RegExp(r'[\s\-()]'), '');
  final match = RegExp(r'^(?:\+91|91|0)?([6-9]\d{9})$').firstMatch(digits);
  return match == null ? null : '+91${match.group(1)}';
}

/// "+919876543210" → "+91 98765 43210"
String formatIndianMobile(String e164) {
  final m = RegExp(r'^\+91(\d{5})(\d{5})$').firstMatch(e164);
  return m == null ? e164 : '+91 ${m.group(1)} ${m.group(2)}';
}
