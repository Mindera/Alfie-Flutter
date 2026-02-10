import 'package:alfie_flutter/data/models/price.dart';
import 'package:alfie_flutter/data/models/size.dart';

/// Represents a specific variant of a product.
///
/// A product variant is a distinct combination of attributes (size, color, etc.)
/// that can be purchased separately. Each variant has its own SKU, pricing,
/// and stock information.
final class ProductVariant {
  /// The stock keeping unit (SKU) uniquely identifying this variant.
  final String sku;

  /// Size, if applicable.
  final ProductSize? size;

  /// The identifier of the color for this variant, if applicable.
  final String? colorId;

  /// Additional product attributes specific to this variant
  /// or null if there are no additional attributes.
  final Map<String, String>? attributes;

  /// The current stock quantity available for this variant.
  final int stock;

  /// The pricing information for this variant.
  final Price price;

  /// Creates a new [ProductVariant] instance.
  ProductVariant({
    required this.sku,
    this.size,
    this.colorId,
    this.attributes,
    required this.stock,
    required this.price,
  });
}
