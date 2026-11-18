import 'package:flutter_test/flutter_test.dart';
import 'package:wasla/core/phone.dart';

void main() {
  group('normalizePhone', () {
    test('local Iraqi formats become E.164', () {
      expect(normalizePhone('0770 123 4567'), '+9647701234567');
      expect(normalizePhone('07801234567'), '+9647801234567');
      expect(normalizePhone('0750-123-4567'), '+9647501234567');
      expect(normalizePhone('+964 770 123 4567'), '+9647701234567');
    });

    test('Eastern Arabic and Persian digits are accepted', () {
      expect(normalizePhone('٠٧٧٠١٢٣٤٥٦٧'), '+9647701234567');
      expect(normalizePhone('۰۷۷۰۱۲۳۴۵۶۷'), '+9647701234567');
    });

    test('foreign numbers with a country code work', () {
      expect(normalizePhone('+962 79 123 4567'), '+962791234567');
    });

    test('invalid input returns null', () {
      expect(normalizePhone(''), isNull);
      expect(normalizePhone('12345'), isNull);
      expect(normalizePhone('abc'), isNull);
    });
  });

  test('asciiDigits leaves other characters alone', () {
    expect(asciiDigits('+٩٦٤ 77'), '+964 77');
  });
}
