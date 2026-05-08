import 'package:alfie_flutter/ui/bag/view_model/bag_view_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:alfie_flutter/data/models/bag_item.dart';
import 'package:alfie_flutter/data/repositories/bag_repository.dart';

import '../../../testing/mocks.dart';

/// A Fake implementation to test BagViewModel cleanly without dealing
/// with persistent storage mocks or Riverpod's limits on mocking Notifiers.
class FakeBagRepository extends BagRepository {
  final List<BagItem> initialItems;
  final double mockTotal;

  FakeBagRepository({this.initialItems = const [], this.mockTotal = 0.0});

  bool addToBagCalled = false;
  bool removeFromBagCalled = false;
  bool updateQuantityCalled = false;
  bool clearBagCalled = false;

  @override
  List<BagItem> build() {
    return initialItems;
  }

  @override
  Future<void> addToBag(BagItem item) async {
    addToBagCalled = true;
    state = [...state, item];
  }

  @override
  Future<void> removeFromBag(String productId) async {
    removeFromBagCalled = true;
    state = state.where((item) => item.product.id != productId).toList();
  }

  @override
  Future<void> updateQuantity(String productId, int quantity) async {
    updateQuantityCalled = true;
    state = state.map((item) {
      if (item.product.id == productId) {
        return BagItem(product: item.product, quantity: quantity);
      }
      return item;
    }).toList();
  }

  @override
  double get total => mockTotal;

  @override
  Future<void> clearBag() async {
    clearBagCalled = true;
    state = [];
  }
}

void main() {
  late MockProduct mockProduct1;
  late MockProduct mockProduct2;
  late BagItem item1;
  late BagItem item2;

  setUp(() {
    mockProduct1 = MockProduct();
    mockProduct2 = MockProduct();

    when(() => mockProduct1.id).thenReturn('prod-1');
    when(() => mockProduct2.id).thenReturn('prod-2');

    item1 = BagItem(product: mockProduct1, quantity: 1);
    item2 = BagItem(product: mockProduct2, quantity: 2);
  });

  /// Helper method to create a fresh ProviderContainer overridden with our Fake Repo
  ProviderContainer createContainer(FakeBagRepository fakeRepo) {
    final container = ProviderContainer(
      overrides: [bagRepositoryProvider.overrideWith(() => fakeRepo)],
    );
    addTearDown(container.dispose);
    return container;
  }

  group('BagViewModel Tests -', () {
    test('initial state is loaded from the repository', () {
      final initialItems = [item1];
      final fakeRepo = FakeBagRepository(initialItems: initialItems);
      final container = createContainer(fakeRepo);

      final state = container.read(bagViewModelProvider);

      expect(state, initialItems);
    });

    test('addItem calls repository and updates state', () async {
      final fakeRepo = FakeBagRepository();
      final container = createContainer(fakeRepo);

      await container.read(bagViewModelProvider.notifier).addItem(item1);

      expect(fakeRepo.addToBagCalled, isTrue);
      expect(container.read(bagViewModelProvider), [item1]);
    });

    test('removeItem calls repository and updates state', () async {
      final fakeRepo = FakeBagRepository(initialItems: [item1, item2]);
      final container = createContainer(fakeRepo);

      await container.read(bagViewModelProvider.notifier).removeItem('prod-1');

      expect(fakeRepo.removeFromBagCalled, isTrue);
      expect(container.read(bagViewModelProvider), [item2]);
    });

    test('updateItemQuantity calls updateQuantity when quantity > 0', () async {
      final fakeRepo = FakeBagRepository(initialItems: [item1]);
      final container = createContainer(fakeRepo);

      await container
          .read(bagViewModelProvider.notifier)
          .updateItemQuantity('prod-1', 5);

      expect(fakeRepo.updateQuantityCalled, isTrue);
      expect(container.read(bagViewModelProvider).first.quantity, 5);
    });

    test('updateItemQuantity calls removeItem when quantity <= 0', () async {
      final fakeRepo = FakeBagRepository(initialItems: [item1]);
      final container = createContainer(fakeRepo);

      await container
          .read(bagViewModelProvider.notifier)
          .updateItemQuantity('prod-1', 0);

      expect(fakeRepo.removeFromBagCalled, isTrue);
      expect(fakeRepo.updateQuantityCalled, isFalse);
      expect(container.read(bagViewModelProvider), isEmpty);
    });

    test('total getter delegates to repository', () {
      final fakeRepo = FakeBagRepository(mockTotal: 99.99);
      final container = createContainer(fakeRepo);

      final total = container.read(bagViewModelProvider.notifier).total;

      expect(total, 99.99);
    });

    test('clearBag clears repository and empties state', () async {
      final fakeRepo = FakeBagRepository(initialItems: [item1, item2]);
      final container = createContainer(fakeRepo);

      await container.read(bagViewModelProvider.notifier).clearBag();

      expect(fakeRepo.clearBagCalled, isTrue);
      expect(container.read(bagViewModelProvider), isEmpty);
    });
  });
}
