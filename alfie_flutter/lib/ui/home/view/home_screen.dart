import 'package:alfie_flutter/ui/home/view_model/home_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final homeState = ref.watch(homeViewModelProvider);

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          TextField(
            decoration: const InputDecoration(
              labelText: 'Enter some text',
              border: OutlineInputBorder(),
            ),
            onChanged: (value) =>
                ref.read(homeViewModelProvider.notifier).updateText(value),
          ),
          SizedBox(height: 20),
          Text(
            'Display: ${homeState.displayedText}',
            maxLines: 5,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.headlineMedium,
          ),
        ],
      ),
    );
  }
}
