import 'package:alfie_flutter/data/models/suggestion.dart';
import 'package:alfie_flutter/graphql/extensions/media_mapper.dart';
import 'package:alfie_flutter/graphql/extensions/price_mapper.dart';
import 'package:alfie_flutter/graphql/generated/queries/search/fragments/suggestion_brand_fragment.graphql.dart';
import 'package:alfie_flutter/graphql/generated/queries/search/fragments/suggestion_keyword_fragment.graphql.dart';
import 'package:alfie_flutter/graphql/generated/queries/search/fragments/suggestion_product_fragment.graphql.dart';
import 'package:alfie_flutter/graphql/generated/queries/search/search.graphql.dart';

/// Converts a GraphQL suggestion response into a domain model.
///
/// Maps the nested GraphQL response structure into a clean [Suggestion]
/// domain object by delegating to specialized mappers for each suggestion type.
extension SuggestionMapper on Query$GetSuggestions$suggestion {
  /// Converts this GraphQL suggestion response to a [Suggestion] domain model.
  Suggestion toDomain() {
    return Suggestion(
      brands: brands.toDomain(),
      keywords: keywords.toDomain(),
      products: products.toDomain(),
    );
  }
}

/// Converts a list of brand suggestion fragments into domain models.
extension SuggestionBrandMapper on List<Fragment$SuggestionBrandFragment> {
  /// Converts this list to a list of [SuggestionBrand] domain models.
  List<SuggestionBrand> toDomain() {
    return map(
      (brand) => SuggestionBrand(value: brand.value, results: brand.results),
    ).toList();
  }
}

/// Converts a list of keyword suggestion fragments into domain models.
extension SuggestionKeywordMapper on List<Fragment$SuggestionKeywordFragment> {
  /// Converts this list to a list of [SuggestionKeyword] domain models.
  List<SuggestionKeyword> toDomain() {
    return map(
      (keyword) =>
          SuggestionKeyword(value: keyword.value, results: keyword.results),
    ).toList();
  }
}

/// Converts a list of product suggestion fragments into domain models.
///
/// Handles nested transformations for media and price objects using
/// their respective mappers to ensure complete domain model conversion.
extension SuggestionProductMapper on List<Fragment$SuggestionProductFragment> {
  /// Converts this list to a list of [SuggestionProduct] domain models.
  ///
  /// Media and price objects are transformed using their dedicated mappers.
  List<SuggestionProduct> toDomain() {
    return map(
      (product) => SuggestionProduct(
        id: product.id,
        name: product.name,
        brandName: product.brandName,
        media: product.media.map((m) => m.toDomain()).toList(),
        price: product.price.toDomain(),
      ),
    ).toList();
  }
}
