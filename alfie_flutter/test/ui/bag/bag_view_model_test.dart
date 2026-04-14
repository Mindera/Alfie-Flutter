import 'package:alfie_flutter/ui/bag/view_model/bag_view_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:alfie_flutter/data/models/bag_item.dart';
import 'package:alfie_flutter/data/repositories/bag_repository.dart';

import '../../../testing/mocks.dart';

void main() {
  late MockBagRepository mockRepository;
  late MockProduct mockProduct1;
  late MockProduct mockProduct2;
  late BagItem item1;
  late BagItem item2;

  setUpAll(() {
    // Required by mocktail to use any() with custom types
    registerFallbackValue(BagItem(product: MockProduct(), quantity: 1));
  });

  setUp(() {
    mockRepository = MockBagRepository();
    mockProduct1 = MockProduct();
    mockProduct2 = MockProduct();

    when(() => mockProduct1.id).thenReturn('prod-1');
    when(() => mockProduct2.id).thenReturn('prod-2');

    item1 = BagItem(product: mockProduct1, quantity: 1);
    item2 = BagItem(product: mockProduct2, quantity: 2);
  });

  /// Helper method to create a fresh ProviderContainer for each test
  ProviderContainer createContainer() {
    final container = ProviderContainer(
      overrides: [
        // Inject the mock repository into the provider tree
        bagRepositoryProvider.overrideWithValue(mockRepository),
      ],
    );
    addTearDown(container.dispose);
    return container;
  }

  group('BagViewModel Tests -', () {
    test('initial state is loaded from the repository', () {
      // Arrange
      final initialItems = [item1];
      when(() => mockRepository.getBagItems()).thenReturn(initialItems);

      // Act
      final container = createContainer();
      final state = container.read(bagViewModelProvider);

      // Assert
      expect(state, initialItems);
      verify(() => mockRepository.getBagItems()).called(1);
    });

    test('addItem calls repository and updates state', () async {
      // Arrange
      when(() => mockRepository.getBagItems()).thenReturn([]); // Initial state
      final container = createContainer();

      when(() => mockRepository.addToBag(any())).thenAnswer((_) async {});
      when(
        () => mockRepository.getBagItems(),
      ).thenReturn([item1]); // State after addition

      // Act
      await container.read(bagViewModelProvider.notifier).addItem(item1);

      // Assert
      verify(() => mockRepository.addToBag(item1)).called(1);
      expect(container.read(bagViewModelProvider), [item1]);
    });

    test('removeItem calls repository and updates state', () async {
      // Arrange
      when(
        () => mockRepository.getBagItems(),
      ).thenReturn([item1, item2]); // Initial
      final container = createContainer();

      when(
        () => mockRepository.removeFromBag('prod-1'),
      ).thenAnswer((_) async {});
      when(
        () => mockRepository.getBagItems(),
      ).thenReturn([item2]); // State after removal

      // Act
      await container.read(bagViewModelProvider.notifier).removeItem('prod-1');

      // Assert
      verify(() => mockRepository.removeFromBag('prod-1')).called(1);
      expect(container.read(bagViewModelProvider), [item2]);
    });

    test('updateItemQuantity calls updateQuantity when quantity > 0', () async {
      // Arrange
      when(() => mockRepository.getBagItems()).thenReturn([item1]); // Initial
      final container = createContainer();

      when(
        () => mockRepository.updateQuantity('prod-1', 5),
      ).thenAnswer((_) async {});

      // Setup the mock to return the updated list when getBagItems is called next
      final updatedItem = BagItem(product: mockProduct1, quantity: 5);
      when(() => mockRepository.getBagItems()).thenReturn([updatedItem]);

      // Act
      await container
          .read(bagViewModelProvider.notifier)
          .updateItemQuantity('prod-1', 5);

      // Assert
      verify(() => mockRepository.updateQuantity('prod-1', 5)).called(1);
      expect(container.read(bagViewModelProvider).first.quantity, 5);
    });

    test('updateItemQuantity calls removeItem when quantity <= 0', () async {
      // Arrange
      when(() => mockRepository.getBagItems()).thenReturn([item1]); // Initial
      final container = createContainer();

      when(
        () => mockRepository.removeFromBag('prod-1'),
      ).thenAnswer((_) async {});
      when(
        () => mockRepository.getBagItems(),
      ).thenReturn([]); // State after removal

      // Act
      await container
          .read(bagViewModelProvider.notifier)
          .updateItemQuantity('prod-1', 0);

      // Assert
      verify(() => mockRepository.removeFromBag('prod-1')).called(1);
      // Ensure updateQuantity was NEVER called
      verifyNever(() => mockRepository.updateQuantity(any(), any()));
      expect(container.read(bagViewModelProvider), isEmpty);
    });

    test('total getter delegates to repository', () {
      // Arrange
      when(() => mockRepository.getBagItems()).thenReturn([]); // Initial
      final container = createContainer();

      when(() => mockRepository.total).thenReturn(99.99);

      // Act
      final total = container.read(bagViewModelProvider.notifier).total;

      // Assert
      expect(total, 99.99);
      verify(() => mockRepository.total).called(1);
    });

    test('clearBag clears repository and empties state', () async {
      // Arrange
      when(
        () => mockRepository.getBagItems(),
      ).thenReturn([item1, item2]); // Initial
      final container = createContainer();

      when(() => mockRepository.clearBag()).thenAnswer((_) async {});

      // Act
      await container.read(bagViewModelProvider.notifier).clearBag();

      // Assert
      verify(() => mockRepository.clearBag()).called(1);
      expect(container.read(bagViewModelProvider), isEmpty);
    });
  });
}
