import 'package:alfie_flutter/data/models/bag_item.dart';
import 'package:alfie_flutter/data/services/persistent_storage_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final bagRepositoryProvider = NotifierProvider<BagRepository, List<BagItem>>(
  () => BagRepository(),
);

class BagRepository extends Notifier<List<BagItem>> {
  late IPersistentStorageService _persistentStorageService;

  @override
  List<BagItem> build() {
    _persistentStorageService = ref.watch(persistentStorageServiceProvider);
    return List<BagItem>.from(_persistentStorageService.getBagItems());
  }

  double get total {
    final bagItems = state;
    return bagItems.fold(
      0.0,
      (sum, item) =>
          sum + item.product.defaultVariant.price.amount.amount * item.quantity,
    );
  }

  Future<void> addToBag(BagItem item) async {
    final currentItems = state;
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
    ref.invalidateSelf();
  }

  Future<void> removeFromBag(String productId) async {
    final currentItems = state;
    currentItems.removeWhere((item) => item.product.id == productId);
    await _persistentStorageService.saveBagItems(currentItems);
    ref.invalidateSelf();
  }

  Future<void> updateQuantity(String productId, int quantity) async {
    final currentItems = state;
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
    ref.invalidateSelf();
  }

  Future<void> clearBag() async {
    await _persistentStorageService.saveBagItems([]);
    ref.invalidateSelf();
  }
}
