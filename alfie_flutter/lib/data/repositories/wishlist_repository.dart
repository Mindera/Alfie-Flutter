import 'package:alfie_flutter/data/models/product.dart';
import 'package:alfie_flutter/data/services/persistent_storage_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final wishlistRepositoryProvider = Provider<WishlistRepository>(
  (ref) => WishlistRepository(ref.watch(persistentStorageServiceProvider)),
);

class WishlistRepository {
  final IPersistentStorageService _persistentStorageService;
  WishlistRepository(this._persistentStorageService);

  List<Product> getWishlist() {
    return _persistentStorageService.getWishlist();
  }

  Future<void> addToWishlist(Product item) async {
    final currentItems = getWishlist();
    currentItems.add(item);
    await _persistentStorageService.saveWishlist(currentItems);
  }

  Future<void> removeFromWishlist(String productId) async {
    final currentItems = getWishlist();
    currentItems.removeWhere((item) => item.id == productId);
    await _persistentStorageService.saveWishlist(currentItems);
  }

  Future<void> clearWishlists() async {
    await _persistentStorageService.saveWishlist([]);
  }
}
