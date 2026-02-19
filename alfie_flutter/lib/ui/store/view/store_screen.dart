import 'dart:developer';

import 'package:alfie_flutter/utils/navigation_helpers.dart';
import 'package:alfie_flutter/utils/use_scroll_to_top.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class StoreScreen extends HookConsumerWidget {
  const StoreScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scrollController = useScrollToTop(ref, context.path);
    log(context.path);

    return Scaffold(
      body: ListView.builder(
        controller: scrollController,
        itemCount: 101,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text('Store Item $index'),
            onTap: () => context.goToProduct('$index'),
          );
        },
      ),
    );
  }
}
