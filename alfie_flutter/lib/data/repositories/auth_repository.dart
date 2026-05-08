import 'dart:async';
import 'dart:developer';
import 'package:alfie_flutter/data/models/user.dart';
import 'package:alfie_flutter/data/models/user_data.dart';
import 'package:alfie_flutter/data/services/auth_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/v4.dart';

/// Manages the current authenticated [User] session and token lifecycle.
class AuthRepository extends Notifier<User?> {
  late IAuthService _authService;
  Timer? _timer;

  /// Initializes the session state and configures automatic token invalidation.
  ///
  /// Evaluates the token expiration from [_authService]. If the token is valid,
  /// schedules a timer to invalidate this provider precisely when the token expires.
  @override
  User? build() {
    _authService = ref.watch(authServiceProvider);

    _timer?.cancel();

    final expiration = _authService.getTokenExpiration();
    if (expiration == null) {
      return null;
    }

    final now = DateTime.now();
    if (expiration.isAfter(now)) {
      _timer = Timer(expiration.difference(now), () => ref.invalidateSelf());
    }
    final user = _authService.getCurrentUser();
    log("User: ${user?.id ?? 'null'}");
    return user;
  }

  /// Attempts to authenticate with the provided credentials.
  ///
  /// Returns `true` and triggers a state rebuild upon success.
  bool signIn(String email, String password) {
    final success = _authService.signIn(email, password);
    if (success) ref.invalidateSelf();
    return success;
  }

  /// Terminates the current session and clears underlying auth data.
  Future<void> logout() async {
    await _authService.logout();
    ref.invalidateSelf();
  }

  /// Registers a new user session using [userData].
  User createAccount(UserData userData) {
    final user = _authService.createAccount(userData);
    ref.invalidateSelf();
    return user;
  }

  /// Instantiates a temporary [GuestUser] session bypassing remote authentication.
  ///
  /// Note: This bypasses [_authService] and resides entirely in local application memory.
  void startGuestSession() {
    final guestId = UuidV4().generate();
    state = GuestUser(id: guestId);
  }
}

/// Orchestrates the global authentication state across the application.
///
/// Dependents of this provider will automatically rebuild during login, logout,
/// or when the underlying access token expires.
final authRepositoryProvider = NotifierProvider<AuthRepository, User?>(
  AuthRepository.new,
);
