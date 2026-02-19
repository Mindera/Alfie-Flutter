import 'package:alfie_flutter/ui/core/themes/spacing.dart';
import 'package:alfie_flutter/ui/core/ui/checkbox/checkbox.dart';
import 'package:alfie_flutter/utils/build_context_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CheckboxesScreen extends ConsumerWidget {
  const CheckboxesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      color: context.theme.scaffoldBackgroundColor,
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Check Boxes', style: context.textTheme.displayLarge),
            SizedBox(height: Spacing.small),
            CheckboxTile(
              label: 'Checkbox 1',
              initialValue: false,
              info: '88',
              onChanged: (value) {},
            ),
            CheckboxTile(
              label: 'Checkbox 2',
              initialValue: true,
              info: '565',
              onChanged: (value) {},
            ),
            CheckboxTile(
              label: 'Checkbox 3',
              initialValue: null,
              info: '1818',
              onChanged: (value) {},
            ),
            CheckboxTile(
              label: 'Checkbox 4',
              info: '3',
              onChanged: (value) {},
              hasError: true,
              initialValue: null,
            ),
            CheckboxTile(label: 'Checkbox 5', initialValue: false, info: '50'),
            CheckboxTile(label: 'Checkbox 6', initialValue: true, info: '42'),
          ],
        ),
      ),
    );
  }
}
