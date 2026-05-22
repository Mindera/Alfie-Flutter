import 'package:alfie_flutter/data/models/bag_item.dart';
import 'package:alfie_flutter/data/services/persistent_storage_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Orchestrates the active shopping bag state and synchronizes it with local storage.
final bagRepositoryProvider = NotifierProvider<BagRepository, List<BagItem>>(
  () => BagRepository(),
);

/// Manages the collection of [BagItem]s intended for checkout.
class BagRepository extends Notifier<List<BagItem>> {
  late IPersistentStorageService _persistentStorageService;

  /// Hydrates the initial bag state from persistent storage.
  @override
  List<BagItem> build() {
    _persistentStorageService = ref.watch(persistentStorageServiceProvider);
    return List<BagItem>.from(_persistentStorageService.getBagItems());
  }

  /// Computes the aggregate monetary total of all items in the bag.
  ///
  /// Currently assumes the price is strictly based on the product's `defaultVariant`.
  double get total {
    final bagItems = state;
    return bagItems.fold(
      0.0,
      (sum, item) =>
          sum + item.product.defaultVariant.price.amount.amount * item.quantity,
    );
  }

  /// Inserts a new [item] or increments the quantity if the product is already present.
  Future<void> addToBag(BagItem item) async {
    final currentItems = [...state];
    final existingIndex = currentItems.indexWhere(
      (i) => i.product.id == item.product.id,
    );

    if (existingIndex != -1) {
      final existingItem = currentItems[existingIndex];
      currentItems[existingIndex] = existingItem.copyWith(
        quantity: existingItem.quantity + item.quantity,
      );
    } else {
      currentItems.add(item);
    }

    state = currentItems;
    await _persistentStorageService.saveBagItems(currentItems);
  }

  /// Removes the [BagItem] corresponding to [productId] entirely.
  Future<void> removeFromBag(String productId) async {
    final updatedItems = state
        .where((item) => item.product.id != productId)
        .toList();

    state = updatedItems;
    await _persistentStorageService.saveBagItems(updatedItems);
  }

  /// Overrides the requested [quantity] for an existing item in the bag.
  Future<void> updateQuantity(String productId, int quantity) async {
    final currentItems = [...state];
    final index = currentItems.indexWhere(
      (item) => item.product.id == productId,
    );

    if (index != -1) {
      final existingItem = currentItems[index];
      currentItems[index] = existingItem.copyWith(quantity: quantity);

      state = currentItems;
      await _persistentStorageService.saveBagItems(currentItems);
    }
  }

  /// Empties the bag and synchronizes the clearance to storage.
  Future<void> clearBag() async {
    state = const [];
    await _persistentStorageService.saveBagItems(const []);
  }
}
