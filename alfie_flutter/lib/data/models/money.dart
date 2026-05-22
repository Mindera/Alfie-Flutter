/// Represents a monetary value with currency information.
class Money {
  /// 3-letter currency code (e.g., "USD", "EUR").
  final String currencyCode;

  /// The raw numeric amount value.
  final double amount;

  /// Pre-formatted string representation of the monetary value (e.g., "$20.00").
  final String formatted;

  const Money({
    required this.currencyCode,
    required this.amount,
    required this.formatted,
  });
}
