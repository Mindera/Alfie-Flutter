import 'package:alfie_flutter/data/models/search_item.dart';
import 'package:alfie_flutter/data/repositories/search_history_repository.dart';
import 'package:alfie_flutter/ui/search/view_model/search_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// ViewModel responsible for orchestrating search logic and UI state.
///
/// It acts as the mediator between the UI and the [SearchHistoryRepository],
/// handling user input, updating local persistence, and mutating the [SearchState].
class SearchViewModel extends Notifier<SearchState> {
  late SearchHistoryRepository _repository;

  /// Limits the visual clutter in the UI by capping the number of displayed
  /// recent searches, without deleting the actual persisted history in the repository.
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

  Future<void> submitSearch(String query) async {
    if (query.trim().isEmpty) return;

    await _repository.addSearchQuery(query.trim());

    state = state.copyWith(
      currentSearchQuery: query.trim(),
      recentSearches: _getSearches(),
    );
  }

  Future<void> removeSearch(String query) async {
    await _repository.removeSearch(query);
    state = state.copyWith(recentSearches: _getSearches());
  }

  Future<void> clearHistory() async {
    await _repository.clearAll();
    state = state.copyWith(recentSearches: _getSearches());
  }
}

/// Exposes the [SearchViewModel] and its current [SearchState].
final searchViewModelProvider = NotifierProvider<SearchViewModel, SearchState>(
  SearchViewModel.new,
);
