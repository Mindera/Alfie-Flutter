import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:alfie_flutter/data/models/app_route.dart';

void main() {
  group('AppRoute Tests -', () {
    // 1. Test Static Getters (The logic inside `get tabs`)
    test('tabs getter returns only routes with isTab = true', () {
      final tabs = AppRoute.tabs;

      // Verify count (Home, Store, Wishlist, Bag, Account = 5)
      expect(tabs.length, 5);

      // Verify they are all tabs
      for (final route in tabs) {
        expect(route.isTab, isTrue);
      }

      // Verify strict order matches definition
      expect(tabs, [
        AppRoute.home,
        AppRoute.store,
        AppRoute.wishlist,
        AppRoute.bag,
        AppRoute.account,
      ]);

      // Verify non-tab routes are excluded
      expect(tabs, isNot(contains(AppRoute.productDetail)));
    });

    // 2. Test `label` logic
    test('label returns capitalized name', () {
      // Test single word
      expect(AppRoute.home.label, 'Home');
      // Test camelCase word
      expect(AppRoute.productDetail.label, 'ProductDetail');
    });

    // 3. Test `tabIndex` logic
    test('tabIndex returns correct index for tabs', () {
      expect(AppRoute.home.tabIndex, 0);
      expect(AppRoute.store.tabIndex, 1);
      expect(AppRoute.account.tabIndex, 4);
    });

    test('tabIndex returns -1 for non-tabs', () {
      // List.indexOf returns -1 if not found
      expect(AppRoute.productDetail.tabIndex, -1);
    });

    // 4. Test Const Constructor properties
    test('Enum values have correct configured properties', () {
      // Case A: A standard Tab
      final home = AppRoute.home;
      expect(home.path, '/home');
      expect(home.isTab, isTrue);
      expect(home.icon, Icons.home);
      expect(home.children, contains(AppRoute.productDetail));

      // Case B: A sub-page (non-tab)
      final product = AppRoute.productDetail;
      expect(product.path, 'product/:id');
      expect(product.isTab, isFalse);
      expect(product.icon, isNull);
      expect(product.children, isEmpty);
    });
  });
}
