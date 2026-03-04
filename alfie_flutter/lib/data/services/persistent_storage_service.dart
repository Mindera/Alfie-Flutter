import 'package:alfie_flutter/data/models/search_item.dart';
import 'package:alfie_flutter/data/services/hive_adapters/search_item_adapter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';

/// Defines the contract for local data persistence.
///
/// Using an interface allows the application to swap storage engines
/// (e.g., switching from Hive to SQLite) without impacting the domain logic.
abstract interface class IPersistentStorageService {
  /// Prepares the storage engine. Is idempotent (can be called multiple times without adverse effects).
  Future<void> init();

  /// Retrieves saved search history of [SearchItem] records.
  List<SearchItem> getSearchHistory();

  /// Overwrites the current search history with a new [history] list.
  Future<void> saveSearchHistory(List<SearchItem> history);
}

/// A Hive-based implementation of [IPersistentStorageService].
///
/// Encapsulates binary serialization and box management to provide
/// a clean API for the Repository layer.
class HiveService implements IPersistentStorageService {
  static const String _boxName = 'searchBox';
  static const String _historyKey = 'recentSearches';

  @override
  Future<void> init() async {
    await Hive.initFlutter();

    // Prevent redundant registration errors during hot restarts or widget tests.
    final adapter = SearchItemAdapter();
    if (!Hive.isAdapterRegistered(adapter.typeId)) {
      Hive.registerAdapter(adapter);
    }

    await Hive.openBox<List<dynamic>>(_boxName);
  }

  /// Provides safe access to the underlying Hive box.
  ///
  /// Throws a [HiveError] if the box is accessed before [init] is called.
  Box<List<dynamic>> get _box => Hive.box<List<dynamic>>(_boxName);

  @override
  List<SearchItem> getSearchHistory() {
    final data = _box.get(_historyKey, defaultValue: <dynamic>[]);
    return data?.cast<SearchItem>() ?? <SearchItem>[];
  }

  @override
  Future<void> saveSearchHistory(List<SearchItem> history) async {
    await _box.put(_historyKey, history);
  }
}

/// Exposes the [IPersistentStorageService] via Riverpod.
final persistentStorageServiceProvider = Provider<IPersistentStorageService>(
  (ref) => HiveService(),
);
