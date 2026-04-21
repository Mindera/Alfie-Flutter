import 'package:alfie_flutter/data/models/bag_item.dart';
import 'package:alfie_flutter/data/models/product.dart';
import 'package:alfie_flutter/ui/bag/view_model/bag_view_model.dart';

class FakeBagViewModel extends BagViewModel {
  FakeBagViewModel() : super();

  @override
  List<BagItem> build() {
    return [];
  }

  @override
  Future<void> addItem(BagItem item) async {
    // do nothing
  }

  @override
  Future<void> removeItem(String productId) async {
    // do nothing
  }

  @override
  Future<void> updateItemQuantity(String productId, int quantity) async {
    // do nothing
  }

  @override
  Future<void> clearBag() async {
    // do nothing
  }

  @override
  void addToWishlist(Product product) {
    // do nothing
  }

  @override
  void removeFromWishlist(Product product) {
    // do nothing
  }

  @override
  double get total => 0.0;
}