import 'package:alfie_flutter/data/models/payment_card_type.dart';

class PaymentCard {
  PaymentCardType? type;
  String? number;
  String? name;
  int? month;
  int? year;
  int? cvv;

  PaymentCard({
    this.type,
    this.number,
    this.name,
    this.month,
    this.year,
    this.cvv,
  });

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
