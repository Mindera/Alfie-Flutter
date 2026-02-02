import 'package:alfie_flutter/ui/core/themes/spacing.dart';
import 'package:alfie_flutter/ui/core/ui/radio_button/radio_buttons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

enum Options { option1, option2, option3 }

class RadioButtonsScreen extends ConsumerWidget {
  const RadioButtonsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      color: Theme.of(context).scaffoldBackgroundColor,
      child: SingleChildScrollView(
        child: Column(
          spacing: Spacing.large,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Radio Buttons', style: TextTheme.of(context).displayLarge),
            SizedBox(height: Spacing.small),
            RadioButtons(
              options: [Options.option1, Options.option2, Options.option3],
              initialValue: Options.option1,
              onChanged: (_) {},
              labelBuilder: (option) => option.name,
            ),
            RadioButtons(
              options: [Options.option1, Options.option2, Options.option3],
              initialValue: Options.option1,
              disabledOptions: [Options.option2],
              onChanged: (_) {},
              labelBuilder: (option) => option.name,
            ),
            RadioButtons(
              options: [Options.option1, Options.option2, Options.option3],
              initialValue: Options.option1,
              onChanged: (_) {},
              isDisabled: true,
              labelBuilder: (option) => option.name,
            ),
          ],
        ),
      ),
    );
  }
}
