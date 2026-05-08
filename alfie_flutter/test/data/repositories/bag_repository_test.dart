import 'package:alfie_flutter/data/services/persistent_storage_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:alfie_flutter/data/models/bag_item.dart';
import 'package:alfie_flutter/data/repositories/bag_repository.dart';

import '../../../testing/mocks.dart';

void main() {
  late MockPersistentStorageService mockStorageService;

  // Setup mock data
  late MockProduct mockProduct1;
  late MockProduct mockProduct2;

  setUpAll(() {
    // Required by mocktail to use any() with custom types/lists
    registerFallbackValue(<BagItem>[]);
  });

  setUp(() {
    mockStorageService = MockPersistentStorageService();

    // Initialize mock products
    mockProduct1 = MockProduct();
    mockProduct2 = MockProduct();

    when(() => mockProduct1.id).thenReturn('prod-1');
    when(() => mockProduct2.id).thenReturn('prod-2');

    // Default stub for getBagItems and saveBagItems
    when(() => mockStorageService.getBagItems()).thenReturn([]);
    when(() => mockStorageService.saveBagItems(any())).thenAnswer((_) async {});
  });

  ProviderContainer createContainer() {
    final container = ProviderContainer(
      overrides: [
        persistentStorageServiceProvider.overrideWithValue(mockStorageService),
      ],
    );
    addTearDown(container.dispose);
    return container;
  }

  group('BagRepository Tests - ', () {
    test('initial state is loaded from storage', () {
      final items = [BagItem(product: mockProduct1, quantity: 1)];
      when(() => mockStorageService.getBagItems()).thenReturn(items);

      final container = createContainer();

      // Read the provider's state instead of calling getBagItems()
      final state = container.read(bagRepositoryProvider);

      expect(state.length, 1);
      expect(state.first.product.id, 'prod-1');
      verify(() => mockStorageService.getBagItems()).called(1);
    });

    test('total calculates correctly based on product prices and quantities', () {
      // Mocking the nested price structure: product.defaultVariant.price.amount.amount
      final mockVariant1 = MockProductVariant();
      final mockPrice1 = MockPrice();
      final mockAmount1 = MockMoney();

      when(() => mockAmount1.amount).thenReturn(10.0);
      when(() => mockPrice1.amount).thenReturn(mockAmount1);
      when(() => mockVariant1.price).thenReturn(mockPrice1);
      when(() => mockProduct1.defaultVariant).thenReturn(mockVariant1);

      final items = [
        BagItem(product: mockProduct1, quantity: 2), // 10.0 * 2 = 20.0
      ];

      when(() => mockStorageService.getBagItems()).thenReturn(items);

      final container = createContainer();
      final repository = container.read(bagRepositoryProvider.notifier);

      expect(repository.total, 20.0);
    });

    test('addToBag adds new item if it does not exist', () async {
      final container = createContainer();
      final repository = container.read(bagRepositoryProvider.notifier);

      final newItem = BagItem(product: mockProduct1, quantity: 1);
      await repository.addToBag(newItem);

      // Verify saveBagItems was called with a list containing our new item
      verify(() => mockStorageService.saveBagItems(any())).called(1);
    });

    test('addToBag updates quantity if item already exists', () async {
      final existingItem = BagItem(product: mockProduct1, quantity: 2);
      when(() => mockStorageService.getBagItems()).thenReturn([existingItem]);

      final container = createContainer();
      final repository = container.read(bagRepositoryProvider.notifier);

      final itemToAdd = BagItem(product: mockProduct1, quantity: 3);
      await repository.addToBag(itemToAdd);

      // Verify saveBagItems was called with updated quantity (2 + 3 = 5)
      verify(
        () => mockStorageService.saveBagItems(
          any(
            that: predicate<List<BagItem>>((list) => list.first.quantity == 5),
          ),
        ),
      ).called(1);
    });

    test('removeFromBag removes item by productId', () async {
      final items = [
        BagItem(product: mockProduct1, quantity: 1),
        BagItem(product: mockProduct2, quantity: 2),
      ];
      when(() => mockStorageService.getBagItems()).thenReturn(items);

      final container = createContainer();
      final repository = container.read(bagRepositoryProvider.notifier);

      await repository.removeFromBag('prod-1');

      // Verify list now only contains prod-2
      verify(
        () => mockStorageService.saveBagItems(
          any(
            that: predicate<List<BagItem>>(
              (list) => list.length == 1 && list.first.product.id == 'prod-2',
            ),
          ),
        ),
      ).called(1);
    });

    test('updateQuantity updates specific item quantity', () async {
      final items = [BagItem(product: mockProduct1, quantity: 1)];
      when(() => mockStorageService.getBagItems()).thenReturn(items);

      final container = createContainer();
      final repository = container.read(bagRepositoryProvider.notifier);

      await repository.updateQuantity('prod-1', 5);

      verify(
        () => mockStorageService.saveBagItems(
          any(
            that: predicate<List<BagItem>>((list) => list.first.quantity == 5),
          ),
        ),
      ).called(1);
    });

    test('updateQuantity does nothing if item is not found', () async {
      when(() => mockStorageService.getBagItems()).thenReturn([]);

      final container = createContainer();
      final repository = container.read(bagRepositoryProvider.notifier);

      await repository.updateQuantity('prod-1', 5);

      // Since the item isn't there, saveBagItems should NOT be called.
      verifyNever(() => mockStorageService.saveBagItems(any()));
    });

    test('clearBag saves an empty list', () async {
      final container = createContainer();
      final repository = container.read(bagRepositoryProvider.notifier);

      await repository.clearBag();

      verify(() => mockStorageService.saveBagItems([])).called(1);
    });
  });
}
