import 'package:alfie_flutter/data/models/user.dart';
import 'package:alfie_flutter/data/models/user_data.dart';
import 'package:alfie_flutter/data/repositories/auth_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AuthViewModel extends Notifier<User?> {
  late final AuthRepository _authRepository;

  @override
  User? build() {
    _authRepository = ref.watch(authRepositoryProvider.notifier);
    return ref.watch(authRepositoryProvider);
  }

  bool signIn(String email, String password) {
    final success = _authRepository.signIn(email, password);
    if (success) {
      state = ref.read(authRepositoryProvider);
    }
    return success;
  }

  User createAccount(UserData userData) {
    final user = _authRepository.createAccount(userData);
    state = ref.read(authRepositoryProvider);
    return user;
  }

  Future<void> logout() async {
    await _authRepository.logout();
    state = null;
  }
}

final authViewModelProvider = NotifierProvider<AuthViewModel, User?>(
  AuthViewModel.new,
);
