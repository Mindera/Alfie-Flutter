import 'package:alfie_flutter/data/models/search_item.dart';
import 'package:alfie_flutter/data/services/hive_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final searchHistoryRepositoryProvider = Provider<SearchHistoryRepository>(
  (ref) => SearchHistoryRepository(ref.watch(hiveServiceProvider)),
);

class SearchHistoryRepository {
  final HiveService _hiveService;

  static const int maxSearchItemsStored = 10;

  SearchHistoryRepository(this._hiveService);

  List<SearchItem> getRecentSearches() {
    return _hiveService.getSearchHistory();
  }

  Future<void> addSearchQuery(String query) async {
    final currentHistory = _hiveService.getSearchHistory().toList();

    currentHistory.removeWhere(
      (item) => item.query.toLowerCase() == query.toLowerCase(),
    );

    final newItem = SearchItem(query: query, timestamp: DateTime.now());
    currentHistory.insert(0, newItem);

    if (currentHistory.length > maxSearchItemsStored) {
      currentHistory.removeLast();
    }

    await _hiveService.saveSearchHistory(currentHistory);
  }

  Future<void> removeSearch(String query) async {
    final currentHistory = _hiveService.getSearchHistory().toList();
    currentHistory.removeWhere(
      (item) => item.query.toLowerCase() == query.toLowerCase(),
    );
    await _hiveService.saveSearchHistory(currentHistory);
  }

  Future<void> clearAll() async {
    await _hiveService.saveSearchHistory([]);
  }
}
