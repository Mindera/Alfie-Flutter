import 'package:alfie_flutter/data/models/money.dart';

/// Represents a variable pricing tier for a product.
///
/// When [high] is null, this represents an open-ended "from [low]" pricing structure.
class PriceRange {
  /// The minimum required price boundary.
  final Money low;

  /// The maximum price boundary. If null, the range is unbounded upwards.
  final Money? high;

  const PriceRange({required this.low, this.high});
}
