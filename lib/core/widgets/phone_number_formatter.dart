import 'package:flutter/services.dart';

/// Formats a Korean mobile number as the user types: `010-1234-5678`.
/// Strips non-digits, caps at 11 digits, and inserts hyphens (3-4-4).
class PhoneNumberFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    var d = newValue.text.replaceAll(RegExp(r'\D'), '');
    if (d.length > 11) d = d.substring(0, 11);

    final String text;
    if (d.length <= 3) {
      text = d;
    } else if (d.length <= 7) {
      text = '${d.substring(0, 3)}-${d.substring(3)}';
    } else {
      text = '${d.substring(0, 3)}-${d.substring(3, 7)}-${d.substring(7)}';
    }

    return TextEditingValue(
      text: text,
      selection: TextSelection.collapsed(offset: text.length),
    );
  }
}
