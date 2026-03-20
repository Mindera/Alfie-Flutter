import 'package:alfie_flutter/data/models/product.dart';
import 'package:alfie_flutter/data/repositories/wishlist_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class WishlistViewModel extends Notifier<List<Product>> {
  late final WishlistRepository _repository;

  @override
  List<Product> build() {
    _repository = ref.watch(wishlistRepositoryProvider);
    return _repository.getWishlist();
  }

  Future<void> addProduct(Product item) async {
    await _repository.addToWishlist(item);
    state = _repository.getWishlist();
  }

  Future<void> removeProduct(String productId) async {
    await _repository.removeFromWishlist(productId);
    state = _repository.getWishlist();
  }

  Future<void> clearWishlist() async {
    await _repository.clearWishlists();
    state = [];
  }
}

final wishlistViewModelProvider =
    NotifierProvider<WishlistViewModel, List<Product>>(WishlistViewModel.new);
