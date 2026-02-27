import 'package:alfie_flutter/data/models/search_item.dart';
import 'package:alfie_flutter/data/repositories/search_history_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SearchViewModel extends Notifier<List<SearchItem>> {
  late SearchHistoryRepository _repository;

  static const int maxSearchItemsPresented = 5;

  List<SearchItem> _getSearches() {
    return _repository
        .getRecentSearches()
        .take(maxSearchItemsPresented)
        .toList();
  }

  @override
  List<SearchItem> build() {
    _repository = ref.watch(searchHistoryRepositoryProvider);
    return _getSearches();
  }

  Future<void> submitSearch(String query) async {
    if (query.trim().isEmpty) return;

    await _repository.addSearchQuery(query.trim());

    state = _getSearches();
  }

  Future<void> removeSearch(String query) async {
    await _repository.removeSearch(query);
    state = _getSearches();
  }

  Future<void> clearHistory() async {
    await _repository.clearAll();
    state = _getSearches();
  }
}

final searchViewModelProvider =
    NotifierProvider<SearchViewModel, List<SearchItem>>(SearchViewModel.new);
