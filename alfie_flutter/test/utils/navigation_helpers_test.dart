import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:alfie_flutter/data/models/app_route.dart';
import '../../testing/fakes/router_fake.dart';

void main() {
  testWidgets('goToProduct builds path when current path has no trailing slash', (
    WidgetTester tester,
  ) async {
    const productId = '123';
    final router = buildFakeRouter(
      baseRoute: AppRoute.store,
      initialLocation: AppRoute.store.path,
      productId: productId,
    );

    await tester.pumpWidget(MaterialApp.router(routerConfig: router));
    await tester.pumpAndSettle();

    await tester.tap(find.byType(ElevatedButton));
    await tester.pumpAndSettle();

    final expected =
        '${AppRoute.store.path}/${AppRoute.productDetail.path.replaceFirst(':id', productId)}';
    expect(find.text(expected), findsOneWidget);
  });

  testWidgets('goToProduct builds path when current path ends with a slash', (
    WidgetTester tester,
  ) async {
    const productId = 'abc';
    // Start with a trailing slash to simulate the edge case
    final router = buildFakeRouter(
      baseRoute: AppRoute.bag,
      initialLocation: '${AppRoute.bag.path}/',
      productId: productId,
    );

    await tester.pumpWidget(MaterialApp.router(routerConfig: router));
    await tester.pumpAndSettle();

    await tester.tap(find.byType(ElevatedButton));
    await tester.pumpAndSettle();

    final expected =
        '${AppRoute.bag.path}/${AppRoute.productDetail.path.replaceFirst(':id', productId)}';
    expect(find.text(expected), findsOneWidget);
  });
}
