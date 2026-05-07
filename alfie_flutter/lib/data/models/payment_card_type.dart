import 'package:alfie_flutter/utils/string_utils.dart';

/// Defines the supported credit and debit card payment networks.
enum PaymentCardType {
  master,
  visa,
  verve,
  discover,
  americanExpress,
  dinersClub,
  jcb,
  others,
  invalid;

  @override
  String toString() {
    return name.capitalize();
  }
}
