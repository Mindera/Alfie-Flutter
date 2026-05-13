import 'package:alfie_flutter/data/models/media.dart';
import 'package:alfie_flutter/data/models/price.dart';

/// Aggregates search autocomplete results categorized by match type.
///
/// Contains collections of [brands], [keywords], and [products] to help users
/// rapidly refine their search intent before execution.
final class Suggestion {
  final List<SuggestionBrand> brands;
  final List<SuggestionKeyword> keywords;
  final List<SuggestionProduct> products;

  const Suggestion({
    required this.brands,
    required this.keywords,
    required this.products,
  });
}

/// Represents an auto-complete brand match and its associated inventory count.
final class SuggestionBrand {
  /// The matched brand name.
  final String value;

  /// The total number of available products associated with this brand.
  final int results;

  const SuggestionBrand({required this.value, required this.results});
}

/// Represents an auto-complete keyword match and its associated inventory count.
final class SuggestionKeyword {
  /// The matched keyword or search term.
  final String value;

  /// The total number of available products matching this keyword.
  final int results;

  const SuggestionKeyword({required this.value, required this.results});
}

/// Represents a lightweight product preview optimized for search auto-complete dropdowns.
///
/// Contains a stripped-down subset of product data, prioritizing [media]
/// and [price] for immediate visual recognition.
final class SuggestionProduct {
  final String id;
  final String name;
  final String brandName;

  /// Preview assets intended for thumbnail display.
  final List<Media> media;

  final Price price;

  const SuggestionProduct({
    required this.id,
    required this.name,
    required this.brandName,
    required this.media,
    required this.price,
  });
}
