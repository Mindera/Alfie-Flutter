import 'package:alfie_flutter/data/models/bag_item.dart';
import 'package:alfie_flutter/data/models/search_item.dart';
import 'package:alfie_flutter/data/services/hive_adapters/bag_item_adapter.dart';
import 'package:alfie_flutter/data/services/hive_adapters/brand_adapter.dart';
import 'package:alfie_flutter/data/services/hive_adapters/media_adapters.dart';
import 'package:alfie_flutter/data/services/hive_adapters/money_adapter.dart';
import 'package:alfie_flutter/data/services/hive_adapters/price_adapter.dart';
import 'package:alfie_flutter/data/services/hive_adapters/price_range_adapter.dart';
import 'package:alfie_flutter/data/services/hive_adapters/product_adapter.dart';
import 'package:alfie_flutter/data/services/hive_adapters/product_color_adapter.dart';
import 'package:alfie_flutter/data/services/hive_adapters/product_variant.dart';
import 'package:alfie_flutter/data/services/hive_adapters/search_item_adapter.dart';
import 'package:alfie_flutter/data/services/hive_adapters/size_adapters.dart';
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

  /// Retrieves saved bag products.
  List<BagItem> getBagProducts();

  /// Overwrites the current bag products with a new [products] list.
  Future<void> saveBagProducts(List<BagItem> products);
}

/// A Hive-based implementation of [IPersistentStorageService].
///
/// Encapsulates binary serialization and box management to provide
/// a clean API for the Repository layer.
class HiveService implements IPersistentStorageService {
  static const String _recentSearchesBoxName = 'recentSearchesBox';
  static const String _recentSearchesKey = 'recentSearches';

  static const String _bagBoxName = 'bagBox';
  static const String _bagKey = 'bag';

  @override
  Future<void> init() async {
    await Hive.initFlutter();

    final adapters = <TypeAdapter>[
      SearchItemAdapter(), // Assuming typeId: 0
      BrandAdapter(), // typeId: 1
      MoneyAdapter(), // typeId: 2
      PriceRangeAdapter(), // typeId: 3
      PriceAdapter(), // typeId: 4
      MediaContentTypeAdapter(), // typeId: 5
      VideoFormatAdapter(), // typeId: 6
      MediaImageAdapter(), // typeId: 7
      VideoSourceAdapter(), // typeId: 8
      MediaVideoAdapter(), // typeId: 9
      SizeGuideAdapter(), // typeId: 10
      ProductSizeAdapter(), // typeId: 11
      ProductColorAdapter(), // typeId: 12
      ProductVariantAdapter(), // typeId: 13
      ProductAdapter(), // typeId: 14
      BagItemAdapter(), // typeId: 15
    ];

    // Prevent redundant registration errors during hot restarts or widget tests.
    for (final adapter in adapters) {
      if (!Hive.isAdapterRegistered(adapter.typeId)) {
        Hive.registerAdapter(adapter);
      }
    }

    await Hive.openBox<List<SearchItem>>(_recentSearchesBoxName);
    await Hive.openBox<List<BagItem>>(_bagBoxName);
  }

  Box<List<SearchItem>> get _recentSearchesBox =>
      Hive.box<List<SearchItem>>(_recentSearchesBoxName);
  Box<List<BagItem>> get _bagBox => Hive.box<List<BagItem>>(_bagBoxName);

  @override
  List<SearchItem> getSearchHistory() {
    final data = _recentSearchesBox.get(
      _recentSearchesKey,
      defaultValue: <SearchItem>[],
    );
    return data ?? <SearchItem>[];
  }

  @override
  Future<void> saveSearchHistory(List<SearchItem> history) async {
    await _recentSearchesBox.put(_recentSearchesKey, history);
  }

  @override
  List<BagItem> getBagProducts() {
    final data = _bagBox.get(_bagKey, defaultValue: <BagItem>[]);
    return data ?? <BagItem>[];
  }

  @override
  Future<void> saveBagProducts(List<BagItem> products) async {
    await _bagBox.put(_bagKey, products);
  }
}

/// Exposes the [IPersistentStorageService] via Riverpod.
final persistentStorageServiceProvider = Provider<IPersistentStorageService>(
  (ref) => HiveService(),
);
