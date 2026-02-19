import 'package:alfie_flutter/utils/navigation_helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class WishlistScreen extends ConsumerWidget {
  const WishlistScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final items = ["26582921"];

    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (context, index) {
        final value = items[index];
        return ListTile(
          title: Text('Store Item $value'),
          onTap: () {
            context.goToProduct(value);
          },
        );
      },
    );
  }
}
