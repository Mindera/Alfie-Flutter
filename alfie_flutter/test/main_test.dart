import 'package:alfie_flutter/data/models/environment.dart';
import 'package:alfie_flutter/main.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Basic test', (WidgetTester tester) async {
    await Environment.load();

    await tester.pumpWidget(const MainApp());

    expect(find.textContaining('Hello World!'), findsOneWidget);
  });
}
