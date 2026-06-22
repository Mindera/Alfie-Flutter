import 'dart:developer';
import 'package:alfie_flutter/data/models/environment.dart';
import 'package:alfie_flutter/data/services/persistent_storage_service.dart';
import 'package:alfie_flutter/main.dart';
import 'package:alfie_flutter/ui/core/ui/product_card/vertical_product_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:integration_test/integration_test.dart';

// Reuse your exact element finders
Finder _findPlpScrollView() =>
    _findScrollable(find.byKey(const Key('plp_scroll_view')));
Finder _findPdpScrollView() =>
    _findScrollable(find.byKey(const Key('pdp_scroll_view')));
Finder _findScrollable(Finder customScrollView) => find
    .descendant(of: customScrollView, matching: find.byType(Scrollable))
    .first;

Finder _findPlpProductCard({bool useFirst = true}) {
  final card = find.byType(VerticalProductCard).hitTestable();
  return useFirst ? card.first : card.last;
}

Finder _findPdpAddToBagButton() =>
    find.byKey(const Key('pdp_add_to_bag_button'));
Finder _findPdpBackButton() => find.byKey(const Key('pdp_back_button'));

Future<void> _scrollAndTap(
  WidgetTester tester,
  Finder target,
  Finder scrollable, {
  double scrollOffset = 250.0,
}) async {
  await tester.scrollUntilVisible(target, scrollOffset, scrollable: scrollable);
  await tester.pumpAndSettle();
  await tester.tap(target);
  await tester.pumpAndSettle();
}

void main() {
  final binding = IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  binding.framePolicy = LiveTestWidgetsFlutterBindingFramePolicy.fullyLive;

  group('Usability Latency - Action Feedback QAS', () {
    const int totalTrials = 35;
    final List<int> recordedLatenciesMs = [];

    testWidgets('Measure real app Snackbar latency via PDP navigation loop', (
      WidgetTester tester,
    ) async {
      // 1. App Environment Bootstrapping
      await initHiveForFlutter();
      SystemChrome.setEnabledSystemUIMode(
        SystemUiMode.manual,
        overlays: [SystemUiOverlay.top],
      );

      final container = ProviderContainer();
      await dotenv.load(fileName: container.read(environmentProvider).fileName);
      await container.read(persistentStorageServiceProvider).init();

      await tester.pumpWidget(const ProviderScope(child: MainApp()));
      await tester.pumpAndSettle();

      log("PAUSING FOR 6 SECONDS: Handle initial network alerts...");
      await Future<void>.delayed(const Duration(seconds: 6));
      await tester.pumpAndSettle();

      // Go to Store
      final storeTab = find.text('Store');
      expect(storeTab, findsOneWidget);
      await tester.tap(storeTab);
      await tester.pumpAndSettle();

      final plpScrollView = _findPlpScrollView();
      final Finder snackBarFinder = find.byType(SnackBar);

      // 2. Continuous Latency Sampling Loop
      // 2. Continuous Latency Sampling Loop
      for (int i = 0; i < totalTrials; i++) {
        // Step A: Navigate from PLP into the PDP
        final productCard = _findPlpProductCard(useFirst: (i % 2 == 0));
        await _scrollAndTap(tester, productCard, plpScrollView);

        final pdpScrollView = _findPdpScrollView();
        final Finder addToBagButton = _findPdpAddToBagButton();

        // New Step: Scroll down the PDP until the button is fully interactable
        await tester.scrollUntilVisible(
          addToBagButton,
          250.0,
          scrollable: pdpScrollView,
        );
        await tester.pumpAndSettle();
        expect(addToBagButton, findsOneWidget);

        final stopwatch = Stopwatch();

        // Step B: Tap the button and isolate latency collection
        // (Timer starts exactly when the touch event is dispatched)
        await tester.tap(addToBagButton);
        stopwatch.start();

        bool isSnackBarRendered = false;
        while (stopwatch.elapsedMilliseconds < 2500) {
          await tester.pump(const Duration(milliseconds: 8));
          if (tester.any(snackBarFinder)) {
            stopwatch.stop();
            isSnackBarRendered = true;
            break;
          }
        }

        if (isSnackBarRendered) {
          recordedLatenciesMs.add(stopwatch.elapsedMilliseconds);
          log(
            'Trial [${i + 1}/$totalTrials] Latency: ${stopwatch.elapsedMilliseconds} ms',
          );
        } else {
          stopwatch.stop();
          fail('Feedback SnackBar missed 2.5s rendering window at trial: $i');
        }

        // Step C: Clear the Snackbar instantly to avoid bleed-over into next trials
        ScaffoldMessenger.of(tester.element(addToBagButton)).clearSnackBars();
        await tester.pumpAndSettle(const Duration(milliseconds: 300));

        // Step D: Safely pop back out to the PLP to refresh context for the next cycle
        await _scrollAndTap(
          tester,
          _findPdpBackButton(),
          pdpScrollView,
          scrollOffset: -300,
        );
      }

      // 3. Output Data Stream for your Solution Analysis Chapter
      log(
        '\n========================================================================',
      );
      log(
        '                 SUCCESSFULLY CAPTURED ACTION LATENCY NFR               ',
      );
      log(
        '========================================================================',
      );
      log('SAMPLE_SIZE_N    = ${recordedLatenciesMs.length}');
      log('LATENCY_DATA_MS  = $recordedLatenciesMs');
      log(
        '========================================================================\n',
      );
    });
  });
}
