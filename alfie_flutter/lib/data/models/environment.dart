import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// A class responsible for managing environment-specific configurations.
///
/// This class abstracts the logic for loading different `.env` files based on the
/// application's build mode (debug vs. release) using the `flutter_dotenv` package.
class Environment {
  /// The name of the environment file currently loaded (e.g., `.env.dev` or `.env.prod`).
  final String fileName;

  /// Private constructor to prevent direct instantiation from outside the class.
  const Environment({required this.fileName});

  /// Returns `true` if the application is running in Release mode.
  bool get isProduction {
    return kReleaseMode;
  }

  /// Returns `true` if the application is running in Debug or Profile mode.
  bool get isDevelopment {
    return !kReleaseMode;
  }

  /// Retrieves the value of the 'ENV' key from the loaded `.env` file.
  ///
  /// Returns 'ERROR NO ENV VARIABLE' if the key is missing or the file is not loaded.
  String get environmentType {
    return dotenv.env['ENV'] ?? 'ERROR NO ENV VARIABLE';
  }

  /// Retrieves the value of the 'GRAPHQL_SERVER' key from the loaded `.env` file.
  ///
  /// Returns 'ERROR NO ENV VARIABLE' if the key is missing or the file is not loaded.
  String get graphqlServerUrl {
    return dotenv.env['GRAPHQL_SERVER'] ?? 'ERROR NO ENV VARIABLE';
  }
}

final environmentProvider = Provider<Environment>((ref) {
  String fileName = kReleaseMode ? ".env.prod" : ".env.dev";
  return Environment(fileName: fileName);
});
