enum DeliveryMethod {
  standard(
    label: "Standard Delivery",
    price: "FREE",
    details: "(Estimated shipping 3-5 working days)",
  ),
  express(
    label: "Express",
    price: r"$20.00",
    details: "(Estimated shipping 1-3 working days)",
  );

  final String label;
  final String price;
  final String details;

  const DeliveryMethod({
    required this.label,
    required this.price,
    required this.details,
  });

  String get description => "$price\n$details";
  @override
  String toString() {
    return "$label - $price $details";
  }
}
