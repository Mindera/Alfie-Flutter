import 'package:alfie_flutter/data/backend/user_backend.dart';
import 'package:alfie_flutter/data/models/user.dart';
import 'package:alfie_flutter/data/repositories/user_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../testing/mocks.dart';

void main() {
  late MockUserBackend mockUserBackend;
  late UserRepository repository;
  late ProviderContainer container;

  late MockRegisteredUser mockUser;
  late MockRegisteredUser mockRegisteredUser;
  late MockUserData mockUserData;

  setUp(() {
    mockUserBackend = MockUserBackend();
    mockUser = MockRegisteredUser();
    mockRegisteredUser = MockRegisteredUser();
    mockUserData = MockUserData();

    // Setup the ProviderContainer with the mocked backend
    container = ProviderContainer(
      overrides: [userBackendProvider.overrideWithValue(mockUserBackend)],
    );

    repository = container.read(userRepositoryProvider);
  });

  tearDown(() {
    container.dispose();
  });

  group('UserRepository Tests - ', () {
    test('getAllUsers delegates to backend', () {
      // getAllUsers now expects RegisteredUser instances
      final users = <RegisteredUser>[mockRegisteredUser];

      // Mocking the backend to return the specific subclass
      when(() => mockUserBackend.getAllUsers()).thenReturn(users);

      final result = repository.getAllUsers();

      expect(result, equals(users));
      verify(() => mockUserBackend.getAllUsers()).called(1);
    });

    test('getUser returns user from backend when id exists', () {
      const userId = 'user-123';
      when(() => mockUserBackend.getUser(userId)).thenReturn(mockUser);

      final result = repository.getUser(userId);

      expect(result, equals(mockUser));
      verify(() => mockUserBackend.getUser(userId)).called(1);
    });

    test('getUser returns null when user does not exist', () {
      const userId = 'non-existent';
      when(() => mockUserBackend.getUser(userId)).thenReturn(null);

      final result = repository.getUser(userId);

      expect(result, isNull);
      verify(() => mockUserBackend.getUser(userId)).called(1);
    });

    test('addUser delegates to backend and returns the new user', () {
      when(
        () => mockUserBackend.addUser(mockUserData),
      ).thenReturn(mockRegisteredUser);

      final result = repository.addUser(mockUserData);

      expect(result, equals(mockRegisteredUser));
      verify(() => mockUserBackend.addUser(mockUserData)).called(1);
    });

    test('updateUser delegates to backend', () {
      // Void method verification
      when(() => mockUserBackend.updateUser(mockUser)).thenReturn(null);

      repository.updateUser(mockUser);

      verify(() => mockUserBackend.updateUser(mockUser)).called(1);
    });

    test('deleteUser delegates to backend and returns the deleted user', () {
      const userId = 'delete-me';
      when(() => mockUserBackend.deleteUser(userId)).thenReturn(mockUser);

      final result = repository.deleteUser(userId);

      expect(result, equals(mockUser));
      verify(() => mockUserBackend.deleteUser(userId)).called(1);
    });

    test(
      'isEmailRegistered returns true if email exists (case insensitive)',
      () {
        when(() => mockUserData.email).thenReturn('Test@Alfie.com');
        when(() => mockRegisteredUser.data).thenReturn(mockUserData);
        when(
          () => mockUserBackend.getAllUsers(),
        ).thenReturn(<RegisteredUser>[mockRegisteredUser]);

        final result = repository.isEmailRegistered('test@alfie.com');

        expect(result, isTrue);
        verify(() => mockUserBackend.getAllUsers()).called(1);
      },
    );

    test('isEmailRegistered returns false if email does not exist', () {
      when(() => mockUserData.email).thenReturn('admin@alfie.com');
      when(() => mockRegisteredUser.data).thenReturn(mockUserData);
      when(
        () => mockUserBackend.getAllUsers(),
      ).thenReturn(<RegisteredUser>[mockRegisteredUser]);

      final result = repository.isEmailRegistered('test@alfie.com');

      expect(result, isFalse);
      verify(() => mockUserBackend.getAllUsers()).called(1);
    });
  });

  group('UserRepository Provider Test - ', () {
    test('userRepositoryProvider provides a UserRepository instance', () {
      final providedRepository = container.read(userRepositoryProvider);
      expect(providedRepository, isA<UserRepository>());
    });
  });
}
