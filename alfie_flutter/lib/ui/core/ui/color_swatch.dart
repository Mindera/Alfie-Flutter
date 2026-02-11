import 'package:alfie_flutter/ui/core/themes/colors.dart';
import 'package:alfie_flutter/ui/core/themes/spacing.dart';
import 'package:alfie_flutter/ui/core/themes/typography.dart';
import 'package:flutter/material.dart';

class ColorSwatchWidget extends StatelessWidget {
  final Color color;
  final int size;

  const ColorSwatchWidget({required this.color, required this.size, super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          margin: EdgeInsets.all(Spacing.extraExtraExtraSmall),
          width: 24,
          height: 24,
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.neutral300),
            color: color,
          ),
        ),
        Container(
          padding: EdgeInsets.only(left: Spacing.extraExtraExtraSmall),
          alignment: Alignment.centerRight,
          child: Text("+${size - 1}", style: context.textTheme.bodyMedium),
        ),
      ],
    );
  }
}
