import 'package:alfie_flutter/data/models/user.dart';
import 'package:alfie_flutter/data/models/user_data.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

abstract interface class IUserBackend {
  List<User> getAllUsers();
  User? getUser(String id);
  User addUser(UserData userData);
  void updateUser(User updatedUserData);
  User deleteUser(String id);
}

class LocalUserBackend implements IUserBackend {
  static final List<User> _mockDb = [
    User(
      id: "0a9895ff-8973-4007-b0e0-9533ac82c506",
      data: UserData(
        firstName: 'Alfie',
        lastName: 'Admin',
        email: 'admin@alfie.com',
        phoneNumber: '239002231',
      ),
    ),
  ];

  static const uuid = Uuid();

  @override
  User addUser(UserData userData) {
    final String newId = uuid.v4();
    final User user = User(id: newId, data: userData);
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
  List<User> getAllUsers() => List.unmodifiable(_mockDb);

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

final userBackendProvider = Provider<IUserBackend>((ref) => LocalUserBackend());
