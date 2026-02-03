import 'package:alfie_flutter/routing/app_route.dart';
import 'package:alfie_flutter/ui/core/themes/colors.dart';
import 'package:alfie_flutter/ui/core/themes/spacing.dart';
import 'package:alfie_flutter/utils/navigation_helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ComponentsScreen extends ConsumerWidget {
  ComponentsScreen({super.key});

  final componentsScreens = AppRoute.components.children;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(Spacing.large),
        child: ListView.separated(
          itemCount: componentsScreens.length,
          itemBuilder: (context, index) {
            return ListTile(
              style: ListTileStyle.list,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadiusGeometry.circular(Spacing.small),
                side: BorderSide(color: AppColors.neutral700),
              ),
              title: Text(componentsScreens[index].name),
              onTap: () => context.goTo(componentsScreens[index]),
            );
          },
          separatorBuilder: (BuildContext context, int index) =>
              SizedBox(height: Spacing.extraSmall),
        ),
      ),
    );
  }
}
