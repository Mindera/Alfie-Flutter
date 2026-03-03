import 'package:alfie_flutter/data/repositories/search_history_repository.dart';
import 'package:alfie_flutter/ui/search/view_model/search_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SearchViewModel extends Notifier<SearchState> {
  late SearchHistoryRepository _repository;

  static const int maxSearchItemsPresented = 5;

  SearchState _updateSearches() {
    return SearchState(
      recentSearches: _repository
          .getRecentSearches()
          .take(maxSearchItemsPresented)
          .toList(),
    );
  }

  @override
  SearchState build() {
    _repository = ref.watch(searchHistoryRepositoryProvider);
    return _updateSearches();
  }

  Future<void> submitSearch(String query) async {
    if (query.trim().isEmpty) return;

    await _repository.addSearchQuery(query.trim());

    state = _updateSearches();
  }

  Future<void> removeSearch(String query) async {
    await _repository.removeSearch(query);
    state = _updateSearches();
  }

  Future<void> clearHistory() async {
    await _repository.clearAll();
    state = _updateSearches();
  }
}

final searchViewModelProvider = NotifierProvider<SearchViewModel, SearchState>(
  SearchViewModel.new,
);
