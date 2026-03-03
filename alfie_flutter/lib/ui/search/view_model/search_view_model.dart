import 'package:alfie_flutter/data/models/search_item.dart';
import 'package:alfie_flutter/data/repositories/search_history_repository.dart';
import 'package:alfie_flutter/ui/search/view_model/search_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SearchViewModel extends Notifier<SearchState> {
  late SearchHistoryRepository _repository;

  static const int maxSearchItemsPresented = 5;
  List<SearchItem> _getSearches() {
    return _repository
        .getRecentSearches()
        .take(maxSearchItemsPresented)
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

final searchViewModelProvider = NotifierProvider<SearchViewModel, SearchState>(
  SearchViewModel.new,
);
