import 'package:alfie_flutter/data/models/payment_card_type.dart';
import 'package:alfie_flutter/utils/input_formatters.dart';

class PaymentCard {
  static PaymentCard sample = PaymentCard(
    type: PaymentCardType.visa,
    number: '4111111111111111',
    name: 'John Doe',
    month: 12,
    year: 2030,
    cvv: 123,
  );

  PaymentCardType type;
  String number;
  String name;
  int month;
  int year;
  int cvv;

  PaymentCard({
    required this.type,
    required this.number,
    required this.name,
    required this.month,
    required this.year,
    required this.cvv,
  });

  String displayString() {
    final obscuredNumber = CardNumberInputFormatter.formatCardNumber(
      "${"*" * (number.length - 4)}${number.substring(number.length - 4)}",
    );

    return "$type $obscuredNumber";
  }

  @override
  String toString() {
    return '[Type: $type, Number: $number, Name: $name, Month: $month, Year: $year, CVV: $cvv]';
  }

  PaymentCard copyWith({
    PaymentCardType? type,
    String? number,
    String? name,
    int? month,
    int? year,
    int? cvv,
  }) {
    return PaymentCard(
      type: type ?? this.type,
      number: number ?? this.number,
      name: name ?? this.name,
      month: month ?? this.month,
      year: year ?? this.year,
      cvv: cvv ?? this.cvv,
    );
  }
}
