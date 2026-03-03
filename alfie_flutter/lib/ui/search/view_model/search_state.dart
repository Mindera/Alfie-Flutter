import 'package:alfie_flutter/data/models/search_item.dart';

class SearchState {
  final List<SearchItem> recentSearches;

  SearchState({required this.recentSearches});

  SearchState copyWith({List<SearchItem>? recentSearches}) {
    return SearchState(recentSearches: recentSearches ?? this.recentSearches);
  }
}
