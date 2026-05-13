import 'package:alfie_flutter/data/models/bag_item.dart';
import 'package:alfie_flutter/data/models/product.dart';
import 'package:alfie_flutter/data/models/search_item.dart';
import 'package:alfie_flutter/data/services/hive_adapters/address_adapter.dart';
import 'package:alfie_flutter/data/services/hive_adapters/bag_item_adapter.dart';
import 'package:alfie_flutter/data/services/hive_adapters/brand_adapter.dart';
import 'package:alfie_flutter/data/services/hive_adapters/payment_card_type_adapter.dart';
import 'package:alfie_flutter/data/services/hive_adapters/checkout_state_adapter.dart';
import 'package:alfie_flutter/data/services/hive_adapters/delivery_method_adapter.dart';
import 'package:alfie_flutter/data/services/hive_adapters/media_adapters.dart';
import 'package:alfie_flutter/data/services/hive_adapters/money_adapter.dart';
import 'package:alfie_flutter/data/services/hive_adapters/payment_card_adapter.dart';
import 'package:alfie_flutter/data/services/hive_adapters/price_adapter.dart';
import 'package:alfie_flutter/data/services/hive_adapters/price_range_adapter.dart';
import 'package:alfie_flutter/data/services/hive_adapters/product_adapter.dart';
import 'package:alfie_flutter/data/services/hive_adapters/product_color_adapter.dart';
import 'package:alfie_flutter/data/services/hive_adapters/product_variant_adapter.dart';
import 'package:alfie_flutter/data/services/hive_adapters/search_item_adapter.dart';
import 'package:alfie_flutter/data/services/hive_adapters/size_adapters.dart';
import 'package:alfie_flutter/data/services/hive_adapters/user_adapters.dart';
import 'package:alfie_flutter/data/services/hive_adapters/user_data_adapter.dart';
import 'package:alfie_flutter/ui/checkout/view_model/checkout_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';

/// Defines the engine-agnostic contract for local data persistence.
///
/// Abstracting the storage engine allows the application to swap implementations
/// (e.g., from Hive to SQLite) without impacting higher-level domain logic.
abstract interface class IPersistentStorageService {
  /// Initializes the underlying storage engine and prepares necessary schemas.
  ///
  /// This method is idempotent and must be awaited prior to any read/write operations.
  Future<void> init();

  /// Retrieves the chronological list of cached [SearchItem] queries.
  List<SearchItem> getSearchHistory();

  /// Serializes and stores the provided [history] list to disk.
  Future<void> saveSearchHistory(List<SearchItem> history);

  /// Retrieves the active collection of [BagItem]s slated for checkout.
  List<BagItem> getBagItems();

  /// Synchronizes the current [products] in the shopping bag with local storage.
  Future<void> saveBagItems(List<BagItem> products);

  /// Retrieves the user's saved [Product] wishlist.
  List<Product> getWishlist();

  /// Synchronizes the active wishlist [products] with local storage.
  Future<void> saveWishlist(List<Product> products);

  /// Retrieves the user's UI layout preference for Product Listing Pages (PLP).
  int? getPlpLayoutPreference();

  /// Caches the user's PLP grid/list layout [preference].
  Future<void> savePlpLayoutPreference(int preference);

  /// Retrieves the cryptographic access token for the active user session.
  String? getAccessToken();

  /// Persists the active session's [token].
  Future<void> saveAccessToken(String token);

  /// Purges the active access token, typically invoked during logout or token expiration.
  Future<void> deleteAccessToken();

  /// Retrieves the transient [CheckoutState] to recover a user's checkout progress.
  CheckoutState? getCheckoutState();

  /// Serializes the active [state] of the checkout flow to survive application backgrounding.
  Future<void> saveCheckoutState(CheckoutState state);

  /// Purges the checkout state, typically invoked upon successful order placement.
  Future<void> deleteCheckoutState();
}

/// A Hive-based implementation of [IPersistentStorageService].
///
/// Encapsulates binary serialization, type adapter registration, and box management.
class HiveService implements IPersistentStorageService {
  static const String _recentSearchesBoxName = 'recentSearchesBox';
  static const String _recentSearchesKey = 'recentSearches';

  static const String _bagBoxName = 'bagBox';
  static const String _bagKey = 'bag';

  static const String _wishlistBoxName = 'wishlistBox';
  static const String _wishlistKey = 'wishlist';

  static const String _preferencesBoxName = 'preferencesBox';
  static const String _plpLayoutPreferenceKey = 'plpLayoutKey';

