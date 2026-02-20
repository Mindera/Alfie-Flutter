import 'package:alfie_flutter/ui/core/themes/spacing.dart';
import 'package:alfie_flutter/utils/build_context_extensions.dart';
import 'package:flutter/material.dart';

/// A custom top navigation header, serving as a lightweight alternative to [AppBar].
///
/// Automatically handles the device's top safe area (e.g., status bar) padding
/// and dynamically balances the [title] between the [leading] and [actions] slots.
class Header extends StatelessWidget {
  /// The primary text to display. Truncates with an ellipsis if it exceeds available space.
  final String title;

  /// Displayed at the start of the row, typically used for a back button
  final Widget? leading;

  /// Displayed at the end of the row.
  ///
  /// If omitted, a transparent placeholder is rendered to maintain the visual centering
  /// of the [title] within the available space.
  final List<Widget>? actions;

  const Header({super.key, required this.title, this.leading, this.actions});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: Spacing.extraExtraSmall + context.mediaQuery.padding.top,
        left: Spacing.extraExtraSmall,
        bottom: Spacing.extraExtraSmall,
        right: Spacing.extraExtraSmall,
      ),
      child: Row(
        spacing: Spacing.extraSmall,
        children: [
          ?leading,

          Expanded(
            child: Text(
              title,
              style: context.textTheme.headlineSmall,
              textAlign: TextAlign.center,
              maxLines: 1,
              softWrap: false,
              overflow: TextOverflow.ellipsis,
            ),
          ),

          Row(
            mainAxisSize: MainAxisSize.min,
            children:
                actions ??
                const [SizedBox.square(dimension: Spacing.extraLarge)],
          ),
        ],
      ),
    );
  }
}
