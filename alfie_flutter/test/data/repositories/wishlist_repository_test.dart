import 'package:alfie_flutter/data/services/persistent_storage_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:alfie_flutter/data/models/product.dart';
import 'package:alfie_flutter/data/repositories/wishlist_repository.dart';

import '../../../testing/mocks.dart';

void main() {
  late MockPersistentStorageService mockStorageService;
  late WishlistRepository repository;

  late MockProduct mockProduct1;
  late MockProduct mockProduct2;

  setUpAll(() {
    registerFallbackValue(<Product>[]);
  });

  setUp(() {
    mockStorageService = MockPersistentStorageService();
    final container = ProviderContainer(
      overrides: [
        persistentStorageServiceProvider.overrideWithValue(mockStorageService),
      ],
    );
    repository = container.read(wishlistRepositoryProvider);

    mockProduct1 = MockProduct();
    mockProduct2 = MockProduct();

    when(() => mockProduct1.id).thenReturn('prod-1');
    when(() => mockProduct2.id).thenReturn('prod-2');

    when(() => mockStorageService.getWishlist()).thenReturn([]);
    when(() => mockStorageService.saveWishlist(any())).thenAnswer((_) async {});
  });

  group('WishlistRepository Tests - ', () {
    test('getWishlist returns list from storage', () {
      final items = [mockProduct1];
      when(() => mockStorageService.getWishlist()).thenReturn(items);

      final result = repository.getWishlist();

      expect(result.length, 1);
      expect(result.first.id, 'prod-1');
      verify(() => mockStorageService.getWishlist()).called(1);
    });

    test('addToWishlist adds item and saves to storage', () async {
      when(() => mockStorageService.getWishlist()).thenReturn([]);

      await repository.addToWishlist(mockProduct1);

      final captured = verify(
        () => mockStorageService.saveWishlist(captureAny()),
      ).captured;

      final savedList = captured.single as List<Product>;
      expect(savedList.length, 1);
      expect(savedList.first.id, 'prod-1');
    });

    test('removeFromWishlist removes item by productId', () async {
      final items = [mockProduct1, mockProduct2];
      when(() => mockStorageService.getWishlist()).thenReturn(items);

      await repository.removeFromWishlist('prod-1');

      verify(
        () => mockStorageService.saveWishlist(
          any(
            that: predicate<List<Product>>(
              (list) => list.length == 1 && list.first.id == 'prod-2',
            ),
          ),
        ),
      ).called(1);
    });

    test('clearWishlists saves an empty list', () async {
      await repository.clearWishlists();

      verify(() => mockStorageService.saveWishlist([])).called(1);
    });
  });
}
