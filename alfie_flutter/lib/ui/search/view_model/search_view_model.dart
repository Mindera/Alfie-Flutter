import 'package:alfie_flutter/data/models/search_item.dart';
import 'package:alfie_flutter/data/repositories/search_history_repository.dart';
import 'package:alfie_flutter/ui/search/view_model/search_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Orchestrates search input intents and historical query state.
final searchViewModelProvider = NotifierProvider<SearchViewModel, SearchState>(
  SearchViewModel.new,
);

/// State controller managing the aggregate [SearchState].
///
/// Mediates user input, sanitizes queries, and synchronizes the transient
/// presentation state with the persistent [SearchHistoryRepository].
class SearchViewModel extends Notifier<SearchState> {
  late SearchHistoryRepository _repository;

  /// Restricts the visual presentation of history to prevent UI clutter.
  ///
  /// Note: This does not affect the actual storage capacity enforced by the repository.
  static const int _maxSearchItemsPresented = 5;

  List<SearchItem> _getSearches() {
    return _repository
        .getRecentSearches()
        .take(_maxSearchItemsPresented)
        .toList();
  }

  @override
  SearchState build() {
    _repository = ref.watch(searchHistoryRepositoryProvider);
    return SearchState(
      currentSearchQuery: null,
      recentSearches: _getSearches(),
    );
  }

  /// Commits a sanitized [query] to persistent history and updates the active UI state.
  Future<void> submitSearch(String query) async {
    if (query.trim().isEmpty) return;

    await _repository.addSearchQuery(query.trim());

    state = state.copyWith(
      currentSearchQuery: query.trim(),
      recentSearches: _getSearches(),
    );
  }

  /// Deletes a specific historical [query] and refreshes the local presentation state.
  Future<void> removeSearch(String query) async {
    await _repository.removeSearch(query);
    state = state.copyWith(recentSearches: _getSearches());
  }

  /// Purges all historical searches from storage and clears the active UI list.
  Future<void> clearHistory() async {
    await _repository.clearAll();
    state = state.copyWith(recentSearches: _getSearches());
  }
}
