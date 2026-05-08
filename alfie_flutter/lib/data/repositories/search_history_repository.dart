import 'package:alfie_flutter/data/models/search_item.dart';
import 'package:alfie_flutter/data/services/persistent_storage_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Provides singleton access to the [SearchHistoryRepository].
final searchHistoryRepositoryProvider = Provider<SearchHistoryRepository>(
  (ref) => SearchHistoryRepository(ref.watch(persistentStorageServiceProvider)),
);

/// Coordinates the persistence, deduplication, and lifecycle of user search history.
class SearchHistoryRepository {
  final IPersistentStorageService _persistentStorageService;

  static const int _maxSearchItemsStored = 10;

  SearchHistoryRepository(this._persistentStorageService);

  /// Retrieves the chronological list of historical [SearchItem] queries.
  List<SearchItem> getRecentSearches() {
    return _persistentStorageService.getSearchHistory();
  }

  /// Commits a new [query] to persistent storage.
  ///
  /// Existing case-insensitive matches are removed to ensure the new query
  /// bubbles to the top. Enforces the strict capacity limit defined by [_maxSearchItemsStored].
  Future<void> addSearchQuery(String query) async {
    final currentHistory = _persistentStorageService
        .getSearchHistory()
        .toList();

    _removeQueryFromList(currentHistory, query);

    final newItem = SearchItem(query: query, timestamp: DateTime.now());

    currentHistory.insert(0, newItem);

    if (currentHistory.length > _maxSearchItemsStored) {
      currentHistory.removeLast();
    }

    await _persistentStorageService.saveSearchHistory(currentHistory);
  }

  /// Deletes a specific historical [query] entry based on a case-insensitive string match.
  Future<void> removeSearch(String query) async {
    final currentHistory = _persistentStorageService
        .getSearchHistory()
        .toList();

    if (_removeQueryFromList(currentHistory, query)) {
      await _persistentStorageService.saveSearchHistory(currentHistory);
    }
  }

  /// Clears all local search history state.
  Future<void> clearAll() async {
    await _persistentStorageService.saveSearchHistory([]);
  }

  /// Evaluates and mutates [list] in place, stripping case-insensitive matches against [query].
  ///
  /// Returns `true` if mutations occurred.
  bool _removeQueryFromList(List<SearchItem> list, String query) {
    final originalLength = list.length;
    list.removeWhere(
      (item) => item.query.trim().toLowerCase() == query.trim().toLowerCase(),
    );
    return list.length != originalLength;
  }
}
