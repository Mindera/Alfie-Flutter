import 'dart:developer';
import 'package:alfie_flutter/data/models/environment.dart';
import 'package:alfie_flutter/data/services/persistent_storage_service.dart';
import 'package:alfie_flutter/main.dart';
import 'package:alfie_flutter/ui/core/themes/app_icons.dart';
import 'package:alfie_flutter/ui/core/ui/product_card/vertical_product_card.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:integration_test/integration_test.dart';

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

      final scrollableFinder = find.byType(CustomScrollView);
      expect(scrollableFinder, findsOneWidget);

      // Allow images to pre-fetch and settle before recording begins (buffer)
      await tester.pumpAndSettle(const Duration(seconds: 2));

      // 2. Profile the actions using traceAction
      await binding.traceAction(() async {
        // 1. Scroll down on the PLP to expose products.
        const int stepsDown = 6;
        for (int i = 0; i < stepsDown; i++) {
          await tester.drag(scrollableFinder, const Offset(0, -220));
          await tester.pump(const Duration(milliseconds: 250));
        }

        // 2. Open the first visible product.
        final firstProduct = find.byType(VerticalProductCard).first;
        expect(firstProduct, findsOneWidget);
        await tester.tap(firstProduct);
        await tester.pumpAndSettle();

        // 3. Add the product to wishlist.
        final wishlistButton = find.byIcon(AppIcons.wishlist);
        expect(wishlistButton, findsOneWidget);
        await tester.tap(wishlistButton);
        await tester.pumpAndSettle();

        // 4. Pause 1.5 seconds, then return to the PLP.
        await Future<void>.delayed(const Duration(milliseconds: 1500));
        await tester.pageBack();
        await tester.pumpAndSettle();

        // 5. Scroll a bit more and open the second product.
        const int moreScroll = 4;
        for (int i = 0; i < moreScroll; i++) {
          await tester.drag(scrollableFinder, const Offset(0, -220));
          await tester.pump(const Duration(milliseconds: 250));
        }

        final secondProduct = find.byType(VerticalProductCard).at(1);
        expect(secondProduct, findsOneWidget);
        await tester.tap(secondProduct);
        await tester.pumpAndSettle();

        // 6. Wait 1.5 seconds before adding the product to the bag.
        await Future<void>.delayed(const Duration(milliseconds: 1500));
        final addToBagButton = find.text('Add to Bag');
        expect(addToBagButton, findsOneWidget);
        await tester.tap(addToBagButton);
        await tester.pumpAndSettle();

        // 7. Pause another 2 seconds, then return to the PLP.
        await Future<void>.delayed(const Duration(seconds: 2));
        await tester.pageBack();
        await tester.pumpAndSettle();

        // 8. Perform a final scroll pass to continue exploring the list.
        const int finalScroll = 6;
        for (int i = 0; i < finalScroll; i++) {
          await tester.drag(scrollableFinder, const Offset(0, -180));
          await tester.pump(const Duration(milliseconds: 250));
        }

        // 9. Wait a final second for the UI to settle before capturing timeline end.
        await Future<void>.delayed(const Duration(seconds: 1));
      }, reportKey: 'plp_scroll_timeline');

      log('Timeline capture finished.');
    });
  });
}