  static const String _authBoxName = 'authBox';
  static const String _accessTokenKey = 'accessTokenKey';

  static const String _checkoutStateBoxName = 'checkoutStateBox';
  static const String _checkoutStateKey = 'checkoutState';

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
    registerSafe(AddressAdapter()); // typeId: 16
    registerSafe(DeliveryMethodAdapter()); // typeId: 17

    registerSafe(UserDataAdapter()); // typeId: 19
    registerSafe(CheckoutStateAdapter()); // typeId: 20
    registerSafe(CardTypeAdapter()); // typeId: 21
    registerSafe(PaymentCardAdapter()); // typeId: 22
    registerSafe(RegisteredUserAdapter()); //typeId: 23
    registerSafe(GuestUserAdapter()); // typeId: 24

    // Note: Boxes storing lists require explicit casting during retrieval because
    // Hive does not securely store the generic type of the box natively.
    await Hive.openBox<CheckoutState>(_checkoutStateBoxName);
    await Hive.openBox<List<dynamic>>(_recentSearchesBoxName);
    await Hive.openBox<List<dynamic>>(_bagBoxName);
    await Hive.openBox<List<dynamic>>(_wishlistBoxName);
    await Hive.openBox(_preferencesBoxName);
    await Hive.openBox(_authBoxName);
  }

  /// Safely registers a Hive [adapter] only if its `typeId` is not already bound.
  void registerSafe<T>(TypeAdapter<T> adapter) {
    if (!Hive.isAdapterRegistered(adapter.typeId)) {
      Hive.registerAdapter<T>(adapter);
    }
  }

  Box<List<dynamic>> get _recentSearchesBox =>
      Hive.box<List<dynamic>>(_recentSearchesBoxName);
  Box<List<dynamic>> get _bagBox => Hive.box<List<dynamic>>(_bagBoxName);
  Box<List<dynamic>> get _wishlistBox =>
      Hive.box<List<dynamic>>(_wishlistBoxName);
  Box get _preferencesBox => Hive.box(_preferencesBoxName);
  Box get _authBox => Hive.box(_authBoxName);
  Box<CheckoutState> get _checkoutStateBox =>
      Hive.box<CheckoutState>(_checkoutStateBoxName);

  @override
  List<SearchItem> getSearchHistory() {
    final data = _recentSearchesBox.get(
      _recentSearchesKey,
      defaultValue: const <SearchItem>[],
    );
    return List<SearchItem>.from(data ?? []);
  }

  @override
  Future<void> saveSearchHistory(List<SearchItem> history) async {
    await _recentSearchesBox.put(_recentSearchesKey, history);
  }

  @override
  List<BagItem> getBagItems() {
    final data = _bagBox.get(_bagKey, defaultValue: const <BagItem>[]);
    return List<BagItem>.from(data ?? []);
  }

  @override
  Future<void> saveBagItems(List<BagItem> products) async {
    await _bagBox.put(_bagKey, products);
  }

  @override
  List<Product> getWishlist() {
    final data = _wishlistBox.get(
      _wishlistKey,
      defaultValue: const <Product>[],
    );
    return List<Product>.from(data ?? []);
  }

  @override
  Future<void> saveWishlist(List<Product> products) async {
    await _wishlistBox.put(_wishlistKey, products);
  }

  @override
  int? getPlpLayoutPreference() {
    return _preferencesBox.get(_plpLayoutPreferenceKey) as int?;
  }

  @override
  Future<void> savePlpLayoutPreference(int preference) async {
    await _preferencesBox.put(_plpLayoutPreferenceKey, preference);
  }

  @override
  String? getAccessToken() {
    return _authBox.get(_accessTokenKey) as String?;
  }

  @override
  Future<void> saveAccessToken(String token) async {
    await _authBox.put(_accessTokenKey, token);
  }

  @override
  Future<void> deleteAccessToken() async {
    await _authBox.clear();
  }

  @override
  Future<void> saveCheckoutState(CheckoutState state) async {
    await _checkoutStateBox.put(_checkoutStateKey, state);
  }

  @override
  CheckoutState? getCheckoutState() {
    return _checkoutStateBox.get(_checkoutStateKey);
  }

  @override
  Future<void> deleteCheckoutState() async {
    await _checkoutStateBox.clear();
  }
}

/// Exposes the active [IPersistentStorageService] instance globally via Riverpod.
final persistentStorageServiceProvider = Provider<IPersistentStorageService>(
  (ref) => HiveService(),
);
