import 'package:alfie_flutter/ui/core/themes/app_icons.dart';
import 'package:alfie_flutter/ui/core/themes/spacing.dart';
import 'package:alfie_flutter/ui/core/ui/test_field/app_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TextFieldScreen extends ConsumerWidget {
  const TextFieldScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      color: Theme.of(context).scaffoldBackgroundColor,
      child: SingleChildScrollView(
        child: Column(
          spacing: Spacing.small,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Text Fields', style: TextTheme.of(context).displayLarge),
            AppInputField('Label1'),
            AppInputField('Label2', hintText: 'Some Placeholder'),
            AppInputField(
              'Label3',
              hintText: 'Some Placeholder',
              leadingIcon: AppIcons.account,
            ),
          ],
        ),
      ),
    );
  }
}
