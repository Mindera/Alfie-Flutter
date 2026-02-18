import 'package:alfie_flutter/data/repositories/product_repository.dart';
import 'package:alfie_flutter/ui/product_detail/view_model/product_detail_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProductDetailViewModel extends Notifier<ProductDetailState> {
  final String productId;

  ProductDetailViewModel(this.productId);

  @override
  ProductDetailState build() {
    final productAsync = ref.watch(getProductProvider(productId));

    return ProductDetailState(product: productAsync);
  }

  void shareProduct() {
    // share logic
  }
}

final productDetailViewModelProvider =
    NotifierProvider.family<ProductDetailViewModel, ProductDetailState, String>(
      ProductDetailViewModel.new,
    );
