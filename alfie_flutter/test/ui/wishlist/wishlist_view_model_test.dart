import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:alfie_flutter/data/models/product.dart';
import 'package:alfie_flutter/data/repositories/wishlist_repository.dart';
import 'package:alfie_flutter/ui/wishlist/view_model/wishlist_view_model.dart';

// --- Mocks ---
class MockWishlistRepository extends Mock implements WishlistRepository {}

class MockProduct extends Mock implements Product {}

void main() {
  late MockWishlistRepository mockRepository;
  late MockProduct mockProduct1;
  late MockProduct mockProduct2;

  setUpAll(() {
    // Required by mocktail to use any() with custom types
    registerFallbackValue(MockProduct());
  });

  setUp(() {
    mockRepository = MockWishlistRepository();
    mockProduct1 = MockProduct();
    mockProduct2 = MockProduct();

    // Mocking basic properties if they are needed during equality checks or debugging
    when(() => mockProduct1.id).thenReturn('prod-1');
    when(() => mockProduct2.id).thenReturn('prod-2');
  });

  /// Helper method to create a fresh ProviderContainer for each test
  ProviderContainer createContainer() {
    final container = ProviderContainer(
      overrides: [
        // Inject the mock repository into the provider tree
        wishlistRepositoryProvider.overrideWithValue(mockRepository),
      ],
    );
    addTearDown(container.dispose);
    return container;
  }

  group('WishlistViewModel Tests -', () {
    test('initial state is loaded from the repository', () {
      // Arrange
      final initialItems = [mockProduct1];
      when(() => mockRepository.getWishlist()).thenReturn(initialItems);

      // Act
      final container = createContainer();
      // Note: Using the exact provider name from your file (wihslistViewModelProviders)
      final state = container.read(wihslistViewModelProviders);

      // Assert
      expect(state, initialItems);
      verify(() => mockRepository.getWishlist()).called(1);
    });

    test('addProduct calls repository and updates state', () async {
      // Arrange
      when(() => mockRepository.getWishlist()).thenReturn([]); // Initial state
      final container = createContainer();

      when(() => mockRepository.addToWishlist(any())).thenAnswer((_) async {});
      when(
        () => mockRepository.getWishlist(),
      ).thenReturn([mockProduct1]); // State after addition

      // Act
      await container
          .read(wihslistViewModelProviders.notifier)
          .addProduct(mockProduct1);

      // Assert
      verify(() => mockRepository.addToWishlist(mockProduct1)).called(1);
      expect(container.read(wihslistViewModelProviders), [mockProduct1]);
    });

    test('removeProduct calls repository and updates state', () async {
      // Arrange
      when(
        () => mockRepository.getWishlist(),
      ).thenReturn([mockProduct1, mockProduct2]); // Initial
      final container = createContainer();

      when(
        () => mockRepository.removeFromWishlist('prod-1'),
      ).thenAnswer((_) async {});
      when(
        () => mockRepository.getWishlist(),
      ).thenReturn([mockProduct2]); // State after removal

      // Act
      await container
          .read(wihslistViewModelProviders.notifier)
          .removeProduct('prod-1');

      // Assert
      verify(() => mockRepository.removeFromWishlist('prod-1')).called(1);
      expect(container.read(wihslistViewModelProviders), [mockProduct2]);
    });

    test('clearWishlist calls repository and empties state', () async {
      // Arrange
      when(
        () => mockRepository.getWishlist(),
      ).thenReturn([mockProduct1, mockProduct2]); // Initial
      final container = createContainer();

      when(() => mockRepository.clearWishlists()).thenAnswer((_) async {});

      // Act
      await container.read(wihslistViewModelProviders.notifier).clearWishlist();

      // Assert
      verify(() => mockRepository.clearWishlists()).called(1);
      // The state is explicitly set to [] in the view model, so we expect isEmpty
      expect(container.read(wihslistViewModelProviders), isEmpty);
    });
  });
}
