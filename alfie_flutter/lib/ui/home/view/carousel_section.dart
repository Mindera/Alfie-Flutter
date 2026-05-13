import 'package:flutter/material.dart';

import 'package:alfie_flutter/ui/core/themes/spacing.dart';
import 'package:alfie_flutter/ui/core/ui/carousel.dart';
import 'package:alfie_flutter/ui/core/ui/section_header.dart';
import 'package:alfie_flutter/utils/build_context_extensions.dart';
import 'package:alfie_flutter/utils/typography_utils.dart';

/// A layout template composing a [SectionHeader] with a horizontally scrolling [Carousel].
///
/// This widget is highly reusable and data-agnostic, relying on the generic type `[T]`
/// and builder delegates to render the visual elements and text labels for each item.
class CarouselSection<T> extends StatelessWidget {
  /// The textual title anchored to the top of the section.
  final String title;

  /// The call-to-action text displayed opposite the [title].
  final String linkText;

  /// The underlying dataset driving the carousel generation.
  final List<T> items;

  /// The fixed base dimension applied to the height and width of the visual card.
  final double contentSize;

  /// The text truncation limit applied to the item's label.
  final int labelMaxLines;

  /// The horizontal padding injected between items in the list.
  final double itemSpacing;

  /// The vertical padding injected between the visual card and its text label.
  final double contentSpacing;

  /// Delegate function responsible for rendering the primary visual [Widget] of the item.
  final Widget Function(T item) itemBuilder;

  /// Delegate function responsible for extracting the localized text string of the item.
  final String Function(T item)? labelBuilder;

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

  @override
  Widget build(BuildContext context) {
    if (context.textTheme.bodyMedium == null) {
      throw Exception("Body medium is not defined in the active theme.");
    }

    final double textHeight = context.textTheme.bodyMedium!.textHeight;

    final double maxHeight =
        contentSize +
        (labelBuilder != null
            ? contentSpacing + textHeight * labelMaxLines
            : 0);

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
          children: items.map((item) => _buildCarouselItem(item)).toList(),
        ),
      ],
    );
  }

  Widget _buildCarouselItem(T item) {
    return Column(
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
    );
  }
}
