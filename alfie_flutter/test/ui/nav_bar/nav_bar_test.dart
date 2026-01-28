import 'package:alfie_flutter/ui/nav_bar/view/nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mocktail/mocktail.dart';

import 'package:alfie_flutter/ui/nav_bar/view_model/nav_bar_view_model.dart';

import '../../../testing/mocks.dart';

void main() {
  late MockNavBarViewModel mockViewModel;
  late MockNavigationShell mockShell;

  setUp(() {
    mockViewModel = MockNavBarViewModel();
    mockShell = MockNavigationShell();
  });

  // Helper to build the widget under test
  Future<void> pumpNavBar(WidgetTester tester) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          // Inject our Mock View Model instead of the real one
          navBarViewModelProvider.overrideWithValue(mockViewModel),
        ],
        child: MaterialApp(
          home: Scaffold(
            // pass the mock shell
            bottomNavigationBar: NavBar(navigationShell: mockShell),
          ),
        ),
      ),
    );
  }

  group('NavBar UI Component -', () {
    testWidgets('renders correct number of items from ViewModel', (
      tester,
    ) async {
      // Setup: View Model returns 3 dummy items
      final dummyItems = [
        const BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
        const BottomNavigationBarItem(icon: Icon(Icons.store), label: 'Store'),
        const BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'Profile',
        ),
      ];

      when(() => mockViewModel.navBarItems).thenReturn(dummyItems);
      when(() => mockShell.currentIndex).thenReturn(0);

      await pumpNavBar(tester);

      // Verify: 3 items are rendered
      expect(find.byType(BottomNavigationBar), findsOneWidget);
      expect(find.text('Home'), findsOneWidget);
      expect(find.text('Store'), findsOneWidget);
      expect(find.text('Profile'), findsOneWidget);
    });

    testWidgets('highlights the correct tab based on NavigationShell', (
      tester,
    ) async {
      // Setup: View Model returns items
      final dummyItems = [
        const BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
        const BottomNavigationBarItem(icon: Icon(Icons.store), label: 'Store'),
      ];
      when(() => mockViewModel.navBarItems).thenReturn(dummyItems);

      // Setup: Tell the UI that tab 1 (Store) is currently active
      when(() => mockShell.currentIndex).thenReturn(1);

      await pumpNavBar(tester);

      final bottomNav = tester.widget<BottomNavigationBar>(
        find.byType(BottomNavigationBar),
      );
      expect(bottomNav.currentIndex, 1);
    });

    testWidgets('delegates tap events to ViewModel', (tester) async {
      // Setup
      final dummyItems = [
        const BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
        const BottomNavigationBarItem(icon: Icon(Icons.store), label: 'Store'),
      ];
      when(() => mockViewModel.navBarItems).thenReturn(dummyItems);
      when(() => mockShell.currentIndex).thenReturn(0);

      await pumpNavBar(tester);

      // Action: Tap the "Store" tab (index 1)
      await tester.tap(find.text('Store'));

      // Verify: The View Model's handleTap was called with the correct args
      // We verify INTERACTION, not logic.
      verify(() => mockViewModel.handleTap(mockShell, 1)).called(1);
    });
  });
}
