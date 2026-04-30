import 'dart:async';
import 'dart:developer';

import 'package:alfie_flutter/data/models/address.dart';
import 'package:alfie_flutter/data/models/user.dart';
import 'package:alfie_flutter/data/models/user_data.dart';
import 'package:alfie_flutter/data/services/auth_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/v4.dart';

class AuthRepository extends Notifier<User?> {
  late IAuthService _authService;
  Timer? _timer;

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

  bool signIn(String email, String password) {
    final success = _authService.signIn(email, password);
    if (success) ref.invalidateSelf();
    return success;
  }

  Future<void> logout() async {
    await _authService.logout();
    ref.invalidateSelf();
  }

  User createAccount(UserData userData) {
    final user = _authService.createAccount(userData);
    ref.invalidateSelf();
    return user;
  }

  User continueAsGuestUser(
    UserData userData,
    Address deliveryAddress,
    Address billingAddress,
  ) {
    final guestUser = User(
      id: UuidV4().generate(),
      data: userData,
      deliveryAddress: deliveryAddress,
      billingAddress: billingAddress,
    );
    state = guestUser;
    return guestUser;
  }
}

final authRepositoryProvider = NotifierProvider(AuthRepository.new);
