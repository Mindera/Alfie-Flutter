import 'package:alfie_flutter/data/models/user.dart';
import 'package:alfie_flutter/data/backend/auth_backend.dart';
import 'package:alfie_flutter/data/models/user_data.dart';
import 'package:alfie_flutter/data/services/persistent_storage_service.dart';
import 'package:alfie_flutter/data/backend/user_backend.dart';
import 'package:alfie_flutter/data/repositories/user_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

/// Defines the contract for application-level authentication and session management.
abstract interface class IAuthService {
  /// Authenticates a user via [email] and [password], persisting the resulting access token.
  ///
  /// Returns `true` if authentication is successful.
  bool signIn(String email, String password);

  /// Terminates the active session by purging the stored access token.
  Future<void> logout();

  /// Reconstructs the active [User] session from the persisted access token.
  ///
  /// Returns `null` if the token is missing, expired, or cryptographically invalid.
  User? getCurrentUser();

  /// Extracts the expiration timestamp from the currently persisted JWT.
  DateTime? getTokenExpiration();

  /// Registers a new user profile using [userData].
  ///
  /// Throws a generic [Exception] if the email is already associated with an existing account.
  User createAccount(UserData userData);
}

/// Concrete implementation of [IAuthService] coordinating local backends,
/// repositories, and persistent storage layers.
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
    final isExistingEmail = userRepository.isEmailRegistered(userData.email);

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

/// Exposes the active [IAuthService] instance globally via Riverpod.
final authServiceProvider = Provider<IAuthService>(
  (ref) => AuthService(
    authBackend: ref.watch(authBackendProvider),
    persistentStorageService: ref.watch(persistentStorageServiceProvider),
    userBackend: ref.watch(userBackendProvider),
    userRepository: ref.watch(userRepositoryProvider),
  ),
);
