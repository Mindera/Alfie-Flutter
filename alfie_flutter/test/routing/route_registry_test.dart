import 'package:alfie_flutter/routing/app_route.dart';
import 'package:alfie_flutter/routing/route_registry.dart';
import 'package:alfie_flutter/ui/account/view/account_screen.dart';
import 'package:alfie_flutter/ui/bag/view/bag_screen.dart';
import 'package:alfie_flutter/ui/home/view/home_screen.dart';
import 'package:alfie_flutter/ui/product_detail/view/product_detail_screen.dart';
import 'package:alfie_flutter/ui/store/view/store_screen.dart';
import 'package:alfie_flutter/ui/wishlist/view/wishlist_screen.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';

import 'package:mocktail/mocktail.dart';

import '../../testing/mocks.dart';

void main() {
  late DefaultRouteRegistry registry;
  late GoRouterState mockState;

  setUp(() {
    registry = const DefaultRouteRegistry();
    mockState = MockGoRouterState();
  });

  group('DefaultRouteRegistry -', () {
    test('returns HomeScreen for AppRoute.home', () {
      final result = registry.getScreen(AppRoute.home, mockState);
      expect(result, isA<HomeScreen>());
    });

    test('returns ProductDetailScreen with correct ID from state', () {
      when(() => mockState.pathParameters).thenReturn({'id': '123'});

      final result = registry.getScreen(AppRoute.productDetail, mockState);

      expect(result, isA<ProductDetailScreen>());
      expect((result as ProductDetailScreen).id, '123');
    });

    test('returns WishlistScreen for AppRoute.wishlist', () {
      final result = registry.getScreen(AppRoute.wishlist, mockState);
      expect(result, isA<WishlistScreen>());
    });

    test('returns StoreScreen for AppRoute.store', () {
      final result = registry.getScreen(AppRoute.store, mockState);
      expect(result, isA<StoreScreen>());
    });
    test('returns BagScreen for AppRoute.bag', () {
      final result = registry.getScreen(AppRoute.bag, mockState);
      expect(result, isA<BagScreen>());
    });

    test('returns AccountScreen for AppRoute.account', () {
      final result = registry.getScreen(AppRoute.account, mockState);
      expect(result, isA<AccountScreen>());
    });
  });
}
