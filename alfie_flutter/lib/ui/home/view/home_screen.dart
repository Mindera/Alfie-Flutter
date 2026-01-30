import 'package:alfie_flutter/ui/core/themes/app_button_theme.dart';
import 'package:alfie_flutter/ui/core/themes/app_icons.dart';
import 'package:alfie_flutter/ui/core/ui/app_button.dart';
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
      child: SingleChildScrollView(
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
            SizedBox(height: 20),
            AppButton.primary(leading: AppIcons.add, onPressed: () {}),
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
            ),
            AppButton.primary(
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
              isLoading: true,
            ),
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
              isLoading: true,
            ),
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
              isLoading: true,
            ),
          ],
        ),
      ),
    );
  }
}
