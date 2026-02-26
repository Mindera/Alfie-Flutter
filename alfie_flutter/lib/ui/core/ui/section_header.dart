import 'package:alfie_flutter/ui/core/themes/typography.dart';
import 'package:alfie_flutter/utils/build_context_extensions.dart';
import 'package:flutter/material.dart';

class SectionHeader extends StatelessWidget {
  final String title;
  final String linkText;
  final String? textLinkPath;

  const SectionHeader({
    super.key,
    required this.title,
    required this.linkText,
    this.textLinkPath,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: context.textTheme.headlineSmall),
        Text(linkText, style: context.textTheme.linkMedium),
      ],
    );
  }
}
