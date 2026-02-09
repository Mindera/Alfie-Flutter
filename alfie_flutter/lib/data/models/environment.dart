import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

/// A singleton class responsible for managing environment-specific configurations.
///
/// This class abstracts the logic for loading different `.env` files based on the
/// application's build mode (debug vs. release) using the `flutter_dotenv` package.
class Environment {
  static Environment? _instance;

  /// The name of the environment file currently loaded (e.g., `.env.dev` or `.env.prod`).
  final String fileName;

  /// Accesses the singleton instance of [Environment].
  ///
  /// Throws an [Exception] if [load] has not been called before accessing this getter.
  static Environment get instance {
    if (_instance == null) {
      throw ("Environment is not initialized. Please call Environment.load() before accessing the instance.");
    }
    return _instance!;
  }

  /// Private constructor to prevent direct instantiation from outside the class.
  const Environment._({required this.fileName});

  /// Initializes the environment configuration.
  ///
  /// Determines the appropriate `.env` file based on [kReleaseMode]:
  /// * Loads `.env.prod` when the app is running in Release mode.
  /// * Loads `.env.dev` when the app is running in Debug/Profile mode.
  ///
  /// This should be called in the `main()` function before `runApp()`.
  static Future<Environment> load() async {
    String fileName = kReleaseMode ? ".env.prod" : ".env.dev";
    _instance ??= Environment._(fileName: fileName);
    await dotenv.load(fileName: fileName);
    return _instance!;
  }

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
