import 'dart:developer';
import 'package:alfie_flutter/data/models/environment.dart';
import 'package:alfie_flutter/data/services/persistent_storage_service.dart';
import 'package:alfie_flutter/main.dart';
import 'package:alfie_flutter/ui/core/ui/product_card/vertical_product_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:integration_test/integration_test.dart';

Finder _findPlpScrollView() =>
    _findScrollable(find.byKey(const Key('plp_scroll_view')));
Finder _findPdpScrollView() =>
    _findScrollable(find.byKey(const Key('pdp_scroll_view')));

Finder _findScrollable(Finder customScrollView) => find
    .descendant(of: customScrollView, matching: find.byType(Scrollable))
    .first;

Finder _findPlpProductCard() =>
    find.byType(VerticalProductCard).hitTestable().first;
Finder _findPdpWishlistButton() => find.byKey(const Key('pdp_wishlist_button'));
Finder _findPdpAddToBagButton() =>
    find.byKey(const Key('pdp_add_to_bag_button'));
Finder _findPdpBackButton() => find.byKey(const Key('pdp_back_button'));

Future<void> _scrollUntilVisible(
  WidgetTester tester,
  Finder target,
  Finder scrollable, {
  double scrollOffset = 250.0,
}) async {
  await tester.scrollUntilVisible(target, scrollOffset, scrollable: scrollable);
  await tester.pumpAndSettle();
  expect(target, findsOneWidget);
}

Future<void> _scrollAndTap(
  WidgetTester tester,
  Finder target,
  Finder scrollable, {
  double scrollOffset = 250.0,
}) async {
  await _scrollUntilVisible(
    tester,
    target,
    scrollable,
    scrollOffset: scrollOffset,
  );
  await tester.tap(target);
  await tester.pumpAndSettle();
}

Future<void> _performScrollSteps(
  WidgetTester tester,
  Finder scrollable,
  int count, {
  Offset offset = const Offset(0, -220),
  Duration pause = const Duration(milliseconds: 250),
}) async {
  for (var i = 0; i < count; i++) {
    await tester.drag(scrollable, offset);
    await tester.pump(pause);
  }
}

void main() {
  // 1. Enable timeline collection explicitly
  final binding = IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  binding.framePolicy = LiveTestWidgetsFlutterBindingFramePolicy.fullyLive;

  group('PLP Performance Test', () {
    testWidgets('Measure average frame rate during scrolling', (
      WidgetTester tester,
    ) async {
      await initHiveForFlutter();

      SystemChrome.setEnabledSystemUIMode(
        SystemUiMode.manual,
        overlays: [SystemUiOverlay.top],
      );

      final container = ProviderContainer();
      await dotenv.load(fileName: container.read(environmentProvider).fileName);

      final persistentStorageService = container.read(
        persistentStorageServiceProvider,
      );
      await persistentStorageService.init();

      await tester.pumpWidget(const ProviderScope(child: MainApp()));
      await tester.pump();

      log(
        "PAUSING FOR 5 SECONDS: Please accept the local network permission popup now...",
      );
      await Future<void>.delayed(const Duration(seconds: 5));
      await tester.pumpAndSettle();

      // Navigate to Store tab
      final storeTab = find.text('Store');
      expect(storeTab, findsOneWidget);
      await tester.tap(storeTab);
      await tester.pumpAndSettle();

      final plpScrollView = _findPlpScrollView();
      expect(plpScrollView, findsOneWidget);

      // Allow images to pre-fetch and settle before recording begins (buffer)
      await tester.pumpAndSettle(const Duration(seconds: 2));

      // 2. Profile the actions using traceAction
      await binding.traceAction(() async {
        // 1. SCROLL
        await _performScrollSteps(tester, plpScrollView, 6);

        // 2. OPEN FIRST PRODUCT
        await _scrollAndTap(tester, _findPlpProductCard(), plpScrollView);

        await Future<void>.delayed(const Duration(milliseconds: 1500));

        // 3. WISHLIST PRODUCT
        await _scrollAndTap(
          tester,
          _findPdpWishlistButton(),
          _findPdpScrollView(),
        );

        // 4. Pause 1.5 seconds, then return to the PLP.
        await Future<void>.delayed(const Duration(milliseconds: 1500));

        await _scrollAndTap(
          tester,
          _findPdpBackButton(),
          _findPdpScrollView(),
          scrollOffset: -300,
        );

        // 5. Scroll a bit more and open the second product.
        await _performScrollSteps(tester, plpScrollView, 4);

        await _scrollAndTap(tester, _findPlpProductCard(), plpScrollView);

        // 6. Wait 1.5 seconds before adding the product to the bag.
        await Future<void>.delayed(const Duration(milliseconds: 1500));

        await _scrollAndTap(
          tester,
          _findPdpAddToBagButton(),
          _findPdpScrollView(),
        );

        // 7. Pause another 2 seconds, then return to the PLP.
        await Future<void>.delayed(const Duration(seconds: 2));

        await _scrollAndTap(
          tester,
          _findPdpBackButton(),
          _findPdpScrollView(),
          scrollOffset: -300,
        );

        await Future<void>.delayed(const Duration(seconds: 2));

        // 8. Perform a final scroll pass to continue exploring the list.
        await _performScrollSteps(
          tester,
          plpScrollView,
          10,
          offset: const Offset(0, 100),
          pause: const Duration(milliseconds: 200),
        );

        // 9. Wait a final second for the UI to settle before capturing timeline end.
        await Future<void>.delayed(const Duration(seconds: 1));
      }, reportKey: 'plp_scroll_timeline');

      log('Timeline capture finished.');
    });
  });
}
