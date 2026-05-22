import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Manages build-specific configuration variables loaded from `.env` files.
class Environment {
  /// The name of the environment file currently loaded (e.g., `.env.dev` or `.env.prod`).
  final String fileName;

  const Environment({required this.fileName});

  bool get isProduction => kReleaseMode;

  bool get isDevelopment => !kReleaseMode;

  /// Retrieves the 'ENV' key from the loaded configuration.
  ///
  /// Returns 'ERROR NO ENV VARIABLE' if the key is missing or the file is not loaded.
  String get environmentType {
    return dotenv.env['ENV'] ?? 'ERROR NO ENV VARIABLE';
  }

  /// Retrieves the 'GRAPHQL_SERVER' key from the loaded configuration.
  ///
  /// Returns 'ERROR NO ENV VARIABLE' if the key is missing or the file is not loaded.
  String get graphqlServerUrl {
    return dotenv.env['GRAPHQL_SERVER'] ?? 'ERROR NO ENV VARIABLE';
  }
}

/// Provides the active [Environment] configuration based on the current compilation mode.
final environmentProvider = Provider<Environment>((ref) {
  final String fileName = kReleaseMode ? ".env.prod" : ".env.dev";
  return Environment(fileName: fileName);
});
