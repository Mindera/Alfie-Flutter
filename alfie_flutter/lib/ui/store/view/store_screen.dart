import 'package:alfie_flutter/routing/app_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class StoreScreen extends ConsumerWidget {
  const StoreScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListView.builder(
      itemCount: 101,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text('Store Item $index'),
          onTap: () {
            context.goNamed(
              AppRoute.productDetail.name,
              pathParameters: {'id': '$index'},
            );
          },
        );
      },
    );
  }
}
