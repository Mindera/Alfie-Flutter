import 'package:alfie_flutter/data/models/product.dart';
import 'package:alfie_flutter/data/repositories/wishlist_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Orchestrates the presentation state for the user's saved wishlist.
final wishlistViewModelProvider =
    NotifierProvider<WishlistViewModel, List<Product>>(WishlistViewModel.new);

/// State controller managing the aggregate collection of saved [Product] entities.
///
/// Mediates user intents to save, remove, or clear items, synchronizing the
/// local presentation state with the persistent [WishlistRepository].
class WishlistViewModel extends Notifier<List<Product>> {
  late final WishlistRepository _repository;

  @override
  List<Product> build() {
    _repository = ref.watch(wishlistRepositoryProvider);
    return _repository.getWishlist();
  }

  /// Appends [item] to the persistent wishlist and forces a state refresh.
  Future<void> addProduct(Product item) async {
    await _repository.addToWishlist(item);
    state = _repository.getWishlist();
  }

  /// Deletes the product matching [productId] and forces a state refresh.
  Future<void> removeProduct(String productId) async {
    await _repository.removeFromWishlist(productId);
    state = _repository.getWishlist();
  }

  /// Purges all active [Product] entities from the wishlist.
  Future<void> clearWishlist() async {
    await _repository.clearWishlists();
    state = const [];
  }
}
