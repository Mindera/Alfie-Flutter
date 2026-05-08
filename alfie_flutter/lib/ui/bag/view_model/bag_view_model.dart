import 'package:alfie_flutter/data/models/bag_item.dart';
import 'package:alfie_flutter/data/models/product.dart';
import 'package:alfie_flutter/data/repositories/bag_repository.dart';
import 'package:alfie_flutter/ui/wishlist/view_model/wishlist_view_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BagViewModel extends Notifier<List<BagItem>> {
  BagRepository get _repository => ref.read(bagRepositoryProvider.notifier);

  @override
  List<BagItem> build() {
    return ref.watch(bagRepositoryProvider);
  }

  Future<void> addItem(BagItem item) async {
    await _repository.addToBag(item);
  }

  Future<void> removeItem(String productId) async {
    await _repository.removeFromBag(productId);
  }

  Future<void> updateItemQuantity(String productId, int quantity) async {
    if (quantity <= 0) {
      await removeItem(productId);
    } else {
      await _repository.updateQuantity(productId, quantity);
    }
  }

  double get total {
    return _repository.total;
  }

  Future<void> clearBag() async {
    await _repository.clearBag();
  }

  void addToWishlist(Product product) {
    ref.read(wishlistViewModelProvider.notifier).addProduct(product);
  }

  void removeFromWishlist(Product product) {
    ref.read(wishlistViewModelProvider.notifier).removeProduct(product.id);
  }
}

final bagViewModelProvider = NotifierProvider<BagViewModel, List<BagItem>>(
  BagViewModel.new,
);
