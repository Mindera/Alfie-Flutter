import 'package:alfie_flutter/ui/core/themes/typography.dart';
import 'package:alfie_flutter/utils/build_context_extensions.dart';
import 'package:flutter/material.dart';

class SectionHeader extends StatelessWidget {
  final String title;
  final String textLink;
  final String? textLinkPath;

  const SectionHeader({
    super.key,
    required this.title,
    required this.textLink,
    this.textLinkPath,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: context.textTheme.headlineSmall),
        Text(textLink, style: context.textTheme.linkMedium),
      ],
    );
  }
}
