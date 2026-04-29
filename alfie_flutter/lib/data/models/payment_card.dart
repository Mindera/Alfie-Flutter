import 'package:alfie_flutter/data/models/payment_card_type.dart';
import 'package:alfie_flutter/utils/input_formatters.dart';

class PaymentCard {
  static const PaymentCard sample = PaymentCard(
    type: PaymentCardType.visa,
    number: '4111111111111111',
    name: 'John Doe',
    month: 12,
    year: 2030,
    cvv: 123,
  );
  static const PaymentCard invalid = PaymentCard(
    type: PaymentCardType.invalid,
    number: '',
    name: '',
    month: 0,
    year: 0,
    cvv: 0,
  );

  final PaymentCardType type;
  final String number;
  final String name;
  final int month;
  final int year;
  final int cvv;

  const PaymentCard({
    required this.type,
    required this.number,
    required this.name,
    required this.month,
    required this.year,
    required this.cvv,
  });

  String displayString() {
    final obscuredNumber = CardNumberInputFormatter.formatCardNumber(
      "${"*" * 4}${number.substring(number.length - 4)}",
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

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is PaymentCard &&
        other.type == type &&
        other.number == number &&
        other.name == name &&
        other.month == month &&
        other.year == year &&
        other.cvv == cvv;
  }

  @override
  int get hashCode {
    return Object.hash(type, number, name, month, year, cvv);
  }
}
