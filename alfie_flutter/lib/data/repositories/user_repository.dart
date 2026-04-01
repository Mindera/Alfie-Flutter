import 'package:alfie_flutter/data/models/user.dart';
import 'package:alfie_flutter/data/backend/user_backend.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserRepository {
  final IUserBackend _userBackend;

  UserRepository({required IUserBackend userBackend})
    : _userBackend = userBackend;

  List<User> getAllUsers() {
    return _userBackend.getAllUsers();
  }

  User? getUser(String id) {
    return _userBackend.getUser(id);
  }

  User addUser(UserData userData) {
    return _userBackend.addUser(userData);
  }

  void updateUser(User updatedUserData) {
    return _userBackend.updateUser(updatedUserData);
  }

  User deleteUser(String id) {
    return _userBackend.deleteUser(id);
  }
}

final userRepositoryProvider = Provider<UserRepository>(
  (ref) => UserRepository(userBackend: ref.watch(userBackendProvider)),
);
