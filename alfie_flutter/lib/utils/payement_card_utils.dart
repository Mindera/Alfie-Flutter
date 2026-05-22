import 'package:alfie_flutter/data/models/payment_card_type.dart';
import 'package:flutter/material.dart';

/// A utility collection for parsing, validating, and formatting credit card inputs.
class PaymentCardUtils {
  /// Validates that a [value] contains a 3 or 4-digit security code.
  static String? validateCVV(String? value) {
    if (value == null || value.isEmpty) {
      return "This field is required";
    }

    if (value.length < 3 || value.length > 4) {
      return "CVV is invalid";
    }
    return null;
  }

  /// Validates a raw string [value] formatted as `MM/YY` or `MM/YYYY` against the current date.
  static String? validateDate(String? value) {
    if (value == null || value.isEmpty) {
      return "This field is required";
    }

    int year;
    int month;

    if (value.contains(RegExp(r'(/)'))) {
      var split = value.split(RegExp(r'(/)'));
      month = int.parse(split[0]);
      year = int.parse(split[1]);
    } else {
      month = int.parse(value);
      year = -1;
    }

    if ((month < 1) || (month > 12)) {
      return 'Expiry month is invalid';
    }

    var fourDigitsYear = convertYearTo4Digits(year);
    if ((fourDigitsYear < 1) || (fourDigitsYear > 2099)) {
      return 'Expiry year is invalid';
    }

    if (!hasDateExpired(month, year)) {
      return "Card has expired";
    }
    return null;
  }

  /// Extrapolates a two-digit year into a four-digit year based on the current century.
  static int convertYearTo4Digits(int year) {
    if (year < 100 && year >= 0) {
      var now = DateTime.now();
      String currentYear = now.year.toString();
      String prefix = currentYear.substring(0, currentYear.length - 2);
      year = int.parse('$prefix${year.toString().padLeft(2, '0')}');
    }
    return year;
  }

  /// Evaluates whether the provided [month] and [year] occur in the past.
  static bool hasDateExpired(int month, int year) {
    return isNotExpired(year, month);
  }

  /// Evaluates whether the provided [month] and [year] denote a future or current date.
  static bool isNotExpired(int year, int month) {
    return !hasYearPassed(year) && !hasMonthPassed(year, month);
  }

  /// Extracts the integer month and year components from an `MM/YY` formatted [value].
  static List<int>? getExpiryDate(String value) {
    var split = value.split(RegExp(r'(/)'));
    if (split.length != 2 || split[1].isEmpty) return null;
    return [int.parse(split[0]), int.parse(split[1])];
  }

  /// Determines if the provided [month] has elapsed relative to the current calendar date.
  static bool hasMonthPassed(int year, int month) {
    var now = DateTime.now();
    return hasYearPassed(year) ||
        convertYearTo4Digits(year) == now.year && (month < now.month + 1);
  }

  /// Determines if the provided [year] has elapsed relative to the current calendar year.
  static bool hasYearPassed(int year) {
    int fourDigitsYear = convertYearTo4Digits(year);
    var now = DateTime.now();
    return fourDigitsYear < now.year;
  }

  /// Strips all non-numeric characters from the provided [text] string.
  static String getCleanedNumber(String text) {
    RegExp regExp = RegExp(r"[^0-9]");
    return text.replaceAll(regExp, '');
  }

  /// Resolves the appropriate brand logo or fallback icon for a given [cardType].
  static Widget getCardIcon(PaymentCardType? cardType) {
    String img = "";
    Icon? icon;
    switch (cardType) {
      case PaymentCardType.master:
        img = 'mastercard.png';
        break;
      case PaymentCardType.visa:
        img = 'visa.png';
        break;
      case PaymentCardType.verve:
        img = 'verve.png';
        break;
      case PaymentCardType.americanExpress:
        img = 'american_express.png';
        break;
      case PaymentCardType.discover:
        img = 'discover.png';
        break;
      case PaymentCardType.dinersClub:
        img = 'dinners_club.png';
        break;
      case PaymentCardType.jcb:
        img = 'jcb.png';
        break;
      case PaymentCardType.others:
        icon = Icon(Icons.credit_card, size: 40.0, color: Colors.grey[600]);
        break;
      default:
        icon = Icon(Icons.warning, size: 40.0, color: Colors.grey[600]);
        break;
    }

    if (img.isNotEmpty) {
      return Image.asset('assets/images/$img', width: 56, fit: BoxFit.contain);
    }
    if (icon != null) return icon;

    return const Icon(Icons.error);
  }

  /// Validates a credit card number using the Luhn Algorithm.
  ///
  /// See: https://en.wikipedia.org/wiki/Luhn_algorithm
  static String? validateCardNumber(String? input) {
    if (input == null || input.isEmpty) {
      return "This field is required";
    }

    input = getCleanedNumber(input);

    if (input.length < 8) {
      return "Card is invalid";
    }

    int sum = 0;
    int length = input.length;
    for (var i = 0; i < length; i++) {
      int digit = int.parse(input[length - i - 1]);

      if (i % 2 == 1) {
        digit *= 2;
      }
      sum += digit > 9 ? (digit - 9) : digit;
    }

    if (sum % 10 == 0) {
      return null;
    }

    return "Card is invalid";
  }

  /// Identifies the major credit card network by inspecting the [input] Issuer Identification Number (IIN).
  static PaymentCardType getCardTypeFrmNumber(String input) {
    PaymentCardType cardType;
    if (input.startsWith(
      RegExp(
        r'((5[1-5])|(222[1-9]|22[3-9][0-9]|2[3-6][0-9]{2}|27[01][0-9]|2720))',
      ),
    )) {
      cardType = PaymentCardType.master;
    } else if (input.startsWith(RegExp(r'[4]'))) {
      cardType = PaymentCardType.visa;
    } else if (input.startsWith(RegExp(r'((506(0|1))|(507(8|9))|(6500))'))) {
      cardType = PaymentCardType.verve;
    } else if (input.startsWith(RegExp(r'((34)|(37))'))) {
      cardType = PaymentCardType.americanExpress;
    } else if (input.startsWith(RegExp(r'((6[45])|(6011))'))) {
      cardType = PaymentCardType.discover;
    } else if (input.startsWith(RegExp(r'((30[0-5])|(3[89])|(36)|(3095))'))) {
      cardType = PaymentCardType.dinersClub;
    } else if (input.startsWith(RegExp(r'(352[89]|35[3-8][0-9])'))) {
      cardType = PaymentCardType.jcb;
    } else if (input.length <= 8) {
      cardType = PaymentCardType.others;
    } else {
      cardType = PaymentCardType.invalid;
    }
    return cardType;
  }
}
