import 'package:alfie_flutter/ui/core/themes/app_button_theme.dart';
import 'package:alfie_flutter/ui/core/themes/app_icons.dart';
import 'package:alfie_flutter/ui/core/themes/spacing.dart';
import 'package:alfie_flutter/ui/core/ui/button/app_button.dart';
import 'package:alfie_flutter/utils/build_context_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ButtonsScreen extends ConsumerWidget {
  const ButtonsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      color: context.theme.scaffoldBackgroundColor,
      child: SingleChildScrollView(
        child: Column(
          spacing: 8,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Buttons', style: context.textTheme.displayLarge),
            Text('Primary', style: context.textTheme.headlineSmall),
            AppButton.primary(
              label: "Label",
              leading: AppIcons.minus,
              trailing: AppIcons.add,
              onPressed: () {},
            ),
            AppButton.primary(
              label: "Label",
              leading: AppIcons.minus,
              trailing: AppIcons.add,
            ),
            AppButton.primary(
              label: "Label",
              leading: AppIcons.minus,
              trailing: AppIcons.add,
              onPressed: () {},
              isLoading: true,
            ),
            AppButton.primary(
              label: "Label",
              leading: AppIcons.minus,
              trailing: AppIcons.add,
              size: ButtonSize.small,
              onPressed: () {},
            ),
            AppButton.primary(
              label: "Label",
              leading: AppIcons.minus,
              trailing: AppIcons.add,
              size: ButtonSize.small,
            ),
            AppButton.primary(
              label: "Label",
              leading: AppIcons.minus,
              trailing: AppIcons.add,
              size: ButtonSize.small,
              onPressed: () {},
              isLoading: true,
            ),
            AppButton.primary(leading: AppIcons.add, onPressed: () {}),
            AppButton.primary(leading: AppIcons.add),
            AppButton.primary(leading: AppIcons.add, isLoading: true),

            SizedBox(height: Spacing.extraLarge),

            Text('Secondary', style: context.textTheme.headlineSmall),
            AppButton.secondary(
              label: "Label",
              leading: AppIcons.minus,
              trailing: AppIcons.add,
              onPressed: () {},
            ),
            AppButton.secondary(
              label: "Label",
              leading: AppIcons.minus,
              trailing: AppIcons.add,
            ),
            AppButton.secondary(
              label: "Label",
              leading: AppIcons.minus,
              trailing: AppIcons.add,
              onPressed: () {},
              isLoading: true,
            ),
            AppButton.secondary(
              label: "Label",
              leading: AppIcons.minus,
              trailing: AppIcons.add,
              size: ButtonSize.small,
              onPressed: () {},
            ),
            AppButton.secondary(
              label: "Label",
              leading: AppIcons.minus,
              trailing: AppIcons.add,
              size: ButtonSize.small,
            ),
            AppButton.secondary(
              label: "Label",
              leading: AppIcons.minus,
              trailing: AppIcons.add,
              size: ButtonSize.small,
              onPressed: () {},
              isLoading: true,
            ),
            AppButton.secondary(leading: AppIcons.add, onPressed: () {}),
            AppButton.secondary(leading: AppIcons.add),
            AppButton.secondary(leading: AppIcons.add, isLoading: true),

            SizedBox(height: Spacing.extraLarge),

            Text('Tertiary', style: context.textTheme.headlineSmall),
            AppButton.tertiary(
              label: "Label",
              leading: AppIcons.minus,
              trailing: AppIcons.add,
              onPressed: () {},
            ),
            AppButton.tertiary(
              label: "Label",
              leading: AppIcons.minus,
              trailing: AppIcons.add,
            ),
            AppButton.tertiary(
              label: "Label",
              leading: AppIcons.minus,
              trailing: AppIcons.add,
              onPressed: () {},
              isLoading: true,
            ),
            AppButton.tertiary(
              label: "Label",
              leading: AppIcons.minus,
              trailing: AppIcons.add,
              size: ButtonSize.small,
              onPressed: () {},
            ),
            AppButton.tertiary(
              label: "Label",
              leading: AppIcons.minus,
              trailing: AppIcons.add,
              size: ButtonSize.small,
            ),
            AppButton.tertiary(
              label: "Label",
              leading: AppIcons.minus,
              trailing: AppIcons.add,
              size: ButtonSize.small,
              onPressed: () {},
              isLoading: true,
            ),
            AppButton.tertiary(leading: AppIcons.add, onPressed: () {}),
            AppButton.tertiary(leading: AppIcons.add),
            AppButton.tertiary(leading: AppIcons.add, isLoading: true),

            SizedBox(height: Spacing.extraLarge),

            Text('Destructive', style: context.textTheme.headlineSmall),
            AppButton.destructive(
              label: "Label",
              leading: AppIcons.minus,
              trailing: AppIcons.add,
              onPressed: () {},
            ),
            AppButton.destructive(
              label: "Label",
              leading: AppIcons.minus,
              trailing: AppIcons.add,
            ),
            AppButton.destructive(
              label: "Label",
              leading: AppIcons.minus,
              trailing: AppIcons.add,
              onPressed: () {},
              isLoading: true,
            ),
            AppButton.destructive(
              label: "Label",
              leading: AppIcons.minus,
              trailing: AppIcons.add,
              size: ButtonSize.small,
              onPressed: () {},
            ),
            AppButton.destructive(
              label: "Label",
              leading: AppIcons.minus,
              trailing: AppIcons.add,
              size: ButtonSize.small,
            ),
            AppButton.destructive(
              label: "Label",
              leading: AppIcons.minus,
              trailing: AppIcons.add,
              size: ButtonSize.small,
              onPressed: () {},
              isLoading: true,
            ),
            AppButton.destructive(leading: AppIcons.add, onPressed: () {}),
            AppButton.destructive(leading: AppIcons.add),
            AppButton.destructive(leading: AppIcons.add, isLoading: true),
          ],
        ),
      ),
    );
  }
}
