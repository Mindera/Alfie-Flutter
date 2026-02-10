import 'package:alfie_flutter/data/models/money.dart';

/// Represents a product price with optional discount information.
///
/// Contains the current price and an optional previous price used to display
/// discounts or promotional pricing (e.g., "was $10, now $8").
final class Price {
  /// The current selling price.
  final Money amount;

  /// The previous price before a discount, or null if no discount is applied.
  final Money? previousAmount;

  /// Creates a new [Price] instance.
  Price({required this.amount, this.previousAmount});
}
