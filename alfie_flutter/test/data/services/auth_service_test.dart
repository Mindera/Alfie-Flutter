import 'dart:convert';

import 'package:alfie_flutter/data/backend/auth_backend.dart';
import 'package:alfie_flutter/data/backend/user_backend.dart';
import 'package:alfie_flutter/data/repositories/user_repository.dart';
import 'package:alfie_flutter/data/services/auth_service.dart';
import 'package:alfie_flutter/data/services/persistent_storage_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../testing/mocks.dart';

void main() {
  late MockAuthBackend mockAuthBackend;
  late MockUserBackend mockUserBackend;
  late MockPersistentStorageService mockPersistentStorageService;
  late MockUserRepository mockUserRepository;
  late AuthService authService;
  late ProviderContainer container;

  late MockUser mockUser;
  late MockUserData mockUserData;

  // Generate a valid JWT structure to satisfy the static JwtDecoder methods.
  // Payload: {"sub":"test-user-id","exp":2524608000} (Exp: Jan 1, 2050)
  final String validPayload = base64Url
      .encode(utf8.encode('{"sub":"test-user-id","exp":2524608000}'))
      .replaceAll('=', '');
  final String mockValidJwt = 'header.$validPayload.signature';
  final String mockInvalidJwt = 'not.a.token';

  setUpAll(() {
    registerFallbackValue(MockUserData());
  });

  setUp(() {
    mockAuthBackend = MockAuthBackend();
    mockUserBackend = MockUserBackend();
    mockPersistentStorageService = MockPersistentStorageService();
    mockUserRepository = MockUserRepository();

    mockUser = MockUser();
    mockUserData = MockUserData();

    authService = AuthService(
      authBackend: mockAuthBackend,
      persistentStorageService: mockPersistentStorageService,
      userBackend: mockUserBackend,
      userRepository: mockUserRepository,
    );

    container = ProviderContainer(
      overrides: [
        authBackendProvider.overrideWithValue(mockAuthBackend),
        persistentStorageServiceProvider.overrideWithValue(
          mockPersistentStorageService,
        ),
        userBackendProvider.overrideWithValue(mockUserBackend),
        userRepositoryProvider.overrideWithValue(mockUserRepository),
      ],
    );
  });

  tearDown(() {
    container.dispose();
  });

  group('AuthService Tests - ', () {
    group('signIn - ', () {
      test('returns true and saves token on success', () {
        when(
          () => mockAuthBackend.signIn('test@email.com', 'password'),
        ).thenReturn(mockValidJwt);
        when(
          () => mockPersistentStorageService.saveAccessToken(mockValidJwt),
        ).thenAnswer((_) async {});

        final result = authService.signIn('test@email.com', 'password');

        expect(result, isTrue);
        verify(
          () => mockAuthBackend.signIn('test@email.com', 'password'),
        ).called(1);
        verify(
          () => mockPersistentStorageService.saveAccessToken(mockValidJwt),
        ).called(1);
      });

      test('returns false and does not save token on failure', () {
        when(
          () => mockAuthBackend.signIn('test@email.com', 'wrong_pass'),
        ).thenReturn(null);

        final result = authService.signIn('test@email.com', 'wrong_pass');

        expect(result, isFalse);
        verifyNever(() => mockPersistentStorageService.saveAccessToken(any()));
      });
    });

    group('createAccount - ', () {
      test('throws Exception if email already exists (case-insensitive)', () {
        final existingUser = MockUser();
        final existingData = MockUserData();

        when(() => existingData.email).thenReturn('Test@Email.com');
        when(() => existingUser.data).thenReturn(existingData);
        when(() => mockUserData.email).thenReturn('test@email.com');
        when(
          () => mockUserRepository.isEmailRegistered('test@email.com'),
        ).thenReturn(true);

        expect(
          () => authService.createAccount(mockUserData),
          throwsA(
            isA<Exception>().having(
              (e) => e.toString(),
              'message',
              contains('already exists'),
            ),
          ),
        );
        verifyNever(() => mockUserRepository.addUser(any()));
      });

      test('adds user if email is unique', () {
        when(
          () => mockUserRepository.isEmailRegistered('new@email.com'),
        ).thenReturn(false);
        when(() => mockUserData.email).thenReturn('new@email.com');
        when(
          () => mockUserRepository.addUser(mockUserData),
        ).thenReturn(mockUser);

        final result = authService.createAccount(mockUserData);

        expect(result, equals(mockUser));
        verify(() => mockUserRepository.addUser(mockUserData)).called(1);
      });
    });

    group('logout - ', () {
      test('deletes access token from persistent storage', () async {
        when(
          () => mockPersistentStorageService.deleteAccessToken(),
        ).thenAnswer((_) async {});

        await authService.logout();

        verify(
          () => mockPersistentStorageService.deleteAccessToken(),
        ).called(1);
      });
    });

    group('getCurrentUser - ', () {
      test('returns null if token is null', () {
        when(
          () => mockPersistentStorageService.getAccessToken(),
        ).thenReturn(null);

        final result = authService.getCurrentUser();

        expect(result, isNull);
        verifyNever(() => mockAuthBackend.verifyToken(any()));
      });

      test('returns null if token verification fails', () {
        when(
          () => mockPersistentStorageService.getAccessToken(),
        ).thenReturn(mockValidJwt);
        when(() => mockAuthBackend.verifyToken(mockValidJwt)).thenReturn(false);

        final result = authService.getCurrentUser();

        expect(result, isNull);
        verifyNever(() => mockUserBackend.getUser(any()));
      });

      test('returns user if token is valid, verified, and subject exists', () {
        when(
          () => mockPersistentStorageService.getAccessToken(),
        ).thenReturn(mockValidJwt);
        when(() => mockAuthBackend.verifyToken(mockValidJwt)).thenReturn(true);
        when(
          () => mockUserBackend.getUser('test-user-id'),
        ).thenReturn(mockUser);

        final result = authService.getCurrentUser();

        expect(result, equals(mockUser));
        verify(() => mockUserBackend.getUser('test-user-id')).called(1);
      });
    });

    group('getTokenExpiration - ', () {
      test('returns null if token is null', () {
        when(
          () => mockPersistentStorageService.getAccessToken(),
        ).thenReturn(null);

        final result = authService.getTokenExpiration();

        expect(result, isNull);
      });

      test('returns null if token decoding throws an exception', () {
        when(
          () => mockPersistentStorageService.getAccessToken(),
        ).thenReturn(mockInvalidJwt);

        final result = authService.getTokenExpiration();

        expect(result, isNull);
      });

      test('returns DateTime when token is valid', () {
        when(
          () => mockPersistentStorageService.getAccessToken(),
        ).thenReturn(mockValidJwt);

        final result = authService.getTokenExpiration();

        // 2524608000 seconds since epoch is Jan 1, 2050
        expect(result, isNotNull);
        expect(result?.year, 2050);
      });
    });
  });

  group('AuthService Provider Test - ', () {
    test(
      'authServiceProvider creates AuthService with injected dependencies',
      () {
        final providedService = container.read(authServiceProvider);
        expect(providedService, isA<AuthService>());
      },
    );
  });
}
