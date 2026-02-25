import 'package:alfie_flutter/data/repositories/product_repository.dart';
import 'package:alfie_flutter/ui/product_detail/view_model/product_detail_state.dart';
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

    return ProductDetailState(product: productAsync);
  }

  /// Triggers the share dialog for the current product.
  void shareProduct() {
    // TODO: Implement share logic
  }
}

final productDetailViewModelProvider =
    NotifierProvider.family<ProductDetailViewModel, ProductDetailState, String>(
      ProductDetailViewModel.new,
    );
