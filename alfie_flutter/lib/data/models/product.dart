import 'package:alfie_flutter/data/models/brand.dart';
import 'package:alfie_flutter/data/models/price_range.dart';
import 'package:alfie_flutter/data/models/product_color.dart';
import 'package:alfie_flutter/data/models/product_variant.dart';

/// Represents a product in the catalog.
///
/// A product is a high-level item with general information (name, description, brand)
/// and multiple variants that differ by size, color, or other attributes.
/// Each variant has its own SKU, pricing, and stock information.
final class Product {
  /// The unique identifier for this product.
  final String id;

  /// A product style or design number used for internal identification and categorization.
  final String styleNumber;

  /// The formal name of the product.
  final String name;

  /// The brand of the product.
  final Brand brand;

  /// The price range for this product across all variants,
  /// or null if pricing information is not available.
  final PriceRange? priceRange;

  /// A brief description of the product.
  final String shortDescription;

  /// A detailed description of the product
  /// or null if no detailed description is available.
  final String? longDescription;

  /// Additional product attributes or specifications
  /// or null if there are no additional attributes.
  final Map<String, String>? attributes;

  /// The default variant selected when first viewing the product detail page.
  final ProductVariant defaultVariant;

  /// All available variants of this product.
  final List<ProductVariant> variants;

  /// Available color options for this product, or null if the product has no color variants.
  final List<ProductColor>? colours;

  /// Creates a new [Product] instance.
  Product({
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
}
