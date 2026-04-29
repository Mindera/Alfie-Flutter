import 'package:alfie_flutter/data/services/auth_service.dart';
import 'package:alfie_flutter/data/repositories/auth_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../testing/mocks.dart';

void main() {
  late MockAuthService mockAuthService;
  late ProviderContainer container;

  late MockRegisteredUser mockUser;
  late MockUserData mockUserData;

  setUp(() {
    mockAuthService = MockAuthService();
    mockUser = MockRegisteredUser();
    mockUserData = MockUserData();

    when(() => mockAuthService.getTokenExpiration()).thenReturn(null);
    when(() => mockAuthService.getCurrentUser()).thenReturn(null);
    when(() => mockUser.id).thenReturn('test-user-id');

    container = ProviderContainer(
      overrides: [authServiceProvider.overrideWithValue(mockAuthService)],
    );
  });

  tearDown(() {
    container.dispose();
  });

  AuthRepository initRepository() {
    container.listen(authRepositoryProvider, (_, _) {});
    return container.read(authRepositoryProvider.notifier);
  }

  group('AuthRepository Tests - ', () {
    test('build returns null when expiration is null', () {
      when(() => mockAuthService.getTokenExpiration()).thenReturn(null);

      initRepository();

      expect(container.read(authRepositoryProvider), isNull);
      verify(() => mockAuthService.getTokenExpiration()).called(1);
      verifyNever(() => mockAuthService.getCurrentUser());
    });

    test(
      'build returns user and sets no timer when expiration is in the past',
      () {
        final pastDate = DateTime.now().subtract(const Duration(days: 1));
        when(() => mockAuthService.getTokenExpiration()).thenReturn(pastDate);
        when(() => mockAuthService.getCurrentUser()).thenReturn(mockUser);

        initRepository();

        expect(container.read(authRepositoryProvider), equals(mockUser));
        verify(() => mockAuthService.getCurrentUser()).called(1);
      },
    );

    test(
      'build returns user and sets timer that triggers invalidateSelf when expiration is in the future',
      () async {
        int buildCount = 0;
        when(() => mockAuthService.getTokenExpiration()).thenAnswer((_) {
          buildCount++;
          // First build: set a short future expiration to trigger the timer
          // Second build (after invalidation): return null to avoid infinite loops
          return buildCount == 1
              ? DateTime.now().add(const Duration(milliseconds: 50))
              : null;
        });
        when(() => mockAuthService.getCurrentUser()).thenReturn(mockUser);

        initRepository();

        expect(container.read(authRepositoryProvider), equals(mockUser));

        // Wait for the Timer to execute and invalidate the provider
        await Future.delayed(const Duration(milliseconds: 100));

        // Verify that build() ran a second time because of the Timer's invalidateSelf
        verify(() => mockAuthService.getTokenExpiration()).called(2);
      },
    );

    test('signIn invalidates state and returns true on successful login', () {
      final repository = initRepository();
      when(
        () => mockAuthService.signIn('test@email.com', 'password'),
      ).thenReturn(true);

      when(() => mockAuthService.getTokenExpiration()).thenReturn(null);

      final result = repository.signIn('test@email.com', 'password');

      expect(result, isTrue);
      // Invalidation causes a rebuild, fetching expiration again
      verify(() => mockAuthService.getTokenExpiration()).called(1);
    });

    test(
      'signIn returns false and does not invalidate state on failed login',
      () {
        final repository = initRepository();
        clearInteractions(mockAuthService);
        when(
          () => mockAuthService.signIn('test@email.com', 'wrong_pass'),
        ).thenReturn(false);

        final result = repository.signIn('test@email.com', 'wrong_pass');

        expect(result, isFalse);

        verifyNever(() => mockAuthService.getTokenExpiration());
      },
    );

    test('logout delegates to service and invalidates state', () async {
      final repository = initRepository();
      when(() => mockAuthService.logout()).thenAnswer((_) async {});

      when(() => mockAuthService.getTokenExpiration()).thenReturn(null);

      await repository.logout();

      verify(() => mockAuthService.logout()).called(1);
      // Verify rebuild occurred
      verify(() => mockAuthService.getTokenExpiration()).called(1);
    });

    test('createAccount delegates to service and invalidates state', () {
      final repository = initRepository();
      when(
        () => mockAuthService.createAccount(mockUserData),
      ).thenReturn(mockUser);

      when(() => mockAuthService.getTokenExpiration()).thenReturn(null);

      final result = repository.createAccount(mockUserData);

      expect(result, equals(mockUser));
      verify(() => mockAuthService.createAccount(mockUserData)).called(1);
      // Verify rebuild occurred
      verify(() => mockAuthService.getTokenExpiration()).called(1);
    });
  });
}
