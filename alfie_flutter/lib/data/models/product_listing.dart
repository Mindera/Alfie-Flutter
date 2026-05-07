import 'package:alfie_flutter/data/models/pagination.dart';
import 'package:alfie_flutter/data/models/product.dart';

/// Represents a paginated collection of [Product] items with navigation metadata.
class ProductListing {
  /// The contextual title for this specific listing or category.
  final String title;

  /// State and boundaries for navigating the result set.
  final Pagination pagination;

  /// The collection of products within the current page.
  final List<Product> products;

  const ProductListing({
    required this.title,
    required this.pagination,
    required this.products,
  });
}

/// Defines the sorting behavior applied to a [ProductListing].
enum ProductListingSort {
  lowToHigh,
  highToLow,
  aToZ,
  zToA,

  /// Fallback state when the sorting preference is unrecognized or unassigned.
  unknown,
}
