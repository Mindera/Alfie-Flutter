import 'package:alfie_flutter/data/models/search_item.dart';

/// Represents the UI state for the search screen.
///
/// Holds both the user's recent search history
/// and the currently active search query.
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
