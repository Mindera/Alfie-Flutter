import 'package:alfie_flutter/data/models/money.dart';

/// Represents a product's absolute pricing state.
class Price {
  /// The current active selling price.
  final Money amount;

  /// The original price before discounts.
  final Money? previousAmount;

  const Price({required this.amount, this.previousAmount});
}
