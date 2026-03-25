import 'dart:developer';

import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

abstract interface class IAuthBackend {
  /// Returns Access token if successful and null if not
  String? login(String username, String password);

  bool verifyToken(String token);
}

class LocalAuthBackend implements IAuthBackend {
  static const String _mockServerSecret = 'super_secret_local_dev_key_123!';

  List<String> validTokens = [];

  @override
  String? login(String username, String password) {
    if (username == 'alfie' && password == 'pass') {
      log("Logged in");
      return _generateJwt(
        userId: '1',
        username: username,
        duration: Duration(seconds: 30),
      );
    }
    return null;
  }

  @override
  bool verifyToken(String token) {
    try {
      JWT.verify(token, SecretKey(_mockServerSecret));
      log("Token remaining time: ${JwtDecoder.getRemainingTime(token)}");
      return true;
    } on Exception {
      log("Token expired");
      return false;
    }
  }

  String _generateJwt({
    required String userId,
    required String username,
    required Duration duration,
    bool isRefresh = false,
  }) {
    final jwt = JWT({
      'sub': userId,
      'username': username,
      'type': isRefresh ? 'refresh' : 'access',
      'role': 'customer',
    });

    final token = jwt.sign(SecretKey(_mockServerSecret), expiresIn: duration);
    validTokens.add(token);

    return token;
  }
}

final authBackendProvider = Provider<IAuthBackend>((ref) => LocalAuthBackend());
