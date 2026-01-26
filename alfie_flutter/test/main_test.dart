import 'package:alfie_flutter/data/models/environment.dart';
import 'package:alfie_flutter/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Basic test', (WidgetTester tester) async {
    // Handle any async loading (like your Environment)
    await Environment.load();

    // Wrap MainApp in ProviderScope
    await tester.pumpWidget(const ProviderScope(child: MainApp()));

    // GoRouter is asynchronous. pump() only triggers one frame.
    // pumpAndSettle() waits until all animations and routing are finished.
    await tester.pumpAndSettle();

    // Check for your text
    expect(find.byType(MaterialApp), findsOneWidget);
  });
}
