import 'package:alfie_flutter/data/services/auth_backend.dart';
import 'package:alfie_flutter/data/services/persistent_storage_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

abstract interface class IAuthService {
  bool login(String email, String password);
  Future<void> logout();
  DateTime? getTokenExpiration();
}

class AuthService implements IAuthService {
  final IAuthBackend authBackend;
  final IPersistentStorageService persistentStorageService;

  AuthService({
    required this.authBackend,
    required this.persistentStorageService,
  });

  @override
  bool login(String email, String password) {
    final String? accessToken = authBackend.login(email, password);
    if (accessToken == null) return false;

    persistentStorageService.saveAccessToken(accessToken);
    return true;
  }

  @override
  Future<void> logout() async {
    await persistentStorageService.deleteAccessToken();
  }

  @override
  DateTime? getTokenExpiration() {
    final token = persistentStorageService.getAccessToken();
    if (token == null) return null;

    try {
      return JwtDecoder.getExpirationDate(token);
    } catch (_) {
      return null;
    }
  }
}

final authServiceProvider = Provider<IAuthService>(
  (ref) => AuthService(
    authBackend: ref.watch(authBackendProvider),
    persistentStorageService: ref.watch(persistentStorageServiceProvider),
  ),
);
