import 'package:alfie_flutter/ui/bag/view_model/bag_view_model.dart';
import 'package:alfie_flutter/ui/core/themes/spacing.dart';
import 'package:alfie_flutter/ui/core/ui/button/app_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BagScreen extends ConsumerWidget {
  const BagScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bagItems = ref.watch(bagViewModelProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Shopping Bag')),
      body: Column(
        children: [
          Expanded(
            child: bagItems.isEmpty
                ? const Center(child: Text('Your bag is empty.'))
                : ListView.builder(
                    itemCount: bagItems.length,
                    itemBuilder: (context, index) {
                      final item = bagItems[index];
                      final productId = item.product.id;

                      return ListTile(
                        title: Text(item.product.name),
                        subtitle: Text('Qty: ${item.quantity}'),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            // Decrease Quantity
                            IconButton(
                              icon: const Icon(Icons.remove_circle_outline),
                              onPressed: () => ref
                                  .read(bagViewModelProvider.notifier)
                                  .updateItemQuantity(
                                    productId,
                                    item.quantity - 1,
                                  ),
                            ),
                            // Increase Quantity
                            IconButton(
                              icon: const Icon(Icons.add_circle_outline),
                              onPressed: () => ref
                                  .read(bagViewModelProvider.notifier)
                                  .updateItemQuantity(
                                    productId,
                                    item.quantity + 1,
                                  ),
                            ),
                            // Delete Item
                            IconButton(
                              icon: const Icon(Icons.delete, color: Colors.red),
                              onPressed: () => ref
                                  .read(bagViewModelProvider.notifier)
                                  .removeItem(productId),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
          ),

          // Checkout / Total Section
          Container(
            padding: const EdgeInsets.all(Spacing.small),
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              border: Border(top: BorderSide(color: Colors.grey.shade300)),
            ),
            child: Column(
              spacing: Spacing.small,
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  width: double.infinity,
                  child: AppButton.destructive(
                    label: 'Clear Bag',
                    onPressed: () =>
                        ref.read(bagViewModelProvider.notifier).clearBag(),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Total:',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    Text(
                      '\$${ref.read(bagViewModelProvider.notifier).total.toStringAsFixed(2)}',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
