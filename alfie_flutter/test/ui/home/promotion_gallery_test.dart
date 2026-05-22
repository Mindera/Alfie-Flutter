import 'package:alfie_flutter/ui/home/view_model/home_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:alfie_flutter/ui/core/ui/gallery.dart';
import 'package:alfie_flutter/ui/core/ui/promotion_badge.dart';
import 'package:alfie_flutter/ui/home/view/promotion_gallery.dart';
import 'package:alfie_flutter/ui/home/view_model/home_state.dart';

import '../../../testing/fakes/home_view_mode_fake.dart';

void main() {
  group('PromotionGallery Widget Tests -', () {
    Widget buildSubject(HomeState state) {
      return ProviderScope(
        overrides: [
          homeViewModelProvider.overrideWith(() => FakeHomeViewModel(state)),
        ],
        child: const MaterialApp(home: Scaffold(body: PromotionGallery())),
      );
    }

    testWidgets('renders SizedBox.shrink when promotions list is empty', (
      WidgetTester tester,
    ) async {
      // Inject a state with 0 promotions
      final state = TestHomeState(promotions: const []);

      await tester.pumpWidget(buildSubject(state));
      await tester.pumpAndSettle();

      // Verify the Gallery is not rendered
      expect(find.byType(Gallery), findsNothing);

      // Verify the early return condition (SizedBox.shrink() uses SizedBox)
      expect(find.byType(SizedBox), findsWidgets);
    });

    testWidgets('renders Gallery and maps promotions when list is not empty', (
      WidgetTester tester,
    ) async {
      // Inject a state with mock promotions
      final state = TestHomeState(
        promotions: const [
          PromotionBadge(
            title: 'Promo 1',
            description: 'First promotion description',
          ),
          PromotionBadge(
            title: 'Promo 2',
            description: 'Second promotion description',
          ),
        ],
      );

      await tester.pumpWidget(buildSubject(state));
      await tester.pumpAndSettle();

      // Verify the Gallery is rendered
      expect(find.byType(Gallery), findsOneWidget);

      // Verify the FIRST promotion is visible immediately
      expect(find.text('Promo 1'), findsOneWidget);
      expect(find.text('First promotion description'), findsOneWidget);

      // Swipe left on the Gallery to reveal the second page
      await tester.drag(find.byType(Gallery), const Offset(-800, 0));
      await tester.pumpAndSettle();

      // Verify the SECOND promotion is now visible after swiping
      expect(find.text('Promo 2'), findsOneWidget);
      expect(find.text('Second promotion description'), findsOneWidget);
    });
  });
}
