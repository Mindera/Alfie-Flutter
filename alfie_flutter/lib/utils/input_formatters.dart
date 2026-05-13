import 'package:flutter/services.dart';

/// A [TextInputFormatter] that automatically inserts a forward slash (`/`)
/// after the second character to format a credit card expiry date (MM/YY).
class CardMonthInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    var newText = newValue.text;

    if (newValue.selection.baseOffset == 0) {
      return newValue;
    }

    var buffer = StringBuffer();
    for (int i = 0; i < newText.length; i++) {
      buffer.write(newText[i]);
      var nonZeroIndex = i + 1;
      if (nonZeroIndex % 2 == 0 && nonZeroIndex != newText.length) {
        buffer.write('/');
      }
    }

    var string = buffer.toString();
    return newValue.copyWith(
      text: string,
      selection: TextSelection.collapsed(offset: string.length),
    );
  }
}

/// A [TextInputFormatter] that automatically inserts double spaces after every
/// four digits to enhance the readability of credit card numbers.
class CardNumberInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    var text = newValue.text;

    if (newValue.selection.baseOffset == 0) {
      return newValue;
    }

    var string = formatCardNumber(text);
    return newValue.copyWith(
      text: string,
      selection: TextSelection.collapsed(offset: string.length),
    );
  }

  /// Injects double spaces into a raw string [text] at 4-character intervals.
  static String formatCardNumber(String text) {
    final buffer = StringBuffer();

    for (int i = 0; i < text.length; i++) {
      buffer.write(text[i]);
      final index = i + 1;

      if (index % 4 == 0 && index != text.length) {
        buffer.write('  '); // double spaces
      }
    }

    return buffer.toString();
  }
}
