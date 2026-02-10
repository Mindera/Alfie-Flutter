/// Represents a monetary value with currency information.
///
/// Contains the currency code, numeric amount, and a pre-formatted string
/// representation suitable for display in the UI.
final class Money {
  /// 3-letter currency code (e.g., "USD", "EUR").
  final String currencyCode;

  /// The numeric amount value.
  final double amount;

  /// Pre-formatted string representation of the monetary value,
  /// including currency symbol and locale-specific formatting.
  final String formatted;

  /// Creates a new [Money] instance.
  Money({
    required this.currencyCode,
    required this.amount,
    required this.formatted,
  });
}
