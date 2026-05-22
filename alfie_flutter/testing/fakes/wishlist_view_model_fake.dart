import 'package:alfie_flutter/data/models/product.dart';
import 'package:alfie_flutter/ui/wishlist/view_model/wishlist_view_model.dart';

class FakeWishlistViewModel extends WishlistViewModel {
  final List<Product> initialState;

  FakeWishlistViewModel(this.initialState) : super();

  @override
  List<Product> build() {
    return initialState;
  }

  @override
  Future<void> addProduct(Product item) async {
    // do nothing for test
  }

  @override
  Future<void> removeProduct(String productId) async {
    // do nothing for test
  }

  @override
  Future<void> clearWishlist() async {
    state = [];
  }
}
