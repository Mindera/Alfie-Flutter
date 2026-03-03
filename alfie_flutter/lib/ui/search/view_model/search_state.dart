import 'package:alfie_flutter/data/models/search_item.dart';

class SearchState {
  final List<SearchItem> recentSearches;
  final String? currentSearchQuery;

  SearchState({required this.recentSearches, this.currentSearchQuery});

  SearchState copyWith({
    List<SearchItem>? recentSearches,
    String? currentSearchQuery,
  }) {
    return SearchState(
      recentSearches: recentSearches ?? this.recentSearches,
      currentSearchQuery: currentSearchQuery ?? this.currentSearchQuery,
    );
  }
}
