import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:alfie_flutter/ui/core/view_model/scroll_view_model.dart';

ScrollController useScrollToTop(WidgetRef ref, String routeName) {
  final controller = useScrollController();

  ref.listen(scrollProvider(routeName), (prev, next) {
    if (controller.hasClients) {
      controller.animateTo(
        0,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  });

  return controller;
}
