import 'package:alfie_flutter/ui/core/view_model/scroll_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../testing/fakes/scroll_widget_fake.dart';

void main() {
  // Helper to reduce duplicated setup across tests.
  Future<MockScrollWidgetState> pumpMockWidget(WidgetTester tester) async {
    await tester.pumpWidget(const ProviderScope(child: MockScrollWidget()));
    // Ensure the widget settles and the ScrollController is attached
    await tester.pumpAndSettle();
    return tester.state<MockScrollWidgetState>(find.byType(MockScrollWidget));
  }

  testWidgets("ScrollToTopMixin initializes ScrollController", (
    WidgetTester tester,
  ) async {
    // 1. Arrange: Render the widget and get its state
    final state = await pumpMockWidget(tester);
    expect(state.scrollController, isNotNull);
    expect(state.scrollController.hasClients, isTrue);
  });

  testWidgets('ScrollToTopMixin scrolls to top when provider triggers', (
    WidgetTester tester,
  ) async {
    // 1. Arrange: Render the widget and get its state
    final state = await pumpMockWidget(tester);
    final controller = state.scrollController;

    // 2. Scroll down manually
    await tester.drag(find.byType(ListView), const Offset(0, -500));
    await tester.pumpAndSettle();
    expect(controller.offset, equals(500.0));

    // 3. Act: Trigger the scroll provider
    // We get the container to manually change the state of the scrollProvider
    final container = ProviderScope.containerOf(
      tester.element(find.byType(MockScrollWidget)),
    );

    container.read(scrollProvider(state.route.name).notifier).triggerReset();

    // 4. Assert: Check if it animates back to 0
    await tester.pumpAndSettle();
    expect(controller.offset, equals(0.0));
  });

  testWidgets('ScrollController is disposed when widget is removed', (
    WidgetTester tester,
  ) async {
    final state = await pumpMockWidget(tester);
    final controller = state.scrollController;

    // Remove widget
    await tester.pumpWidget(const SizedBox());

    // Checking if controller is disposed
    expect(() => controller.addListener(() {}), throwsFlutterError);
  });
}
