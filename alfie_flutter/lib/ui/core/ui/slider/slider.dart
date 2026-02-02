import 'package:alfie_flutter/ui/core/themes/app_icons.dart';
import 'package:alfie_flutter/ui/core/themes/spacing.dart';
import 'package:flutter/material.dart';

class AppSlider extends StatefulWidget {
  final double min;
  final double max;
  final RangeValues initialValues;
  final ValueChanged<RangeValues> onChanged;

  const AppSlider({
    super.key,
    required this.min,
    required this.max,
    required this.initialValues,
    required this.onChanged,
  });

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
      text: _currentValues.start.round().toString(),
    );
    _endController = TextEditingController(
      text: _currentValues.end.round().toString(),
    );
  }

  void _updateValues(RangeValues newValues) {
    setState(() {
      _currentValues = newValues;
      _startController.text = newValues.start.round().toString();
      _endController.text = newValues.end.round().toString();
    });
    widget.onChanged(newValues);
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
                if (val <= _currentValues.end) {
                  _updateValues(RangeValues(val, _currentValues.end));
                } else {
                  _updateValues(RangeValues(_currentValues.end, val));
                }
              }),
            ),
            Expanded(
              child: _buildTextField(_endController, (val) {
                if (val >= _currentValues.start) {
                  _updateValues(RangeValues(_currentValues.start, val));
                } else {
                  _updateValues(RangeValues(val, _currentValues.start));
                }
              }),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildTextField(
    TextEditingController controller,
    Function(double) onValidSubmit,
  ) {
    return TextFormField(
      controller: controller,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        prefixIcon: const Icon(AppIcons.currencyDollar),
      ),

      onFieldSubmitted: (value) {
        final double? parsed = double.tryParse(value);
        if (parsed != null) {
          onValidSubmit(parsed.clamp(widget.min, widget.max));
        } else {
          // Reset to current value if parsing fails
          controller.text = controller == _startController
              ? _currentValues.start.round().toString()
              : _currentValues.end.round().toString();
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
