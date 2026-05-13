import 'package:alfie_flutter/data/models/bag_item.dart';
import 'package:alfie_flutter/data/models/product.dart';
import 'package:alfie_flutter/data/repositories/product_repository.dart';
import 'package:alfie_flutter/data/repositories/wishlist_repository.dart';
import 'package:alfie_flutter/ui/bag/view_model/bag_view_model.dart';
import 'package:alfie_flutter/ui/product_detail/view_model/product_detail_state.dart';
import 'package:alfie_flutter/ui/wishlist/view_model/wishlist_view_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Orchestrates presentation state and user intents for a specific product detail view.
final productDetailViewModelProvider =
    NotifierProvider.family<ProductDetailViewModel, ProductDetailState, String>(
      ProductDetailViewModel.new,
    );

/// State controller managing the aggregate [ProductDetailState].
class ProductDetailViewModel extends Notifier<ProductDetailState> {
  /// The unique catalog identifier used to fetch the target product.
  final String productId;

  ProductDetailViewModel(this.productId);

  @override
  ProductDetailState build() {
    final productAsync = ref.watch(getProductProvider(productId));
    final wishlistRepository = ref.watch(wishlistRepositoryProvider);

    return ProductDetailState(
      product: productAsync,
      isOnWishlist: wishlistRepository.getWishlist().contains(
        productAsync.value,
      ),
    );
  }

  /// Dispatches an intent to invoke the native share dialog for this item.
  void shareProduct() {
    // TODO: Implement share logic
  }

  /// Packages the active [product] into a [BagItem] and dispatches it to the global cart.
  void addToBag(Product product) {
    ref
        .read(bagViewModelProvider.notifier)
        .addItem(BagItem(product: product, quantity: 1));
  }

  /// Saves the [product] to the user's wishlist and invalidates local state to reflect changes.
  void addToWishlist(Product product) {
    ref.read(wishlistViewModelProvider.notifier).addProduct(product);
    ref.invalidateSelf();
  }

  /// Removes the [product] from the user's wishlist and invalidates local state to reflect changes.
  void removeFromWishlist(Product product) {
    ref.read(wishlistViewModelProvider.notifier).removeProduct(product.id);
    ref.invalidateSelf();
  }
}
