import 'package:alfie_flutter/data/models/product.dart';
import 'package:alfie_flutter/data/services/persistent_storage_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Provides singleton access to the [WishlistRepository].
final wishlistRepositoryProvider = Provider<WishlistRepository>(
  (ref) => WishlistRepository(ref.watch(persistentStorageServiceProvider)),
);

/// Coordinates the persistence and retrieval of the user's saved [Product] wishlist.
class WishlistRepository {
  final IPersistentStorageService _persistentStorageService;

  WishlistRepository(this._persistentStorageService);

  /// Retrieves the current collection of saved wishlist items from local storage.
  List<Product> getWishlist() {
    return _persistentStorageService.getWishlist();
  }

  /// Appends a new [item] to the wishlist and synchronizes with storage.
  Future<void> addToWishlist(Product item) async {
    final currentItems = getWishlist();
    currentItems.add(item);
    await _persistentStorageService.saveWishlist(currentItems);
  }

  /// Deletes the specific item matching [productId] from the wishlist.
  Future<void> removeFromWishlist(String productId) async {
    final currentItems = getWishlist();
    currentItems.removeWhere((item) => item.id == productId);
    await _persistentStorageService.saveWishlist(currentItems);
  }

  /// Purges all items from the wishlist.
  Future<void> clearWishlists() async {
    await _persistentStorageService.saveWishlist([]);
  }
}
