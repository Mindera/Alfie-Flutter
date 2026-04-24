import 'package:alfie_flutter/data/models/user.dart';
import 'package:alfie_flutter/data/backend/auth_backend.dart';
import 'package:alfie_flutter/data/models/user_data.dart';
import 'package:alfie_flutter/data/services/persistent_storage_service.dart';
import 'package:alfie_flutter/data/backend/user_backend.dart';
import 'package:alfie_flutter/data/repositories/user_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

abstract interface class IAuthService {
  bool signIn(String email, String password);
  Future<void> logout();
  User? getCurrentUser();
  DateTime? getTokenExpiration();
  User createAccount(UserData userData);
}

class AuthService implements IAuthService {
  final IAuthBackend authBackend;
  final IUserBackend userBackend;
  final IPersistentStorageService persistentStorageService;
  final UserRepository userRepository;

  AuthService({
    required this.authBackend,
    required this.persistentStorageService,
    required this.userBackend,
    required this.userRepository,
  });

  @override
  bool signIn(String email, String password) {
    final String? accessToken = authBackend.signIn(email, password);
    if (accessToken == null) return false;

    persistentStorageService.saveAccessToken(accessToken);
    return true;
  }

  @override
  User createAccount(UserData userData) {
    final isExistingEmail = userRepository.getAllUsers().any(
      (user) => user.data.email.toLowerCase() == userData.email.toLowerCase(),
    );

    if (isExistingEmail) {
      throw Exception('A user with this email already exists.');
    }

    return userRepository.addUser(userData);
  }

  @override
  Future<void> logout() async {
    await persistentStorageService.deleteAccessToken();
  }

  @override
  User? getCurrentUser() {
    final String? token = persistentStorageService.getAccessToken();
    if (token != null) {
      if (authBackend.verifyToken(token)) {
        final decodedToken = JwtDecoder.decode(token);
        final userId = decodedToken['sub'] as String?;

        if (userId != null) {
          return userBackend.getUser(userId);
        }
      }
    }
    return null;
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
    userBackend: ref.watch(userBackendProvider),
    userRepository: ref.watch(userRepositoryProvider),
  ),
);
