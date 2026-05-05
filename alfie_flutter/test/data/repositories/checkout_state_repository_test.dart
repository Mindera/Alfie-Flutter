import 'package:alfie_flutter/data/repositories/checkout_state_repository.dart';
import 'package:alfie_flutter/data/services/persistent_storage_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../testing/mocks.dart';

void main() {
  late MockPersistentStorageService mockStorageService;
  late CheckoutStateRepository repository;
  late MockCheckoutState mockCheckoutState;

  setUpAll(() {
    registerFallbackValue(MockCheckoutState());
  });

  setUp(() {
    mockStorageService = MockPersistentStorageService();
    mockCheckoutState = MockCheckoutState();

    repository = CheckoutStateRepository(mockStorageService);
  });

  group('CheckoutStateRepository Tests - ', () {
    test('getCheckoutState returns state from storage', () {
      when(
        () => mockStorageService.getCheckoutState(),
      ).thenReturn(mockCheckoutState);

      final result = repository.getCheckoutState();

      expect(result, equals(mockCheckoutState));
      verify(() => mockStorageService.getCheckoutState()).called(1);
    });

    test('getCheckoutState returns null when storage has no saved state', () {
      when(() => mockStorageService.getCheckoutState()).thenReturn(null);

      final result = repository.getCheckoutState();

      expect(result, isNull);
      verify(() => mockStorageService.getCheckoutState()).called(1);
    });

    test(
      'saveCheckoutState delegates state persistence to storage service',
      () async {
        when(
          () => mockStorageService.saveCheckoutState(any()),
        ).thenAnswer((_) async {});

        await repository.saveCheckoutState(mockCheckoutState);

        verify(
          () => mockStorageService.saveCheckoutState(mockCheckoutState),
        ).called(1);
      },
    );
  });

  group('CheckoutStateRepository Provider Test - ', () {
    test(
      'checkoutStateRepositoryProvider creates repository with injected storage service',
      () {
        final container = ProviderContainer(
          overrides: [
            persistentStorageServiceProvider.overrideWithValue(
              mockStorageService,
            ),
          ],
        );

        final providedRepository = container.read(
          checkoutStateRepositoryProvider,
        );

        expect(providedRepository, isA<CheckoutStateRepository>());

        container.dispose();
      },
    );
  });
}
