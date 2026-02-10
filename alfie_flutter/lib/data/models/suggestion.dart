import 'package:alfie_flutter/data/models/media.dart';
import 'package:alfie_flutter/data/models/price.dart';

class Suggestion {
  final List<SuggestionBrand> brands;
  final List<SuggestionKeyword> keywords;
  final List<SuggestionProduct> products;

  Suggestion({
    required this.brands,
    required this.keywords,
    required this.products,
  });
}

class SuggestionBrand {
  final String value;
  final int results;

  SuggestionBrand({required this.value, required this.results});
}

class SuggestionKeyword {
  final String value;
  final int results;

  SuggestionKeyword({required this.value, required this.results});
}

class SuggestionProduct {
  final String id;
  final String name;
  final String brandName;
  final List<Media> media;
  final Price price;

  SuggestionProduct({
    required this.id,
    required this.name,
    required this.brandName,
    required this.media,
    required this.price,
  });
}
