import 'package:alfie_flutter/data/models/money.dart';

enum DeliveryMethod {
  standard(
    label: "Standard Delivery",
    price: Money(currencyCode: 'USD', amount: 0, formatted: r'FREE'),
    details: "(Estimated shipping 3-5 working days)",
  ),
  express(
    label: "Express",
    price: Money(currencyCode: 'USD', amount: 20, formatted: r'$20.00'),
    details: "(Estimated shipping 1-3 working days)",
  );

  final String label;
  final Money price;
  final String details;

  const DeliveryMethod({
    required this.label,
    required this.price,
    required this.details,
  });

  String get description => "${price.formatted}\n$details";
  @override
  String toString() {
    return "$label - ${price.formatted} $details";
  }
}
