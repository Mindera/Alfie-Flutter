import 'package:alfie_flutter/data/models/brand.dart';
import 'package:alfie_flutter/data/models/price_range.dart';
import 'package:alfie_flutter/data/models/product_color.dart';
import 'package:alfie_flutter/data/models/product_variant.dart';

/// Represents a base catalog item aggregating all of its available configurations.
class Product {
  /// The unique system identifier for this product.
  final String id;

  /// The internal catalog categorization and tracking number.
  final String styleNumber;

  /// The formal display name of the product.
  final String name;

  /// The manufacturer or associated [Brand].
  final Brand brand;

  /// The computed pricing boundaries across all underlying [variants].
  ///
  /// Returns `null` if pricing cannot be determined.
  final PriceRange? priceRange;

  /// A concise summary for listing and preview contexts.
  final String shortDescription;

  /// The comprehensive product details for dedicated viewing contexts.
  final String? longDescription;

  /// Global specifications applying to the product across all variants.
  final Map<String, String>? attributes;

  /// The primary [ProductVariant] selected by default in the UI.
  final ProductVariant defaultVariant;

  /// The complete list of available physical configurations.
  final List<ProductVariant> variants;

  /// The distinct [ProductColor] options available across this product's variants.
  final List<ProductColor>? colours;

  const Product({
    required this.id,
    required this.styleNumber,
    required this.name,
    required this.brand,
    this.priceRange,
    required this.shortDescription,
    this.longDescription,
    this.attributes,
    required this.defaultVariant,
    required this.variants,
    this.colours,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Product && other.id == id;
  }

  @override
  int get hashCode {
    return Object.hash(runtimeType, id);
  }
}
