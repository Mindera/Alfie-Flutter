import 'package:alfie_flutter/data/models/payment_card.dart';
import 'package:alfie_flutter/data/models/user.dart';
import 'package:alfie_flutter/data/models/user_data.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

/// Temporary mock user data contract for local development.
///
/// Simulates external GraphQL user mutations and queries.
abstract interface class IUserBackend {
  /// Retrieves the complete list of locally mocked [RegisteredUser] instances.
  List<RegisteredUser> getAllUsers();

  /// Fetches a specific [User] by their unique [id].
  ///
  /// Returns `null` if the user is not found.
  User? getUser(String id);

  /// Simulates a user registration mutation for [userData], generating a new UUID.
  User addUser(UserData userData);

  /// Overwrites existing data for an already registered [updatedUserData].
  void updateUser(User updatedUserData);

  /// Simulates account deletion, removing the user matching [id] from the local memory store.
  ///
  /// Throws an [Exception] if the user does not exist.
  User deleteUser(String id);
}

/// In-memory implementation of [IUserBackend] for simulating user persistence.
class LocalUserBackend implements IUserBackend {
  static final List<User> _mockDb = [
    const RegisteredUser(
      id: "0a9895ff-8973-4007-b0e0-9533ac82c506",
      data: UserData(
        firstName: 'Alfie',
        lastName: 'Admin',
        email: 'admin@alfie.com',
        phoneNumber: '239002231',
      ),
      paymentCards: [PaymentCard.sample],
    ),
  ];

  static const uuid = Uuid();

  @override
  User addUser(UserData userData) {
    final String newId = uuid.v4();
    final User user = RegisteredUser(
      id: newId,
      data: userData,
      paymentCards: [],
    );
    _mockDb.add(user);
    return user;
  }

  @override
  User deleteUser(String id) {
    final user = getUser(id);
    if (user == null) throw Exception("User not found");
    _mockDb.removeWhere((u) => u.id == id);
    return user;
  }

  @override
  List<RegisteredUser> getAllUsers() => List.unmodifiable(_mockDb);

  @override
  User? getUser(String id) {
    try {
      return _mockDb.firstWhere((u) => u.id == id);
    } catch (e) {
      return null;
    }
  }

  @override
  void updateUser(User user) {
    final index = _mockDb.indexWhere((u) => u.id == user.id);
    if (index != -1) {
      _mockDb[index] = user;
    }
  }
}

/// Provides the active [IUserBackend] implementation.
///
/// Defaults to [LocalUserBackend]
final userBackendProvider = Provider<IUserBackend>((ref) => LocalUserBackend());
