import 'package:alfie_flutter/ui/core/themes/radio_button_theme.dart';
import 'package:flutter/material.dart';

class RadioButtons<T extends Enum> extends StatefulWidget {
  final List<T> options;
  final List<T> disabledOptions;
  final T initialValue;
  final ValueChanged<T> onChanged;
  final String Function(T) labelBuilder;
  final bool isDisabled;
  final bool hasError;

  const RadioButtons({
    super.key,
    required this.options,
    this.disabledOptions = const [],
    required this.initialValue,
    required this.onChanged,
    required this.labelBuilder,
    this.isDisabled = false,
    this.hasError = false,
  });

  @override
  State<RadioButtons<T>> createState() => _RadioButtonsState<T>();
}

class _RadioButtonsState<T extends Enum> extends State<RadioButtons<T>> {
  late T _currentValue;

  @override
  void initState() {
    super.initState();
    _currentValue = widget.initialValue;
  }

  void _updateValue(T? newValue) {
    if (newValue != null && !widget.isDisabled) {
      setState(() {
        _currentValue = newValue;
      });
      widget.onChanged(newValue);
    }
  }

  @override
  Widget build(BuildContext context) {
    return RadioGroup<T>(
      groupValue: _currentValue,
      onChanged: _updateValue,
      child: Column(
        children: widget.options.map((option) {
          final bool isOptionDisabled =
              widget.isDisabled || widget.disabledOptions.contains(option);
          final bool isSelected = _currentValue == option;

          return ListTile(
            enabled: !isOptionDisabled,
            title: Text(
              widget.labelBuilder(option),
              style: Theme.of(
                context,
              ).radioTheme.getLabelStyle(context, isOptionDisabled, isSelected),
            ),
            leading: Radio<T>(
              value: option,
              enabled: isOptionDisabled ? false : true,
            ),
            onTap: isOptionDisabled ? null : () => _updateValue(option),
          );
        }).toList(),
      ),
    );
  }
}
