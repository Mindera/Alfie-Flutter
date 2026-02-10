/// Represents a size option for a product.
///
/// A size can belong to a size guide for standardized sizing across a collection,
/// and may include scale information (e.g., EU, US) and additional descriptions.
final class ProductSize {
  /// The unique identifier for this size.
  final String id;

  /// The size value (e.g., "M", "10", "42").
  final String value;

  /// The sizing scale or standard this size follows (e.g., "US", "EU", "UK"),
  /// or null if the size is not part of a specific scale system.
  final String? scale;

  /// Additional information about this size, or null if not applicable.
  final String? description;

  /// The size guide this size belongs to, providing context and comparison
  /// with other sizes in the same standard, or null if no guide is available.
  final SizeGuide? sizeGuide;

  /// Creates a new [ProductSize] instance.
  ProductSize({
    required this.id,
    required this.value,
    this.scale,
    this.description,
    this.sizeGuide,
  });
}

/// Represents a standardized size guide for a collection of sizes.
///
/// Groups related sizes (e.g., all sizes in the EU standard) to help
/// customers understand size relationships and make informed choices.
final class SizeGuide {
  /// The unique identifier for this size guide.
  final String id;

  /// The display name of the size guide (e.g., "European Sizes", "US Standard").
  final String name;

  /// Additional information about this size guide (e.g., measurement instructions),
  /// or null if not applicable.
  final String? description;

  /// The list of sizes defined by this size guide.
  final List<ProductSize> sizes;

  /// Creates a new [SizeGuide] instance.
  SizeGuide({
    required this.id,
    required this.name,
    this.description,
    required this.sizes,
  });
}
