import 'package:alfie_flutter/data/models/product.dart';
import 'package:alfie_flutter/ui/wishlist/view_model/wishlist_view_model.dart';
import 'package:alfie_flutter/utils/navigation_helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class WishlistScreen extends ConsumerWidget {
  const WishlistScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final List<Product> state = ref.watch(wishlistViewModelProvider);

    return ListView.builder(
      itemCount: state.length,
      itemBuilder: (context, index) {
        final product = state[index];
        return ListTile(
          title: Text('Store Item ${product.id}'),
          onTap: () {
            context.goToProduct(product.id);
          },
        );
      },
    );
  }
}
