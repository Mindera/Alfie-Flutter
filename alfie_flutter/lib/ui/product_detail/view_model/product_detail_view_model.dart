import 'package:alfie_flutter/data/models/bag_item.dart';
import 'package:alfie_flutter/data/models/product.dart';
import 'package:alfie_flutter/data/repositories/product_repository.dart';
import 'package:alfie_flutter/data/repositories/wishlist_repository.dart';
import 'package:alfie_flutter/ui/bag/view_model/bag_view_model.dart';
import 'package:alfie_flutter/ui/product_detail/view_model/product_detail_state.dart';
import 'package:alfie_flutter/ui/wishlist/view_model/wishlist_view_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// View Model managing the business logic and state for the Product Detail screen.
class ProductDetailViewModel extends Notifier<ProductDetailState> {
  /// The [productId] passed via the family provider.
  final String productId;

  ProductDetailViewModel(this.productId);

  @override
  ProductDetailState build() {
    // Watch the repository provider. If the underlying data changes,
    // this ViewModel will automatically rebuild its state.
    final productAsync = ref.watch(getProductProvider(productId));
    final wishlistRepository = ref.watch(wishlistRepositoryProvider);

    return ProductDetailState(
      product: productAsync,
      isOnWishlist: wishlistRepository.getWishlist().contains(
        productAsync.value,
      ),
    );
  }

  /// Triggers the share dialog for the current product.
  void shareProduct() {
    // TODO: Implement share logic
  }

  void addToBag(Product product) {
    ref
        .read(bagViewModelProvider.notifier)
        .addItem(BagItem(product: product, quantity: 1));
  }

  void addToWishlist(Product product) {
    ref.read(wishlistViewModelProvider.notifier).addProduct(product);
    ref.invalidateSelf();
  }

  void removeFromWishlist(Product product) {
    ref.read(wishlistViewModelProvider.notifier).removeProduct(product.id);
    ref.invalidateSelf();
  }
}

final productDetailViewModelProvider =
    NotifierProvider.family<ProductDetailViewModel, ProductDetailState, String>(
      ProductDetailViewModel.new,
    );
