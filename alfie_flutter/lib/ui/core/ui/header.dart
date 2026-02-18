import 'package:alfie_flutter/ui/core/themes/spacing.dart';
import 'package:alfie_flutter/utils/build_context_extensions.dart';
import 'package:flutter/material.dart';

class Header extends StatelessWidget {
  const Header({super.key, required this.title, this.leading, this.actions});

  final String title;
  final Widget? leading;
  final List<Widget>? actions;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsGeometry.only(
        top: Spacing.extraExtraSmall + context.mediaQuery.padding.top,
        left: Spacing.extraExtraSmall,
        bottom: Spacing.extraExtraSmall,
        right: Spacing.extraExtraSmall,
      ),
      child: Row(
        spacing: Spacing.extraSmall,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ?leading,
          Text(title, style: context.textTheme.headlineSmall),
          ...?actions,
        ],
      ),
    );
  }
}
