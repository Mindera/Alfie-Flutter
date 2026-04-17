import 'package:alfie_flutter/data/models/bag_item.dart';
import 'package:alfie_flutter/data/models/product.dart';
import 'package:alfie_flutter/ui/bag/view_model/bag_view_model.dart';

class FakeBagViewModel extends BagViewModel {
  final List<BagItem> _initialItems;
  final double _totalPrice;
  bool updateItemQuantityCalled = false;
  int? updatedQuantity;

  @override
  Future<void> updateItemQuantity(String productId, int quantity) async {
    updateItemQuantityCalled = true;
    updatedQuantity = quantity;
  }

  bool removeItemCalled = false;
  bool addItemCalled = false;
  bool addToWishlistCalled = false;
  bool removeFromWishlistCalled = false;

  FakeBagViewModel({List<BagItem> items = const [], double totalPrice = 0.0})
    : _initialItems = items,
      _totalPrice = totalPrice;

  @override
  List<BagItem> build() => _initialItems;

  @override
  double get total => _totalPrice;

  @override
  Future<void> removeItem(String productId) async {
    removeItemCalled = true;
  }

  @override
  Future<void> addItem(BagItem item) async {
    addItemCalled = true;
  }

  @override
  void addToWishlist(Product product) {
    addToWishlistCalled = true;
  }

  @override
  void removeFromWishlist(Product product) {
    removeFromWishlistCalled = true;
  }
}
