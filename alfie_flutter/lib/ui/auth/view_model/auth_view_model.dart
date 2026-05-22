import 'package:alfie_flutter/data/models/user.dart';
import 'package:alfie_flutter/data/models/user_data.dart';
import 'package:alfie_flutter/data/repositories/auth_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Orchestrates authentication actions originating from the presentation layer.
///
/// Wraps the underlying [AuthRepository] to manage local presentation state
/// and dispatch session mutation intents.
final authViewModelProvider = NotifierProvider<AuthViewModel, User?>(
  AuthViewModel.new,
);

/// State controller for the active user session exposed to the UI.
class AuthViewModel extends Notifier<User?> {
  late final AuthRepository _authRepository;

  @override
  User? build() {
    _authRepository = ref.watch(authRepositoryProvider.notifier);
    return ref.watch(authRepositoryProvider);
  }

  /// Dispatches a sign-in intent with [email] and [password].
  ///
  /// Manually synchronizes the local state with the repository upon success.
  bool signIn(String email, String password) {
    final success = _authRepository.signIn(email, password);
    if (success) {
      state = ref.read(authRepositoryProvider);
    }
    return success;
  }

  /// Dispatches a registration intent utilizing [userData].
  User createAccount(UserData userData) {
    final user = _authRepository.createAccount(userData);
    state = ref.read(authRepositoryProvider);
    return user;
  }

  /// Terminates the active user session and clears local state.
  Future<void> logout() async {
    await _authRepository.logout();
    state = null;
  }
}
