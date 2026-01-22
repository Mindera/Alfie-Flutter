import 'package:flutter/material.dart';
import 'data/models/environment.dart';

Future<void> main() async {
  await Environment.load();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Text('Hello World! ${Environment.instance.environmentType}'),
        ),
      ),
    );
  }
}
