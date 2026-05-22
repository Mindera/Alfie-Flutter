import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:alfie_flutter/ui/core/themes/app_icons.dart';
import 'package:alfie_flutter/ui/home/view/category_carousel.dart';
import 'package:alfie_flutter/ui/home/view/carousel_section.dart';
import 'package:alfie_flutter/ui/home/view_model/home_state.dart';
import 'package:alfie_flutter/ui/home/view_model/home_view_model.dart';

import '../../../testing/fakes/home_view_mode_fake.dart';

void main() {
  group('CategoryCarousel Widget Tests -', () {
    /// Helper to build the widget under test with the injected fake state
    Widget buildSubject(HomeState state) {
      return ProviderScope(
        overrides: [
          homeViewModelProvider.overrideWith(() => FakeHomeViewModel(state)),
        ],
        child: const MaterialApp(home: Scaffold(body: CategoryCarousel())),
      );
    }

    testWidgets('displays CarouselSection and correctly maps categories', (
      WidgetTester tester,
    ) async {
      // Brands aren't used in CategoryCarousel, so AsyncLoading is perfectly fine to satisfy HomeState here.
      final state = HomeState(brands: const AsyncLoading());

      await tester.pumpWidget(buildSubject(state));
      await tester.pumpAndSettle();

      // Verify the explicitly typed CarouselSection<String> is rendered
      expect(find.byType(CarouselSection<String>), findsOneWidget);

      // Verify the static titles mapped to CarouselSection
      expect(find.text('Shop by Category'), findsOneWidget);
      expect(find.text('View all'), findsOneWidget);

      // The HomeState provides categories "A" through "I" by default.
      // Verify that the labelBuilder successfully extracts and renders them.
      expect(find.text('A'), findsWidgets);
      expect(find.text('B'), findsWidgets);
      expect(find.text('C'), findsWidgets);

      // Verify `itemBuilder` returns the correct UI widget layout containing the placeholder icon
      expect(find.byType(Container), findsWidgets);
      expect(find.byIcon(AppIcons.bag), findsWidgets);
    });
  });
}
