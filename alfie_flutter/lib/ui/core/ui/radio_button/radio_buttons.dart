import 'package:alfie_flutter/ui/core/themes/radio_button_theme.dart';
import 'package:flutter/material.dart';

/// A generic radio button group widget for selecting a single option from a list.
///
/// [RadioButtons] provides an interactive multi-option selector with:
/// - Enum-based type-safe options (generic constraint: `T extends Enum`)
/// - Custom label formatting through [labelBuilder]
/// - Individual option disabling via [disabledOptions]
/// - Global disabled state through [isDisabled]
/// - Per-option and group-level disable logic
///
/// The widget manages its own selection state and notifies parent widgets
/// through the [onChanged] callback. Options can be disabled individually
/// or the entire group can be disabled, preventing any selection changes.
///
/// Example:
/// ```dart
/// enum Status { active, inactive, pending }
///
/// RadioButtons<Status>(
///   options: Status.values,
///   initialValue: Status.active,
///   labelBuilder: (status) => status.name,
///   onChanged: (selected) => print('Selected: $selected'),
///   disabledOptions: [Status.pending],
/// )
/// ```
class RadioButtons<T extends Enum> extends StatefulWidget {
  /// The complete list of available options to display.
  final List<T> options;

  /// Options that should be individually disabled but still visible.
  ///
  /// When an option is in this list, it cannot be selected but remains
  /// visible with disabled styling.
  final List<T> disabledOptions;

  /// The initially selected option value.
  final T initialValue;

  /// Called when the user selects a different option.
  ///
  /// Receives the newly selected option value.
  final ValueChanged<T> onChanged;

  /// Function to generate display labels for each option.
  ///
  /// Receives an option and returns its display label string.
  /// Example: `(status) => status.name` or `(status) => status.displayName`
  final String Function(T) labelBuilder;

  /// Whether the entire radio group is disabled.
  ///
  /// When true, no option can be selected and all options appear disabled.
  /// Takes precedence over individual [disabledOptions].
  final bool isDisabled;

  const RadioButtons({
    super.key,
    required this.options,
    this.disabledOptions = const [],
    required this.initialValue,
    required this.onChanged,
    required this.labelBuilder,
    this.isDisabled = false,
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

  /// Updates the selected value if the group is not disabled.
  ///
  /// Does nothing if [newValue] is null or if the entire group is disabled.
  void _updateValue(T? newValue) {
    if (newValue != null && !widget.isDisabled) {
      setState(() {
        _currentValue = newValue;
      });
      widget.onChanged(newValue);
    }
  }

  /// Determines if a specific option is disabled.
  ///
  /// An option is disabled if the entire group is disabled OR if it appears
  /// in the [disabledOptions] list.
  bool _isOptionDisabled(T option) {
    return widget.isDisabled || widget.disabledOptions.contains(option);
  }

  @override
  Widget build(BuildContext context) {
    final radioTheme = Theme.of(context).radioTheme;

    return RadioGroup<T>(
      groupValue: _currentValue,
      onChanged: _updateValue,
      child: Column(
        children: widget.options.map((option) {
          final isOptionDisabled = _isOptionDisabled(option);
          final isSelected = _currentValue == option;

          return ListTile(
            enabled: !isOptionDisabled,
            title: Text(
              widget.labelBuilder(option),
              style: radioTheme.getLabelStyle(
                context,
                isOptionDisabled,
                isSelected,
              ),
            ),
            leading: Radio<T>(value: option, enabled: !isOptionDisabled),
            onTap: isOptionDisabled ? null : () => _updateValue(option),
          );
        }).toList(),
      ),
    );
  }
}
