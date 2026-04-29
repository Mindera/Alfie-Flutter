import 'package:alfie_flutter/utils/string_utils.dart';

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
