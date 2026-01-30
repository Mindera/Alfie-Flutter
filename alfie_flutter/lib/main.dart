import 'package:alfie_flutter/routing/router.dart';
import 'package:alfie_flutter/ui/core/themes/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'data/models/environment.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

Future<void> main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();

  // Preserve the splash screen while loading resources
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  // Load environment configurations
  await Environment.load();

  // Start the main application wrapped in a ProviderScope so Riverpod
  // providers are available throughout the widget tree.
  runApp(const ProviderScope(child: MainApp()));

  // Perform initialization tasks
  // Here we can load resources, initialize services, etc.
  await dummyInitialization();

  // Remove the splash screen after initialization is complete
  FlutterNativeSplash.remove();
}

Future<void> dummyInitialization() async {
  if (Environment.instance.isDevelopment) {
    debugPrint('ready in 3...');
  }
  await Future.delayed(const Duration(milliseconds: 500));
  if (Environment.instance.isDevelopment) {
    debugPrint('ready in 2...');
  }
  await Future.delayed(const Duration(milliseconds: 500));
  if (Environment.instance.isDevelopment) {
    debugPrint('ready in 1...');
  }
  await Future.delayed(const Duration(milliseconds: 500));
  if (Environment.instance.isDevelopment) {
    debugPrint('go!');
  }
}

class MainApp extends ConsumerWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: "Alfie",
      theme: ref.read(themeProvider),
      routerConfig: router,
    );
  }
}
