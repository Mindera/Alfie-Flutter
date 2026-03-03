class ProductListingId {
  final String? categoryId;
  final String? query;

  ProductListingId({this.categoryId, this.query});

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
