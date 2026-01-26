import 'package:alfie_flutter/routing/app_route.dart';
import 'package:flutter/material.dart';
import 'dart:math';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class WishlistScreen extends ConsumerWidget {
  const WishlistScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Generate exactly 5 random integers between 0 and 100.
    final random = Random();
    final items = List<int>.generate(5, (_) => random.nextInt(101));

    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (context, index) {
        final value = items[index];
        return ListTile(
          title: Text('Store Item $value'),
          onTap: () {
            context.goNamed(
              AppRoute.productDetail.name,
              pathParameters: {'id': '$value'},
            );
          },
        );
      },
    );
  }
}
