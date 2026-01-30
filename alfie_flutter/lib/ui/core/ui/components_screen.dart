import 'package:alfie_flutter/data/models/app_route.dart';
import 'package:alfie_flutter/ui/core/themes/colors.dart';
import 'package:alfie_flutter/ui/core/themes/spacing.dart';
import 'package:alfie_flutter/utils/navigation_helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ComponentsScreen extends ConsumerWidget {
  ComponentsScreen({super.key});

  final componentsScreens = [('Buttons', AppRoute.buttons)];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(Spacing.l),
        child: ListView.builder(
          itemCount: componentsScreens.length,
          itemBuilder: (context, index) {
            return ListTile(
              style: ListTileStyle.list,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadiusGeometry.circular(Spacing.s),
                side: BorderSide(color: AppColors.neutral700),
              ),
              title: Text(componentsScreens[index].$1),
              onTap: () => context.goTo(componentsScreens[index].$2),
            );
          },
        ),
      ),
    );
  }
}
