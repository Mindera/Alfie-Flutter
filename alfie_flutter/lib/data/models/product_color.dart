import 'package:alfie_flutter/data/models/media.dart';

/// Represents a specific color variant of a product.
class ProductColor {
  /// The unique identifier for this color variant.
  final String id;

  /// The presentation name of the color (e.g., "Navy Blue").
  final String name;

  /// A visual thumbnail representation of this color variant.
  final MediaImage? swatch;

  /// A collection of [Media] assets showcasing the product in this specific color.
  final List<Media>? media;

  const ProductColor({
    required this.id,
    required this.name,
    this.swatch,
    this.media,
  });
}
