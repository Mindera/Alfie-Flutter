import 'package:alfie_flutter/data/models/bag_item.dart';
import 'package:alfie_flutter/data/repositories/bag_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BagNotifier extends Notifier<List<BagItem>> {
  late final BagRepository _repository;

  @override
  List<BagItem> build() {
    _repository = ref.watch(bagRepositoryProvider);
    return _repository.getBagItems();
  }

  Future<void> addItem(BagItem item) async {
    await _repository.addToBag(item);
    state = _repository.getBagItems();
  }

  Future<void> removeItem(String productId) async {
    await _repository.removeFromBag(productId);
    state = _repository.getBagItems();
  }

  Future<void> updateItemQuantity(String productId, int quantity) async {
    if (quantity <= 0) {
      await removeItem(productId);
    } else {
      await _repository.updateQuantity(productId, quantity);
      state = _repository.getBagItems();
    }
  }

  double get total {
    return _repository.total;
  }

  Future<void> clearBag() async {
    await _repository.clearBag();
    state = [];
  }
}

final bagViewModelProvider = NotifierProvider<BagNotifier, List<BagItem>>(
  BagNotifier.new,
);
