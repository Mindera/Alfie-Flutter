import 'package:alfie_flutter/data/models/media.dart';
import 'package:alfie_flutter/data/models/price.dart';

/// Represents search suggestions grouped by type.
///
/// Contains brand suggestions, keyword suggestions, and product suggestions
/// to help users refine their search or discover relevant items.
final class Suggestion {
  /// A list of brand suggestions matching the search query.
  final List<SuggestionBrand> brands;

  /// A list of keyword suggestions matching the search query.
  final List<SuggestionKeyword> keywords;

  /// A list of product suggestions matching the search query.
  final List<SuggestionProduct> products;

  /// Creates a new [Suggestion] instance.
  Suggestion({
    required this.brands,
    required this.keywords,
    required this.products,
  });
}

/// Represents a brand suggestion with result count.
final class SuggestionBrand {
  /// The brand name or value.
  final String value;

  /// The number of products available for this brand that match the search query.
  final int results;

  /// Creates a new [SuggestionBrand] instance.
  SuggestionBrand({required this.value, required this.results});
}

/// Represents a keyword suggestion with result count.
final class SuggestionKeyword {
  /// The keyword or search term.
  final String value;

  /// The number of products matching this keyword.
  final int results;

  /// Creates a new [SuggestionKeyword] instance.
  SuggestionKeyword({required this.value, required this.results});
}

/// Represents a product suggestion with essential product information.
///
/// Contains a subset of product data optimized for display in search suggestions,
/// including media and pricing for quick preview.
final class SuggestionProduct {
  /// The unique identifier for this product.
  final String id;

  /// The name of the product.
  final String name;

  /// The name of the brand that manufactures or sells this product.
  final String brandName;

  /// Media assets (images/videos) for previewing the product.
  final List<Media> media;

  /// The pricing information for this product.
  final Price price;

  /// Creates a new [SuggestionProduct] instance.
  SuggestionProduct({
    required this.id,
    required this.name,
    required this.brandName,
    required this.media,
    required this.price,
  });
}
