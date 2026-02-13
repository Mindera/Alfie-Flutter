import 'package:alfie_flutter/ui/core/themes/app_icons.dart';
import 'package:alfie_flutter/ui/core/themes/spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

/// A range slider with manual input fields for precise value control.
///
/// [AppSlider] combines an interactive [RangeSlider] with dual number input
/// fields, allowing users to adjust ranges both via slider dragging and direct
/// text entry.
///
/// Features:
/// - Synchronized slider and text field updates
/// - Automatic range validation (start ≤ end)
/// - Numeric input with automatic clamping to [min]–[max] bounds
/// - Prefix icon in input fields
/// - Values are rounded to integers for display
///
/// Example:
/// ```dart
/// AppSlider(
///   min: 0,
///   max: 1000,
///   initialValues: RangeValues(100, 800),
///   onChanged: (range) => print('Range: ${range.start}-${range.end}'),
/// )
/// ```
class AppSlider extends HookWidget {
  /// The minimum allowed value in the range.
  final double min;

  /// The maximum allowed value in the range.
  final double max;

  /// The initial start and end values of the range.
  final RangeValues initialValues;

  /// Called when the range values change via slider or text input.
  final ValueChanged<RangeValues> onChanged;

  AppSlider({
    super.key,
    required this.min,
    required this.max,
    final RangeValues? initialValues,
    required this.onChanged,
  }) : initialValues = initialValues ?? RangeValues(min, max);

  String _formatValue(double value) {
    return value.round().toString();
  }

  @override
  Widget build(BuildContext context) {
    final TextEditingController startController = useTextEditingController();
    final TextEditingController endController = useTextEditingController();
    final ValueNotifier<RangeValues> currentValues = useState(initialValues);

    /// Updates the range values and syncs both the slider and text fields.
    ///
    /// Ensures both controllers display the new values and notifies the parent
    /// widget through [onChanged].
    void updateValues(RangeValues newValues) {
      currentValues.value = newValues;
      startController.text = _formatValue(newValues.start);
      endController.text = _formatValue(newValues.end);
      onChanged(newValues);
    }

    /// Handles text field submission, ensuring start ≤ end invariant.
    ///
    /// If the input would violate the range order (start > end), the values
    /// are automatically swapped to maintain the invariant. Unparseable input
    /// resets the field to its previous value.
    void handleTextFieldSubmit(double newValue, bool isStartField) {
      final clampedValue = newValue.clamp(min, max);

      final start = isStartField ? clampedValue : currentValues.value.start;
      final end = isStartField ? currentValues.value.end : clampedValue;

      if (start <= end) {
        updateValues(RangeValues(start, end));
      } else {
        updateValues(RangeValues(end, start));
      }
    }

    /// Builds a text input field with numeric keyboard
    ///
    /// The field accepts numeric input, displays an icon, and validates
    /// input on submission. Invalid input reverts to the previous value.
    Widget buildTextField(
      TextEditingController controller,
      ValueChanged<double> onValidSubmit,
    ) {
      return TextFormField(
        controller: controller,
        keyboardType: TextInputType.number,
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
          prefixIcon: Icon(AppIcons.currencyDollar),
        ),
        onFieldSubmitted: (value) {
          final double? parsed = double.tryParse(value);
          if (parsed != null) {
            onValidSubmit(parsed);
          } else {
            // Reset to the current synced value if parsing fails
            controller.text = _formatValue(
              controller == startController
                  ? currentValues.value.start
                  : currentValues.value.end,
            );
          }
        },
      );
    }

    return Column(
      spacing: Spacing.extraSmall,
      children: [
        RangeSlider(
          padding: EdgeInsets.zero,
          values: currentValues.value,
          min: min,
          max: max,
          onChanged: updateValues,
        ),
        Row(
          spacing: Spacing.small,
          children: [
            Expanded(
              child: buildTextField(startController, (val) {
                handleTextFieldSubmit(val, true);
              }),
            ),
            Expanded(
              child: buildTextField(endController, (val) {
                handleTextFieldSubmit(val, false);
              }),
            ),
          ],
        ),
      ],
    );
  }
}
