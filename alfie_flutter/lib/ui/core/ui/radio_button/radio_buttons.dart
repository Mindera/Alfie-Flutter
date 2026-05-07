import 'package:alfie_flutter/ui/core/themes/radio_button_theme.dart';
import 'package:alfie_flutter/ui/core/themes/spacing.dart';
import 'package:alfie_flutter/utils/build_context_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

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
class RadioButtons<T> extends HookWidget {
  /// The complete list of available options to display.
  final List<T> options;

  /// Options that should be individually disabled but still visible.
  ///
  /// When an option is in this list, it cannot be selected but remains
  /// visible with disabled styling.
  final List<T> disabledOptions;

  /// The initially selected option value.
  final T? initialValue;

  /// Called when the user selects a different option.
  ///
  /// Receives the newly selected option value.
  final ValueChanged<T> onChanged;

  /// Function to generate display labels for each option.
  ///
  /// Receives an option and returns its display label string.
  /// Example: `(status) => status.name` or `(status) => status.displayName`
  final String Function(T) labelBuilder;
  final String Function(T)? descriptionBuilder;
  final Widget Function(T)? iconBuilder;

  /// Whether the entire radio group is disabled.
  ///
  /// When true, no option can be selected and all options appear disabled.
  /// Takes precedence over individual [disabledOptions].
  final bool isDisabled;

  final bool radionOnRight;

  const RadioButtons({
    super.key,
    required this.options,
    this.disabledOptions = const [],
    this.initialValue,
    required this.onChanged,
    required this.labelBuilder,
    this.descriptionBuilder,
    this.isDisabled = false,
    this.radionOnRight = false,
    this.iconBuilder,
  });

  /// Determines if a specific option is disabled.
  ///
  /// An option is disabled if the entire group is disabled OR if it appears
  /// in the [disabledOptions] list.
  bool _isOptionDisabled(T option) {
    return isDisabled || disabledOptions.contains(option);
  }

  @override
  Widget build(BuildContext context) {
    final state = useState(initialValue);

    /// Updates the selected value if the group is not disabled.
    ///
    /// Does nothing if [newValue] is null or if the entire group is disabled.
    void updateValue(T? newValue) {
      if (newValue != null && !isDisabled) {
        state.value = newValue;
        onChanged(newValue);
      }
    }

    return RadioGroup<T>(
      groupValue: state.value,
      onChanged: updateValue,
      child: Column(
        spacing: Spacing.small,
        children: options.map((option) {
          return RadioButtonTile(
            option: option,
            isDisabled: _isOptionDisabled(option),
            labelBuilder: labelBuilder,
            iconBuilder: iconBuilder,
            descriptionBuilder: descriptionBuilder,
            radionOnRight: radionOnRight,
            isSelected: state.value == option,
            updateValue: updateValue,
          );
        }).toList(),
      ),
    );
  }
}

class RadioButtonTile<T> extends StatelessWidget {
  final T option;
  final bool isDisabled;
  final String Function(T) labelBuilder;
  final String Function(T)? descriptionBuilder;
  final Widget Function(T)? iconBuilder;
  final bool radionOnRight;
  final bool isSelected;
  final void Function(T? newValue) updateValue;
  const RadioButtonTile({
    super.key,
    required this.option,
    this.isDisabled = false,
    required this.labelBuilder,
    this.descriptionBuilder,
    this.iconBuilder,
    this.radionOnRight = true,
    this.isSelected = true,
    required this.updateValue,
  });

  @override
  Widget build(BuildContext context) {
    final radioTheme = context.theme.radioTheme;

    return ListTile(
      enabled: !isDisabled,
      title: Column(
        spacing: Spacing.extraSmall,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            labelBuilder(option),
            style: radioTheme.getLabelStyle(context, isDisabled, isSelected),
          ),
          if (descriptionBuilder != null)
            Text(
              descriptionBuilder!(option),
              style: radioTheme.getDescriptionStyle(
                context,
                isDisabled,
                isSelected,
              ),
            ),
        ],
      ),
      leading: radionOnRight
          ? iconBuilder?.call(option)
          : Radio<T>(value: option, enabled: !isDisabled),
      trailing: radionOnRight
          ? Radio<T>(value: option, enabled: !isDisabled)
          : iconBuilder?.call(option),
      onTap: isDisabled ? null : () => updateValue(option),
    );
  }
}
