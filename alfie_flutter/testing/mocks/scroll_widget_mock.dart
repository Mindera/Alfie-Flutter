import 'package:alfie_flutter/utils/scroll_to_top_mixin.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:alfie_flutter/routing/app_route.dart';
// Import your mixin file path here

class MockScrollWidget extends ConsumerStatefulWidget {
  const MockScrollWidget({super.key});
  @override
  ConsumerState<MockScrollWidget> createState() => MockScrollWidgetState();
}

class MockScrollWidgetState extends ConsumerState<MockScrollWidget>
    with ScrollToTopMixin {
  @override
  AppRoute get route => AppRoute.home;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: ListView.builder(
          controller: scrollController,
          itemCount: 100,
          itemBuilder: (context, index) => ListTile(title: Text('Item $index')),
        ),
      ),
    );
  }
}
