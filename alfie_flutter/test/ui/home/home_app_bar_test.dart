import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';

import 'package:alfie_flutter/routing/app_route.dart';
import 'package:alfie_flutter/ui/core/ui/search/search.dart';
import 'package:alfie_flutter/ui/home/view/home_app_bar.dart';

void main() {
  group('HomeAppBar Widget Tests -', () {
    /// Helper to build the widget under test within a GoRouter configuration
    /// to accurately test the routing extension logic.
    Widget buildSubject() {
      final router = GoRouter(
        initialLocation: '/',
        routes: [
          GoRoute(
            path: '/',
            builder: (context, state) => const Scaffold(
              // HomeAppBar requires a CustomScrollView because it is a Sliver
              body: CustomScrollView(slivers: [HomeAppBar()]),
            ),
          ),
          GoRoute(
            path: AppRoute.search.fullPath,
            name: AppRoute.search.name,
            builder: (context, state) =>
                const Scaffold(body: Center(child: Text('Search Page'))),
          ),
        ],
      );

      return MaterialApp.router(routerConfig: router);
    }

    testWidgets('renders SliverAppBar, logo Image, and SearchDummy', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(buildSubject());

      // Verify the main layout and slivers are rendered
      expect(find.byType(SliverAppBar), findsOneWidget);
      expect(find.byType(FlexibleSpaceBar), findsOneWidget);

      // Verify the logo image is rendered inside the FlexibleSpaceBar
      expect(find.byType(Image), findsOneWidget);

      // Verify the search dummy component is visible
      expect(find.byType(SearchDummy), findsOneWidget);
    });

    testWidgets('navigates to Search Page when SearchDummy is tapped', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(buildSubject());
      await tester.pumpAndSettle();

      // Ensure we are initially on the correct view and not the search page
      expect(find.text('Search Page'), findsNothing);

      // Tap the SearchDummy widget to trigger the onTap routing callback
      await tester.tap(find.byType(SearchDummy));
      await tester.pumpAndSettle();

      // Verify successful navigation occurred
      expect(find.text('Search Page'), findsOneWidget);
    });
  });
}
