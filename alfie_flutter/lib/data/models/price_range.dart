import 'package:alfie_flutter/data/models/money.dart';

/// Represents a range of prices.
///
/// Contains a minimum price and an optional maximum price.
/// When [high] is null, the range represents a 'from' price range (from the [low] price).
final class PriceRange {
  /// The minimum price in the range.
  final Money low;

  /// The maximum price in the range, if not a 'from' range.
  final Money? high;

  /// Creates a new [PriceRange] instance.
  PriceRange({required this.low, this.high});
}
