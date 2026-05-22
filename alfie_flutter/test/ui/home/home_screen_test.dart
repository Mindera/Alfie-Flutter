import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:alfie_flutter/routing/app_route.dart';
import 'package:alfie_flutter/ui/home/view/brand_carousel.dart';
import 'package:alfie_flutter/ui/home/view/category_carousel.dart';
import 'package:alfie_flutter/ui/home/view/highlights_gallery.dart';
import 'package:alfie_flutter/ui/home/view/home_app_bar.dart';
import 'package:alfie_flutter/ui/home/view/home_screen.dart';
import 'package:alfie_flutter/ui/home/view/promotion_gallery.dart';
import 'package:alfie_flutter/ui/home/view_model/home_view_model.dart';

import '../../../testing/fakes/home_view_mode_fake.dart';

void main() {
  setUp(() {
    // Prevent any rogue NetworkImage calls from throwing HTTP errors
    HttpOverrides.global = null;
  });

  group('HomeScreen Widget Tests -', () {
    /// Helper to build the widget under test with required dependencies
    Widget buildSubject() {
      final router = GoRouter(
        initialLocation: AppRoute.home.fullPath,
        routes: [
          GoRoute(
            path: AppRoute.home.fullPath,
            builder: (context, state) => const HomeScreen(),
          ),
        ],
      );

      return ProviderScope(
        overrides: [
          // Override with our local FakeHomeViewModel instead of the imported one
          homeViewModelProvider.overrideWith(
            () => FakeHomeViewModel(
              TestHomeState(promotions: const [], highlights: const []),
            ),
          ),
        ],
        child: MaterialApp.router(routerConfig: router),
      );
    }

    testWidgets('renders all scrollable sections successfully', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(buildSubject());

      // Because TestHomeState provides 0 highlights AND 0 promotions,
      // NEITHER Gallery has enough items to trigger its autoScroll timer.
      // We can safely use pumpAndSettle() without timing out!
      await tester.pumpAndSettle();

      // Verify the main scrolling layout coordinator is present
      expect(find.byType(CustomScrollView), findsOneWidget);

      // Verify all child components are composed correctly within the tree.
      expect(find.byType(HomeAppBar, skipOffstage: false), findsOneWidget);
      expect(
        find.byType(HighlightsGallery, skipOffstage: false),
        findsOneWidget,
      );
      expect(
        find.byType(PromotionGallery, skipOffstage: false),
        findsOneWidget,
      );
      expect(
        find.byType(CategoryCarousel, skipOffstage: false),
        findsOneWidget,
      );
      expect(find.byType(BrandCarousel, skipOffstage: false), findsOneWidget);

      // Verify the bottom image filler is present
      expect(
        find.byType(SliverFillRemaining, skipOffstage: false),
        findsOneWidget,
      );
    });
  });
}
