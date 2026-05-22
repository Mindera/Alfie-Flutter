import 'package:alfie_flutter/data/models/bag_item.dart';
import 'package:alfie_flutter/data/models/product.dart';
import 'package:alfie_flutter/data/repositories/bag_repository.dart';
import 'package:alfie_flutter/ui/wishlist/view_model/wishlist_view_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Orchestrates the presentation logic and state for the shopping bag.
final bagViewModelProvider = NotifierProvider<BagViewModel, List<BagItem>>(
  BagViewModel.new,
);

/// State controller for the active checkout session payload.
///
/// Proxies bag mutations to the underlying [BagRepository] and coordinates
/// cross-domain actions, such as shifting items to the wishlist.
class BagViewModel extends Notifier<List<BagItem>> {
  BagRepository get _repository => ref.read(bagRepositoryProvider.notifier);

  @override
  List<BagItem> build() {
    return ref.watch(bagRepositoryProvider);
  }

  /// Appends [item] to the shopping bag.
  Future<void> addItem(BagItem item) async {
    await _repository.addToBag(item);
  }

  /// Purges the item matching [productId] from the shopping bag.
  Future<void> removeItem(String productId) async {
    await _repository.removeFromBag(productId);
  }

  /// Modifies the volume of a specific item within the bag.
  ///
  /// Automatically removes the item entirely if the [quantity] resolves to zero or less.
  Future<void> updateItemQuantity(String productId, int quantity) async {
    if (quantity <= 0) {
      await removeItem(productId);
    } else {
      await _repository.updateQuantity(productId, quantity);
    }
  }

  /// The aggregate monetary sum of all items residing in the bag.
  double get total {
    return _repository.total;
  }

  /// Instantly purges all items, resulting in an empty bag state.
  Future<void> clearBag() async {
    await _repository.clearBag();
  }

  /// Migrates the specified [product] to the user's saved wishlist.
  void addToWishlist(Product product) {
    ref.read(wishlistViewModelProvider.notifier).addProduct(product);
  }

  /// Removes the specified [product] from the user's saved wishlist.
  void removeFromWishlist(Product product) {
    ref.read(wishlistViewModelProvider.notifier).removeProduct(product.id);
  }
}
