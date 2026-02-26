/// Represents a product brand.
///
/// Contains basic information about a brand including its unique identifier
/// and display name.
class Brand {
  /// The unique identifier for this brand.
  final String id;

  /// The display name of the brand.
  final String name;

  /// Creates a new [Brand] instance.
  const Brand({required this.id, required this.name});
}
