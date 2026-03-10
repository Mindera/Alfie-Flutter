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
  List<BagItem> getBagItems();

  /// Overwrites the current bag products with a new [products] list.
  Future<void> saveBagItems(List<BagItem> products);

  /// Retrieves saved plp layout preference.
  int? getPlpLayoutPreference();

  /// Updates the current preference with a new [preference].
  Future<void> savePlpLayoutPreference(int preference);
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

  static const String _preferencesBoxName = 'preferencesBox';
  static const String _plpLayoutPreferenceKey = 'plpLayoutKey';

  @override
  Future<void> init() async {
    await Hive.initFlutter();

    registerSafe(SearchItemAdapter()); // typeId: 0
    registerSafe(BrandAdapter()); // typeId: 1
    registerSafe(MoneyAdapter()); // typeId: 2
    registerSafe(PriceRangeAdapter()); // typeId: 3
    registerSafe(PriceAdapter()); // typeId: 4
    registerSafe(MediaContentTypeAdapter()); // typeId: 5
    registerSafe(VideoFormatAdapter()); // typeId: 6
    registerSafe(MediaImageAdapter()); // typeId: 7
    registerSafe(VideoSourceAdapter()); // typeId: 8
    registerSafe(MediaVideoAdapter()); // typeId: 9
    registerSafe(SizeGuideAdapter()); // typeId: 10
    registerSafe(ProductSizeAdapter()); // typeId: 11
    registerSafe(ProductColorAdapter()); // typeId: 12
    registerSafe(ProductVariantAdapter()); // typeId: 13
    registerSafe(ProductAdapter()); // typeId: 14
    registerSafe(BagItemAdapter()); // typeId: 15

    // This should be dynamic because Hive doesn't store the generic type of the box

    await Hive.openBox<List<dynamic>>(_recentSearchesBoxName);
    await Hive.openBox<List<dynamic>>(_bagBoxName);

    await Hive.openBox(_preferencesBoxName);
    await _preferencesBox.clear();
  }

  void registerSafe<T>(TypeAdapter<T> adapter) {
    if (!Hive.isAdapterRegistered(adapter.typeId)) {
      Hive.registerAdapter<T>(adapter);
    }
  }

  Box<List<dynamic>> get _recentSearchesBox =>
      Hive.box<List<dynamic>>(_recentSearchesBoxName);
  Box<List<dynamic>> get _bagBox => Hive.box<List<dynamic>>(_bagBoxName);
  Box get _preferencesBox => Hive.box(_preferencesBoxName);

  @override
  List<SearchItem> getSearchHistory() {
    final data = _recentSearchesBox.get(
      _recentSearchesKey,
      defaultValue: <SearchItem>[],
    );
    return List<SearchItem>.from(data ?? []);
  }

  @override
  Future<void> saveSearchHistory(List<SearchItem> history) async {
    await _recentSearchesBox.put(_recentSearchesKey, history);
  }

  @override
  List<BagItem> getBagItems() {
    final data = _bagBox.get(_bagKey, defaultValue: <BagItem>[]);
    return List<BagItem>.from(data ?? []);
  }

  @override
  Future<void> saveBagItems(List<BagItem> products) async {
    await _bagBox.put(_bagKey, products);
  }

  @override
  int? getPlpLayoutPreference() {
    return _preferencesBox.get(_plpLayoutPreferenceKey) as int?;
  }

  @override
  Future<void> savePlpLayoutPreference(int preference) async {
    await _preferencesBox.put(_plpLayoutPreferenceKey, preference);
  }
}

/// Exposes the [IPersistentStorageService] via Riverpod.
final persistentStorageServiceProvider = Provider<IPersistentStorageService>(
  (ref) => HiveService(),
);
