import 'package:alfie_flutter/ui/core/themes/colors.dart';
import 'package:alfie_flutter/ui/core/themes/spacing.dart';
import 'package:alfie_flutter/utils/build_context_extensions.dart';
import 'package:flutter/material.dart';

/// Displays a primary color swatch alongside an indicator of additional available colors.
///
/// Shows the main item [color]
/// and how many *other* color options exist.
class ColorSwatchWidget extends StatelessWidget {
  /// The primary color to display in the square swatch.
  final Color color;

  /// The total number of available colors.
  ///
  /// The text indicator will display this value minus one (e.g., "+3" if total size is 4).
  final int totalColors;

  static const double _swatchSize = 24.0;

  const ColorSwatchWidget({
    required this.color,
    required this.totalColors,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          margin: EdgeInsets.all(Spacing.extraExtraExtraSmall),
          width: _swatchSize,
          height: _swatchSize,
          decoration: BoxDecoration(
            color: color,
            border: Border.all(color: AppColors.neutral300),
          ),
        ),

        Padding(
          padding: EdgeInsets.only(left: Spacing.extraExtraExtraSmall),
          child: Text(
            '+${totalColors - 1}',
            style: context.textTheme.bodyMedium,
          ),
        ),
      ],
    );
  }
}
