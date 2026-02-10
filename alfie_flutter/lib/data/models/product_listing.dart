import 'package:alfie_flutter/data/models/pagination.dart';
import 'package:alfie_flutter/data/models/product.dart';

/// Represents a paginated list of products with metadata.
///
/// Contains a collection of products, pagination information for navigating
/// through results, and a contextual title for the listing.
final class ProductListing {
  /// The title or context of this product listing.
  final String title;

  /// Pagination information for navigating through the product results.
  final Pagination pagination;

  /// The list of products in this page of results.
  final List<Product> products;

  /// Creates a new [ProductListing] instance.
  ProductListing({
    required this.title,
    required this.pagination,
    required this.products,
  });
}

/// Defines the available sorting options for product listings.
enum ProductListingSort {
  /// Sort by price from lowest to highest.
  lowToHigh,

  /// Sort by price from highest to lowest.
  highToLow,

  /// Sort alphabetically from A to Z.
  aToZ,

  /// Sort alphabetically from Z to A.
  zToA,

  /// Sort by relevance (default).
  relevance,
}
