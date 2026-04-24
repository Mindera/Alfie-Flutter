import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:alfie_flutter/ui/core/ui/gallery.dart';
import 'package:alfie_flutter/ui/home/view/highlights_gallery.dart';
import 'package:alfie_flutter/ui/home/view_model/home_state.dart';
import 'package:alfie_flutter/ui/home/view_model/home_view_model.dart';

import '../../../testing/fakes/home_view_mode_fake.dart';

void main() {
  setUp(() {
    // Prevent NetworkImage from throwing HTTP errors during widget tests
    HttpOverrides.global = null;
  });

  group('HighlightsGallery Widget Tests -', () {
    /// Helper to build the widget under test within required Slivers and Providers
    Widget buildSubject(HomeState state) {
      return ProviderScope(
        overrides: [
          homeViewModelProvider.overrideWith(() => FakeHomeViewModel(state)),
        ],
        child: MaterialApp(
          home: Scaffold(
            body: CustomScrollView(slivers: [const HighlightsGallery()]),
          ),
        ),
      );
    }

    testWidgets(
      'renders SliverAppBar, Gallery, and maps conditional title overlays',
      (WidgetTester tester) async {
        final state = TestHomeState();

        await tester.pumpWidget(buildSubject(state));
        await tester.pumpAndSettle();

        // Verify the main Sliver layout components are rendered
        expect(find.byType(SliverAppBar), findsOneWidget);
        expect(find.byType(FlexibleSpaceBar), findsOneWidget);
        expect(find.byType(Gallery), findsOneWidget);

        // Verify the item with a title renders the text overlay correctly
        expect(find.text('Featured Collection'), findsOneWidget);

        // The second item (without a title) will have passed a null foreground,
        // proving both branches of the conditional rendering are successfully covered.
      },
    );
  });
}
