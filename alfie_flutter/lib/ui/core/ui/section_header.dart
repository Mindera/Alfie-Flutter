import 'package:flutter/material.dart';

import 'package:alfie_flutter/ui/core/themes/typography.dart';
import 'package:alfie_flutter/utils/build_context_extensions.dart';

/// A standardized header for screen sections, featuring a title and an optional action link.
class SectionHeader extends StatelessWidget {
  final String title;

  /// The label displayed for the action link (e.g., "See all").
  final String? linkText;

  /// An optional callback triggered when the action link is pressed.
  final VoidCallback? onLinkPressed;

  const SectionHeader({
    super.key,
    required this.title,
    this.linkText,
    this.onLinkPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Text(
            title,
            style: context.textTheme.headlineSmall,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        if (linkText != null)
          GestureDetector(
            onTap: onLinkPressed,
            child: Text(linkText!, style: context.textTheme.linkMedium),
          ),
      ],
    );
  }
}
