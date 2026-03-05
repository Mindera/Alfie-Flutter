import 'package:alfie_flutter/data/models/search_item.dart';
import 'package:alfie_flutter/data/services/persistent_storage_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Provider for the [SearchHistoryRepository], ensuring a single instance
/// is used across the application via Riverpod.
final searchHistoryRepositoryProvider = Provider<SearchHistoryRepository>(
  (ref) => SearchHistoryRepository(ref.watch(persistentStorageServiceProvider)),
);

/// Manages the persistence and business logic for user search history.
///
/// This repository handles deduplication, chronological ordering, and
/// storage limits for [SearchItem] objects.
class SearchHistoryRepository {
  final IPersistentStorageService _persistentStorageService;

  /// The maximum number of recent searches kept in local storage.
  static const int _maxSearchItemsStored = 10;

  SearchHistoryRepository(this._persistentStorageService);

  /// Retrieves the current list of saved search items from the data source.
  List<SearchItem> getRecentSearches() {
    return _persistentStorageService.getSearchHistory();
  }

  /// Adds a new query to the history.
  ///
  /// If the query already exists (case-insensitive), the old entry is removed
  /// so the new one can be moved to the top of the list.
  /// Maintains a maximum size of [_maxSearchItemsStored].
  Future<void> addSearchQuery(String query) async {
    final currentHistory = _persistentStorageService
        .getSearchHistory()
        .toList();

    // Remove existing entry to handle move to top
    _removeQueryFromList(currentHistory, query);

    final newItem = SearchItem(query: query, timestamp: DateTime.now());

    currentHistory.insert(0, newItem);

    if (currentHistory.length > _maxSearchItemsStored) {
      currentHistory.removeLast();
    }

    await _persistentStorageService.saveSearchHistory(currentHistory);
  }

  /// Removes a specific query from the history, regardless of its timestamp.
  Future<void> removeSearch(String query) async {
    final currentHistory = _persistentStorageService
        .getSearchHistory()
        .toList();

    if (_removeQueryFromList(currentHistory, query)) {
      await _persistentStorageService.saveSearchHistory(currentHistory);
    }
  }

  /// Wipes all search history entries.
  Future<void> clearAll() async {
    await _persistentStorageService.saveSearchHistory([]);
  }

  /// Helper to remove queries from a list using case-insensitive matching.
  /// Returns true if an item was actually removed.
  bool _removeQueryFromList(List<SearchItem> list, String query) {
    final originalLength = list.length;
    list.removeWhere(
      (item) => item.query.trim().toLowerCase() == query.trim().toLowerCase(),
    );
    return list.length != originalLength;
  }
}
