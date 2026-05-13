/// Represents a discrete sizing standard for a variant.
class ProductSize {
  final String id;

  /// The readable size designation (e.g., "M", "10", "42").
  final String value;

  /// The geographical or standard scale system this size adheres to (e.g., "US", "EU").
  final String? scale;

  /// Supplementary details regarding the fit or measurement.
  final String? description;

  /// The parent [SizeGuide] defining the broader sizing context for this item.
  final SizeGuide? sizeGuide;

  const ProductSize({
    required this.id,
    required this.value,
    this.scale,
    this.description,
    this.sizeGuide,
  });
}

/// Represents a standardized classification grouping related [ProductSize] entities.
class SizeGuide {
  final String id;

  /// The display name for the measurement standard (e.g., "European Sizes").
  final String name;

  /// Contextual instructions or measurement methodologies for this guide.
  final String? description;

  /// The collection of individual sizes bounded by this guide.
  final List<ProductSize> sizes;

  const SizeGuide({
    required this.id,
    required this.name,
    this.description,
    required this.sizes,
  });
}
