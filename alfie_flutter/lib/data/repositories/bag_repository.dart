import 'package:alfie_flutter/data/models/bag_item.dart';
import 'package:alfie_flutter/data/services/persistent_storage_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final bagRepositoryProvider = Provider<BagRepository>(
  (ref) => BagRepository(ref.watch(persistentStorageServiceProvider)),
);

class BagRepository {
  final IPersistentStorageService _persistentStorageService;
  BagRepository(this._persistentStorageService);

  List<BagItem> getBagItems() {
    return List<BagItem>.from(_persistentStorageService.getBagItems());
  }

  double get total {
    final bagItems = getBagItems();
    return bagItems.fold(
      0.0,
      (sum, item) =>
          sum + item.product.defaultVariant.price.amount.amount * item.quantity,
    );
  }

  Future<void> addToBag(BagItem item) async {
    final currentItems = getBagItems();
    final existingIndex = currentItems.indexWhere(
      (i) => i.product.id == item.product.id,
    );

    if (existingIndex != -1) {
      final existingItem = currentItems[existingIndex];
      currentItems[existingIndex] = BagItem(
        product: existingItem.product,
        quantity: existingItem.quantity + item.quantity,
      );
    } else {
      currentItems.add(item);
    }

    await _persistentStorageService.saveBagItems(currentItems);
  }

  Future<void> removeFromBag(String productId) async {
    final currentItems = getBagItems();
    currentItems.removeWhere((item) => item.product.id == productId);
    await _persistentStorageService.saveBagItems(currentItems);
  }

  Future<void> updateQuantity(String productId, int quantity) async {
    final currentItems = getBagItems();
    final index = currentItems.indexWhere(
      (item) => item.product.id == productId,
    );

    if (index != -1) {
      final existingItem = currentItems[index];
      currentItems[index] = BagItem(
        product: existingItem.product,
        quantity: quantity,
      );
      await _persistentStorageService.saveBagItems(currentItems);
    }
  }

  Future<void> clearBag() async {
    await _persistentStorageService.saveBagItems([]);
  }
}
