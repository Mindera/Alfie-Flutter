import 'package:alfie_flutter/ui/core/themes/app_icons.dart';
import 'package:alfie_flutter/ui/core/themes/spacing.dart';
import 'package:flutter/material.dart';

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
class AppSlider extends StatefulWidget {
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

  @override
  State<AppSlider> createState() => _AppSliderState();
}

class _AppSliderState extends State<AppSlider> {
  late RangeValues _currentValues;
  late TextEditingController _startController;
  late TextEditingController _endController;

  @override
  void initState() {
    super.initState();
    _currentValues = widget.initialValues;
    _startController = TextEditingController(
      text: _formatValue(_currentValues.start),
    );
    _endController = TextEditingController(
      text: _formatValue(_currentValues.end),
    );
  }

  /// Formats a double value as a rounded integer string for display.
  String _formatValue(double value) => value.round().toString();

  /// Updates the range values and syncs both the slider and text fields.
  ///
  /// Ensures both controllers display the new values and notifies the parent
  /// widget through [onChanged].
  void _updateValues(RangeValues newValues) {
    setState(() {
      _currentValues = newValues;
      _startController.text = _formatValue(newValues.start);
      _endController.text = _formatValue(newValues.end);
    });
    widget.onChanged(newValues);
  }

  /// Handles text field submission, ensuring start ≤ end invariant.
  ///
  /// If the input would violate the range order (start > end), the values
  /// are automatically swapped to maintain the invariant. Unparseable input
  /// resets the field to its previous value.
  void _handleTextFieldSubmit(double newValue, bool isStartField) {
    final clampedValue = newValue.clamp(widget.min, widget.max);

    final start = isStartField ? clampedValue : _currentValues.start;
    final end = isStartField ? _currentValues.end : clampedValue;

    if (start <= end) {
      _updateValues(RangeValues(start, end));
    } else {
      _updateValues(RangeValues(end, start));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: Spacing.extraSmall,
      children: [
        RangeSlider(
          padding: EdgeInsets.zero,
          values: _currentValues,
          min: widget.min,
          max: widget.max,
          onChanged: _updateValues,
        ),
        Row(
          spacing: Spacing.small,
          children: [
            Expanded(
              child: _buildTextField(_startController, (val) {
                _handleTextFieldSubmit(val, true);
              }),
            ),
            Expanded(
              child: _buildTextField(_endController, (val) {
                _handleTextFieldSubmit(val, false);
              }),
            ),
          ],
        ),
      ],
    );
  }

  /// Builds a text input field with numeric keyboard
  ///
  /// The field accepts numeric input, displays an icon, and validates
  /// input on submission. Invalid input reverts to the previous value.
  Widget _buildTextField(
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
            controller == _startController
                ? _currentValues.start
                : _currentValues.end,
          );
        }
      },
    );
  }

  @override
  void dispose() {
    _startController.dispose();
    _endController.dispose();
    super.dispose();
  }
}
