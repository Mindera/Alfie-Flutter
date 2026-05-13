import 'package:alfie_flutter/data/models/search_item.dart';

/// Aggregates the presentation state for the search interface.
///
/// Manages the transient active query alongside a bounded collection
/// of historical user searches.
class SearchState {
  /// The collection of previously executed [SearchItem] queries.
  final List<SearchItem> recentSearches;

  /// The active, unsubmitted text currently residing in the search input field.
  final String? currentSearchQuery;

  const SearchState({required this.recentSearches, this.currentSearchQuery});

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
