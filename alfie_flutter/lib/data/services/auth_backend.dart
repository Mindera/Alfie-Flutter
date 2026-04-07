import 'dart:developer';

import 'package:alfie_flutter/data/services/user_backend.dart';
import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

abstract interface class IAuthBackend {
  /// Returns Access token if successful and null if not
  String? login(String email, String password);

  bool verifyToken(String token);
}

class LocalAuthBackend implements IAuthBackend {
  final IUserBackend _userBackend;

  LocalAuthBackend(this._userBackend);

  static const String _mockServerSecret = 'super_secret_local_dev_key_123!';

  @override
  String? login(String email, String password) {
    try {
      final users = _userBackend.getAllUsers();
      final user = users.firstWhere((u) => u.data.email == email);

      if (password == 'pass') {
        log("Logged in user: ${user.data.email}");
        return _generateJwt(
          userId: user.id,
          email: user.data.firstName,
          duration: const Duration(minutes: 30),
        );
      }
    } catch (e) {
      log("Login failed: User not found or incorrect credentials.");
    }
    return null;
  }

  @override
  bool verifyToken(String token) {
    try {
      final jwt = JWT.verify(token, SecretKey(_mockServerSecret));

      final userId = jwt.payload['sub'] as String?;
      if (userId == null) {
        log("Token rejected: Missing user ID (sub claim).");
        return false;
      }

      final user = _userBackend.getUser(userId);
      if (user == null) {
        log(
          "Token rejected: User associated with this token no longer exists.",
        );
        return false;
      }

      log("Token valid. Remaining time: ${JwtDecoder.getRemainingTime(token)}");
      return true;
    } on JWTExpiredException {
      log("Token expired");
      return false;
    }
  }

  String _generateJwt({
    required String userId,
    required String email,
    required Duration duration,
    bool isRefresh = false,
  }) {
    final jwt = JWT({
      'sub': userId,
      'username': email,
      'type': isRefresh ? 'refresh' : 'access',
      'role': 'customer',
    });

    final token = jwt.sign(SecretKey(_mockServerSecret), expiresIn: duration);

    return token;
  }
}

final authBackendProvider = Provider<IAuthBackend>((ref) {
  final userBackend = ref.watch(userBackendProvider);
  return LocalAuthBackend(userBackend);
});
