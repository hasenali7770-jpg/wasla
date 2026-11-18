import 'package:phone_numbers_parser/phone_numbers_parser.dart';

/// Converts Eastern Arabic (٠-٩) and Persian (۰-۹) digits to ASCII. Iraqi
/// keyboards commonly produce them.
String asciiDigits(String input) {
  final b = StringBuffer();
  for (final r in input.runes) {
    if (r >= 0x0660 && r <= 0x0669) {
      b.writeCharCode(0x30 + r - 0x0660);
    } else if (r >= 0x06F0 && r <= 0x06F9) {
      b.writeCharCode(0x30 + r - 0x06F0);
    } else {
      b.writeCharCode(r);
    }
  }
  return b.toString();
}

/// Normalises user input to E.164 (e.g. "0770 123 4567" → "+9647701234567").
/// Numbers without a country code are read as Iraqi. Returns null if the
/// result is not a valid mobile number.
String? normalizePhone(String input) {
  final cleaned = asciiDigits(input).replaceAll(RegExp(r'[\s\-().]'), '');
  if (cleaned.isEmpty) return null;
  try {
    final p = PhoneNumber.parse(cleaned, callerCountry: IsoCode.IQ);
    if (!p.isValid(type: PhoneNumberType.mobile)) return null;
    return '+${p.countryCode}${p.nsn}';
  } catch (_) {
    return null;
  }
}

/// Formats E.164 for display, e.g. "+964 770 123 4567". Always wrap the
/// result in an LTR context inside Arabic text.
String displayPhone(String e164) {
  try {
    final p = PhoneNumber.parse(e164);
    return '+${p.countryCode} ${p.formatNsn()}';
  } catch (_) {
    return e164;
  }
}
