import 'package:alfie_flutter/data/models/suggestion.dart';
import 'package:alfie_flutter/graphql/extensions/media_mapper.dart';
import 'package:alfie_flutter/graphql/extensions/price_mapper.dart';
import 'package:alfie_flutter/graphql/generated/queries/search/fragments/suggestion_brand_fragment.graphql.dart';
import 'package:alfie_flutter/graphql/generated/queries/search/fragments/suggestion_keyword_fragment.graphql.dart';
import 'package:alfie_flutter/graphql/generated/queries/search/fragments/suggestion_product_fragment.graphql.dart';
import 'package:alfie_flutter/graphql/generated/queries/search/search.graphql.dart';

extension SuggestionMapper on Query$GetSuggestions$suggestion {
  Suggestion toDomain() {
    return Suggestion(
      brands: brands.toDomain(),
      keywords: keywords.toDomain(),
      products: products.toDomain(),
    );
  }
}

extension SuggestionBrandMapper on List<Fragment$SuggestionBrandFragment> {
  List<SuggestionBrand> toDomain() {
    return map(
      (s) => SuggestionBrand(value: s.value, results: s.results),
    ).toList();
  }
}

extension SuggestionKeywordMapper on List<Fragment$SuggestionKeywordFragment> {
  List<SuggestionKeyword> toDomain() {
    return map(
      (s) => SuggestionKeyword(value: s.value, results: s.results),
    ).toList();
  }
}

extension SuggestionProductMapper on List<Fragment$SuggestionProductFragment> {
  List<SuggestionProduct> toDomain() {
    return map(
      (s) => SuggestionProduct(
        id: s.id,
        name: s.name,
        brandName: s.brandName,
        media: s.media.map((m) => m.toDomain()).toList(),
        price: s.price.toDomain(),
      ),
    ).toList();
  }
}
