import 'package:alfie_flutter/data/models/price.dart';
import 'package:alfie_flutter/data/models/size.dart';

/// Represents a purchasable configuration of a product.
///
/// Variants are distinct physical items derived from a base product,
/// each tracking its own inventory, pricing, and specific attributes.
class ProductVariant {
  /// The Stock Keeping Unit uniquely identifying this physical configuration.
  final String sku;

  /// The physical dimensions or fit standard.
  final ProductSize? size;

  /// The identifier linking to the associated color variant.
  final String? colorId;

  /// Additional dynamic specifications unique to this variant.
  final Map<String, String>? attributes;

  /// The current inventory count available for purchase.
  final int stock;

  /// The absolute pricing state for this specific variant.
  final Price price;

  const ProductVariant({
    required this.sku,
    this.size,
    this.colorId,
    this.attributes,
    required this.stock,
    required this.price,
  });
}
