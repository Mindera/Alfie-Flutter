import 'dart:developer';

import 'package:alfie_flutter/data/services/persistent_storage_service.dart';
import 'package:alfie_flutter/global_keys.dart';
import 'package:alfie_flutter/routing/router.dart';
import 'package:alfie_flutter/ui/core/themes/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'data/models/environment.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

/// The primary entry point for the application.
///
/// Bootstraps critical infrastructure, including environment variables,
/// persistent storage engines, and GraphQL caches, before handing off
/// execution to the Flutter engine.
Future<void> main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();

  // Preserve the splash screen while loading resources
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  // Required for GraphQL HiveStore persistence
  log("Loading Hive for GraphQL...");
  await initHiveForFlutter();

  // Maintaining the status bar visible
  SystemChrome.setEnabledSystemUIMode(
    SystemUiMode.manual,
    overlays: [SystemUiOverlay.top],
  );

  log("Loading Persistent Storage Service...");
  final container = ProviderContainer();

  log("Loading environment configurations...");
  await dotenv.load(fileName: container.read(environmentProvider).fileName);

  final persistentStorageService = container.read(
    persistentStorageServiceProvider,
  );
  await persistentStorageService.init();

  log("Starting the application...");
  runApp(const ProviderScope(child: MainApp()));

  // Remove the splash screen after initialization is complete
  FlutterNativeSplash.remove();
  log("Running Alfie!");
}

/// The root material application widget.
///
/// Consumes global routing, theming, and messenger configurations from Riverpod
/// to initialize the presentation layer.
class MainApp extends ConsumerWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);
    final theme = ref.watch(themeProvider);

    return MaterialApp.router(
      scaffoldMessengerKey: ref.watch(scaffoldMessengerKeyProvider),
      debugShowCheckedModeBanner: false,
      title: "Alfie",
      theme: theme,
      routerConfig: router,
    );
  }
}
