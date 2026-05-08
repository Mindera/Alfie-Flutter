/// A unique identifier for a product listing state.
///
/// Used to distinguish between different product feeds, such as those
/// filtered by [categoryId], [query], or a combination of both.
class ProductListingId {
  final String? categoryId;
  final String? query;

  const ProductListingId({this.categoryId, this.query});

  /// Derives a deterministic string key representing the listing parameters.
  ///
  /// Utilized primarily for cache identification and provider isolation.
  String get id {
    final String categoryPart = categoryId != null ? '$categoryId-' : '';
    final String searchPart = query != null ? '$query' : '';
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
