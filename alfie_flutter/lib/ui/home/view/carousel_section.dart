import 'package:alfie_flutter/ui/core/themes/spacing.dart';
import 'package:alfie_flutter/ui/core/ui/carousel.dart';
import 'package:alfie_flutter/ui/core/ui/section_header.dart';
import 'package:alfie_flutter/utils/build_context_extensions.dart';
import 'package:alfie_flutter/utils/typography_utils.dart';
import 'package:flutter/material.dart';

class CarouselSection<T> extends StatelessWidget {
  const CarouselSection({
    super.key,
    required this.title,
    required this.items,
    required this.itemBuilder,
    this.labelBuilder,
    this.contentSize = 100,
    this.labelMaxLines = 1,
    this.linkText = "text link",
    this.itemSpacing = Spacing.extraSmall,
    this.contentSpacing = Spacing.extraExtraSmall,
  });

  final String title;
  final String linkText;
  final List<T> items;
  final double contentSize;
  final int labelMaxLines;

  final double itemSpacing;
  final double contentSpacing;

  final Widget Function(T item) itemBuilder;
  final String Function(T item)? labelBuilder;

  @override
  Widget build(BuildContext context) {
    final double textHeight = context.textTheme.bodyMedium!.textHeight!;

    final double maxHeight =
        contentSize + contentSpacing + (textHeight * labelMaxLines);

    return Column(
      spacing: Spacing.extraSmall,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionHeader(title: title, linkText: linkText),
        Carousel(
          maxHeight: maxHeight,
          itemSpacing: itemSpacing,
          itemExtent: contentSize + itemSpacing,
          shrinkExtent: (contentSize / 2) + itemSpacing,
          children: items
              .map(
                (item) => Column(
                  mainAxisSize: MainAxisSize.min,
                  spacing: contentSpacing,
                  children: [
                    itemBuilder(item),
                    if (labelBuilder != null)
                      Text(
                        labelBuilder!(item),
                        maxLines: labelMaxLines,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.center,
                      ),
                  ],
                ),
              )
              .toList(),
        ),
      ],
    );
  }
}
