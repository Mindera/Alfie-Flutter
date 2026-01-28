import 'package:alfie_flutter/routing/router.dart';
import 'package:alfie_flutter/ui/nav_bar/view_model/nav_bar_view_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:alfie_flutter/data/models/app_route.dart';
import 'package:alfie_flutter/ui/core/view_model/scroll_view_model.dart';
import 'package:mocktail/mocktail.dart';

import '../../../testing/mocks.dart';

void main() {
  late ProviderContainer container;
  late MockGoRouter mockRouter;
  late MockGoRouterState mockRouterState;
  late MockNavigationShell mockShell;

  setUp(() {
    mockRouter = MockGoRouter();
    mockRouterState = MockGoRouterState();
    mockShell = MockNavigationShell();

    // Link the router to return our mock state
    // (Assuming your router.state logic works this way)
    when(() => mockRouter.state).thenReturn(mockRouterState);

    // 2. Setup container with overrides
    container = ProviderContainer(
      overrides: [routerProvider.overrideWithValue(mockRouter)],
    );
  });

  tearDown(() => container.dispose());

  // Helper to get the VM
  NavBarViewModel getViewModel() => container.read(navBarViewModelProvider);

  group('NavBarViewModel - ', () {
    test('navBarItems returns correct mapped items', () {
      final viewModel = getViewModel();
      expect(viewModel.navBarItems.length, AppRoute.tabs.length);
      expect(viewModel.navBarItems.first.label, AppRoute.tabs.first.label);
    });

    test('switching to a NEW tab calls goBranch without scroll reset', () {
      final viewModel = getViewModel();

      // Setup: We are on tab 0, clicking tab 1
      when(() => mockShell.currentIndex).thenReturn(0);

      // Action
      viewModel.handleTap(mockShell, 1);

      // Verify: goBranch called with index 1
      verify(() => mockShell.goBranch(1, initialLocation: false)).called(1);

      // Verify: Scroll reset was NOT triggered (Assuming initial state is 0)
      final scrollState = container.read(scrollProvider(AppRoute.tabs[1].name));
      expect(scrollState, 0);
    });

    test(
      'tapping CURRENT tab (not at root) goes to root but NO scroll reset',
      () {
        final viewModel = getViewModel();
        final tabIndex = 0; // Home tab
        final tabName = AppRoute.tabs[tabIndex].name;

        // Setup: We are on tab 0, clicking tab 0
        when(() => mockShell.currentIndex).thenReturn(tabIndex);

        // Setup: Router says we are at a deep link (NOT root)
        when(() => mockRouterState.fullPath).thenReturn('/home/details');
        when(() => mockRouter.namedLocation(tabName)).thenReturn('/home');

        // Action
        viewModel.handleTap(mockShell, tabIndex);

        // Verify: goBranch called with initialLocation: true (to pop stack)
        verify(
          () => mockShell.goBranch(tabIndex, initialLocation: true),
        ).called(1);

        // Verify: Scroll logic was skipped because we weren't at root yet
        final scrollState = container.read(scrollProvider(tabName));
        expect(scrollState, 0);
      },
    );

    test('tapping CURRENT tab (at root) triggers scroll reset', () {
      final viewModel = getViewModel();
      final tabIndex = 0;
      final tabName = AppRoute.tabs[tabIndex].name;

      // Setup: We are on tab 0, clicking tab 0
      when(() => mockShell.currentIndex).thenReturn(tabIndex);

      // Setup: Router says we are ALREADY at root
      when(() => mockRouterState.fullPath).thenReturn('/home');
      when(() => mockRouter.namedLocation(tabName)).thenReturn('/home');

      // Action
      viewModel.handleTap(mockShell, tabIndex);

      // Verify: goBranch called
      verify(
        () => mockShell.goBranch(tabIndex, initialLocation: true),
      ).called(1);

      // Verify: Scroll provider state changed (reset triggered)
      // Assuming your scrollProvider logic increments on reset as per previous context
      final scrollState = container.read(scrollProvider(tabName));
      expect(scrollState, greaterThan(0));
    });
  });
}
