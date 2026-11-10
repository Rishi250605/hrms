import 'package:flutter_test/flutter_test.dart';
import 'package:hrms_app/features/auth/domain/phone.dart';

void main() {
  test('normalises Indian mobile numbers to E.164', () {
    expect(normalizeIndianMobile('9876543210'), '+919876543210');
    expect(normalizeIndianMobile('098765 43210'), '+919876543210');
    expect(normalizeIndianMobile('+91 98765-43210'), '+919876543210');
    expect(normalizeIndianMobile('919876543210'), '+919876543210');
  });

  test('rejects invalid numbers', () {
    for (final input in ['', '12345', '5876543210', '98765432101', 'abcdefghij']) {
      expect(normalizeIndianMobile(input), isNull, reason: input);
    }
  });

  test('formats for display', () {
    expect(formatIndianMobile('+919876543210'), '+91 98765 43210');
    expect(formatIndianMobile('+14155552671'), '+14155552671');
  });
}
