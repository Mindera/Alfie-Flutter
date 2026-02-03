import 'package:alfie_flutter/ui/core/themes/spacing.dart';
import 'package:alfie_flutter/ui/core/ui/checkbox/checkbox.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CheckboxesScreen extends ConsumerWidget {
  const CheckboxesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      color: Theme.of(context).scaffoldBackgroundColor,
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Check Boxes', style: TextTheme.of(context).displayLarge),
            SizedBox(height: Spacing.small),
            CheckboxTile(
              label: 'Checkbox 1',
              value: false,
              info: '88',
              onChanged: (value) {},
            ),
            CheckboxTile(
              label: 'Checkbox 2',
              value: true,
              info: '565',
              onChanged: (value) {},
            ),
            CheckboxTile(
              label: 'Checkbox 3',
              value: null,
              info: '1818',
              onChanged: (value) {},
            ),
            CheckboxTile(
              label: 'Checkbox 4',
              info: '3',
              onChanged: (value) {},
              hasError: true,
              value: null,
            ),
            CheckboxTile(label: 'Checkbox 5', value: false, info: '50'),
            CheckboxTile(label: 'Checkbox 6', value: true, info: '42'),
          ],
        ),
      ),
    );
  }
}
