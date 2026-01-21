import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class Environment {
  static Environment? _instance;
  final String fileName;

  static Environment get instance {
    if (_instance == null) {
      throw ("Environment is not initialized. Please call Environment.load() before accessing the instance.");
    }
    return _instance!;
  }

  const Environment._({required this.fileName});

  static Future<Environment> load() async {
    String fileName = kReleaseMode ? ".env.prod" : ".env.dev";
    _instance ??= Environment._(fileName: fileName);
    await dotenv.load(fileName: fileName);
    return _instance!;
  }

  bool get isProduction {
    return kReleaseMode;
  }

  bool get isDevelopment {
    return !kReleaseMode;
  }

  String get environmentType {
    return dotenv.env['ENV'] ?? 'ERROR NO ENV VARIABLE';
  }
}
