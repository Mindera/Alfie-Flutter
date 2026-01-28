import 'package:flutter/material.dart';
import 'data/models/environment.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

Future<void> main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();

  // Preserve the splash screen while loading resources
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  // Load environment configurations
  await Environment.load();

  // Start the main application
  runApp(const MainApp());

  // Perform initialization tasks
  await dummyInitialization();
  FlutterNativeSplash.remove();
}

Future<void> dummyInitialization() async {
  if (Environment.instance.isDevelopment) {
    debugPrint('ready in 3...');
  }
  await Future.delayed(const Duration(seconds: 1));
  if (Environment.instance.isDevelopment) {
    debugPrint('ready in 2...');
  }
  await Future.delayed(const Duration(seconds: 1));
  if (Environment.instance.isDevelopment) {
    debugPrint('ready in 1...');
  }
  await Future.delayed(const Duration(seconds: 1));
  if (Environment.instance.isDevelopment) {
    debugPrint('go!');
  }
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.from(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Color.fromARGB(255, 255, 255, 255),
        ),
      ),
      home: Scaffold(
        body: Center(
          child: Text('Hello World! ${Environment.instance.environmentType}'),
        ),
      ),
    );
  }
}
