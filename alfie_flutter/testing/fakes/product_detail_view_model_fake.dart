import 'package:alfie_flutter/data/models/product.dart';
import 'package:alfie_flutter/ui/product_detail/view_model/product_detail_state.dart';
import 'package:alfie_flutter/ui/product_detail/view_model/product_detail_view_model.dart';

/// Fake implementation of ProductDetailViewModel for testing
class FakeProductDetailViewModel extends ProductDetailViewModel {
  final ProductDetailState initialState;

  FakeProductDetailViewModel(this.initialState)
    : super(initialState.product.value?.id ?? "");

  @override
  ProductDetailState build() {
    return initialState;
  }

  @override
  void addToBag(Product product) {
    // No-op for testing
  }

  @override
  void addToWishlist(Product product) {
    state = state.copyWith(isOnWishlist: true);
  }

  @override
  void removeFromWishlist(Product product) {
    state = state.copyWith(isOnWishlist: false);
  }

  @override
  void shareProduct() {
    // No-op for testing
  }
}
