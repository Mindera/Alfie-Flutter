/// A unique identifier for a product listing state.
///
/// Used to distinguish between different product feeds, such as those
/// filtered by category, search query, or a combination of both.
class ProductListingId {
  final String? categoryId;
  final String? query;

  ProductListingId({this.categoryId, this.query});

  /// Generates a unique string representation of the listing.
  String get id {
    String categoryPart = categoryId != null ? '$categoryId-' : '';
    String searchPart = query != null ? '$query' : '';
    return '$categoryPart$searchPart';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ProductListingId &&
        other.categoryId == categoryId &&
        other.query == query;
  }

  @override
  int get hashCode {
    return Object.hash(categoryId, query);
  }
}
