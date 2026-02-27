import 'package:alfie_flutter/data/models/search_item.dart';
import 'package:alfie_flutter/data/repositories/search_history_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SearchViewModel extends Notifier<List<SearchItem>> {
  late SearchHistoryRepository _repository;

  @override
  List<SearchItem> build() {
    _repository = ref.watch(searchHistoryRepositoryProvider);
    return _repository.getRecentSearches();
  }

  Future<void> submitSearch(String query) async {
    if (query.trim().isEmpty) return;

    await _repository.addSearchQuery(query.trim());

    state = _repository.getRecentSearches();
  }

  Future<void> removeSearch(String query) async {
    await _repository.removeSearch(query);
    state = _repository.getRecentSearches();
  }

  Future<void> clearHistory() async {
    await _repository.clearAll();
    state = _repository.getRecentSearches();
  }
}

final searchViewModelProvider =
    NotifierProvider<SearchViewModel, List<SearchItem>>(SearchViewModel.new);
