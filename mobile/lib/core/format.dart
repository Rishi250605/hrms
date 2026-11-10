import 'package:intl/intl.dart';

/// Business dates travel as 'YYYY-MM-DD' strings (IST calendar dates); the app never shifts them.
String isoDate(DateTime d) => DateFormat('yyyy-MM-dd').format(d);

/// Today's calendar date on the device (managers use the app in India, so this is the IST date).
String todayIso([DateTime? now]) => isoDate(now ?? DateTime.now());

DateTime parseIsoDate(String iso) => DateTime.parse(iso);

String addDaysIso(String iso, int days) {
  final d = parseIsoDate(iso);
  return isoDate(DateTime(d.year, d.month, d.day + days));
}

/// "Mon, 10 Nov" (or "Mon, 10 Nov 2027" outside the current year).
String formatDate(String iso, {DateTime? now}) {
  final d = parseIsoDate(iso);
  final year = (now ?? DateTime.now()).year;
  return DateFormat(d.year == year ? 'EEE, d MMM' : 'EEE, d MMM y').format(d);
}

String formatDateTime(DateTime t) => DateFormat('d MMM, HH:mm').format(t.toLocal());

/// Enum-ish API values (DRIVING_LICENCE) as readable text (Driving licence) — fallback when no ARB label exists.
String humanize(String value) {
  final s = value.replaceAll('_', ' ').toLowerCase();
  return s.isEmpty ? s : s[0].toUpperCase() + s.substring(1);
}

/// Days as "1", "1.5", "2".
String formatDays(num days) => days == days.roundToDouble() ? days.toInt().toString() : days.toString();
