import 'package:alfie_flutter/data/models/media.dart';

/// Represents a color variant of a product.
///
/// Contains color identification, a visual swatch for display,
/// and optional media assets (images or videos) showing the product in this color.
final class ProductColor {
  /// The unique identifier for this color variant.
  final String id;

  /// The display name of the color (e.g., "Navy Blue", "Red").
  final String name;

  /// Image resolver for the colour swatch.
  final MediaImage? swatch;

  /// A list of media assets (images/videos) showing the product in this color.
  final List<Media>? media;

  /// Creates a new [ProductColor] instance.
  ProductColor({required this.id, required this.name, this.swatch, this.media});
}
