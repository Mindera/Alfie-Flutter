import 'dart:async';

import 'package:alfie_flutter/data/services/auth_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AuthRepository extends Notifier<bool> {
  late IAuthService _authService;
  Timer? _timer;

  @override
  bool build() {
    _authService = ref.watch(authServiceProvider);

    _timer?.cancel();

    final expiration = _authService.getTokenExpiration();
    if (expiration == null) {
      return false;
    }

    final now = DateTime.now();
    if (expiration.isAfter(now)) {
      _timer = Timer(expiration.difference(now), () => ref.invalidateSelf());
      return true;
    }

    _authService.logout();
    ref.onDispose(() => _timer?.cancel());
    return false;
  }

  void login(String username, String password) {
    final success = _authService.login(username, password);
    state = success;
    if (success) ref.invalidateSelf();
  }

  void logout() {
    _authService.logout();
    state = false;
    ref.invalidateSelf();
  }
}

final authRepositoryProvider = NotifierProvider(AuthRepository.new);
