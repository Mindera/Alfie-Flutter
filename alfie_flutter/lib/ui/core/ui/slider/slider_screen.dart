import 'package:alfie_flutter/ui/core/themes/spacing.dart';
import 'package:alfie_flutter/ui/core/ui/slider/slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

enum Options { option1, option2, option3 }

class SliderScreen extends ConsumerWidget {
  const SliderScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      color: Theme.of(context).scaffoldBackgroundColor,
      child: SingleChildScrollView(
        child: Column(
          spacing: Spacing.large,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Slider', style: TextTheme.of(context).displayLarge),
            AppSlider(
              min: 0,
              max: 10000,
              onChanged: (RangeValues value) {},
              initialValues: RangeValues(0, 2100),
            ),
          ],
        ),
      ),
    );
  }
}
