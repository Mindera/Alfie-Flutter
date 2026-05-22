import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:alfie_flutter/data/models/brand.dart';
import 'package:alfie_flutter/ui/home/view/brand_carousel.dart';
import 'package:alfie_flutter/ui/home/view/carousel_section.dart';
import 'package:alfie_flutter/ui/home/view_model/home_state.dart';
import 'package:alfie_flutter/ui/home/view_model/home_view_model.dart';

import '../../../testing/fakes/home_view_mode_fake.dart';

void main() {
  group('BrandCarousel Widget Tests -', () {
    /// Helper to build the widget under test with the injected fake state
    Widget buildSubject(HomeState state) {
      return ProviderScope(
        overrides: [
          homeViewModelProvider.overrideWith(() => FakeHomeViewModel(state)),
        ],
        child: const MaterialApp(home: Scaffold(body: BrandCarousel())),
      );
    }

    testWidgets('displays loading indicator when brands state is loading', (
      WidgetTester tester,
    ) async {
      final state = HomeState(brands: const AsyncLoading());

      await tester.pumpWidget(buildSubject(state));

      // CarouselSection shouldn't be present
      expect(find.byType(CarouselSection), findsNothing);
      // Fallback assertion since AppIcons.progressIndicator is loaded via Center
      expect(find.byType(Center), findsOneWidget);
    });

    testWidgets('displays error message when brands state has error', (
      WidgetTester tester,
    ) async {
      final error = Exception('Failed to load brands');
      final state = HomeState(brands: AsyncError(error, StackTrace.empty));

      await tester.pumpWidget(buildSubject(state));

      // Verify the error text is rendered correctly
      expect(find.text('Exception: Failed to load brands'), findsOneWidget);
      expect(find.byType(Center), findsOneWidget);
      expect(find.byType(CarouselSection), findsNothing);
    });

    testWidgets(
      'displays CarouselSection and correctly maps brands when data is loaded',
      (WidgetTester tester) async {
        final mockBrands = [
          Brand(id: 'brand-1', name: 'Nike'),
          Brand(id: 'brand-2', name: 'Adidas'),
        ];
        final state = HomeState(brands: AsyncData(mockBrands));

        await tester.pumpWidget(buildSubject(state));
        await tester.pumpAndSettle();

        // Verify the CarouselSection<Brand> is rendered (explicitly define the generic type)
        expect(find.byType(CarouselSection<Brand>), findsOneWidget);

        // Verify the static titles mapped to CarouselSection
        expect(find.text('Shop by Brand'), findsOneWidget);
        expect(find.text('See all'), findsOneWidget);

        // Verify `labelBuilder` maps the names correctly to the UI
        expect(find.text('Nike'), findsOneWidget);
        expect(find.text('Adidas'), findsOneWidget);

        // Verify `itemBuilder` returns the correct UI widget layout containing the placeholder Image
        expect(find.byType(Container), findsWidgets);
        expect(find.byType(Image), findsNWidgets(2));
      },
    );
  });
}
