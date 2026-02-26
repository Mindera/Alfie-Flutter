import 'package:flutter/material.dart';

import 'package:alfie_flutter/ui/core/themes/spacing.dart';
import 'package:alfie_flutter/ui/core/ui/carousel.dart';
import 'package:alfie_flutter/ui/core/ui/section_header.dart';
import 'package:alfie_flutter/utils/build_context_extensions.dart';
import 'package:alfie_flutter/utils/typography_utils.dart';

/// A generic section widget that pairs a header with a horizontally scrollable carousel.
///
/// This View component remains entirely
/// agnostic of the data model. Gets the list of [items],
/// and the parent widget dictates rendering via [itemBuilder] and [labelBuilder].
class CarouselSection<T> extends StatelessWidget {
  /// The title displayed in the section header.
  final String title;

  /// The text displayed for the section header's action link.
  final String linkText;

  /// The collection of items to display.
  final List<T> items;

  /// The primary dimension (used for both width and base height) of the rendered item.
  final double contentSize;

  /// The maximum number of lines allowed for the item's text label.
  final int labelMaxLines;

  /// The horizontal space between items in the carousel.
  final double itemSpacing;

  /// The vertical space between the item's main content and its label.
  final double contentSpacing;

  /// A builder function that constructs the primary visual widget for an item.
  final Widget Function(T item) itemBuilder;

  /// An optional builder function that extracts the text label for an item.
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
    // Safely calculate text height to prevent layout crashes if the theme is missing.
    if (context.textTheme.bodyMedium == null) {
      throw Exception("Body medium is not defined");
    }

    final double textHeight = context.textTheme.bodyMedium!.textHeight;

    // Dynamically calculate the maximum height the carousel needs to accommodate
    // the content size, the spacing, and the maximum possible lines of text.
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
