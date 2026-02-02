import 'package:alfie_flutter/ui/core/themes/checkbox_theme.dart';
import 'package:alfie_flutter/ui/core/themes/spacing.dart';
import 'package:flutter/material.dart';

/// A checkbox tile widget with label, optional info text, and error state support.
///
/// [CheckboxTile] provides an interactive checkbox component with:
/// - Label text and optional supplementary info text
/// - Tri-state checkbox (true, false, null) support
/// - Error state styling when validation fails
/// - Disabled state when no [onChanged] callback is provided
///
/// The widget manages its own checked state and notifies parent widgets
/// of value changes through the [onChanged] callback. Setting [hasError]
/// to true prevents toggling and applies error styling to the checkbox.
///
/// Example:
/// ```dart
/// CheckboxTile(
///   label: 'I agree to the terms',
///   info: '(required)',
///   value: false,
///   onChanged: (value) => print('Checkbox: $value'),
/// )
/// ```
class CheckboxTile extends StatefulWidget {
  /// The main label text displayed next to the checkbox.
  final String label;

  /// Optional supplementary text displayed next to the label (e.g. no. of items available)
  final String? info;

  /// The initial checkbox value (true, false, or null).
  final bool? value;

  /// Whether the checkbox is in an error state.
  ///
  /// When true, prevents toggling and applies error styling to the checkbox.
  final bool hasError;

  /// Called when the checkbox value changes.
  ///
  /// If null, the checkbox is disabled and cannot be toggled.
  final ValueChanged<bool?>? onChanged;

  const CheckboxTile({
    super.key,
    required this.label,
    this.info,
    this.value,
    this.onChanged,
    this.hasError = false,
  });

  @override
  State<CheckboxTile> createState() => _CheckboxTileState();
}

class _CheckboxTileState extends State<CheckboxTile> {
  late bool? _currentValue;

  @override
  void initState() {
    super.initState();
    _currentValue = widget.value;
  }

  /// Toggles the checkbox value, cycling through true → false → true. null states change to false.
  ///
  /// Does nothing if [hasError] is true or if [onChanged] is null (disabled).
  void _handleToggle() {
    if (widget.hasError || widget.onChanged == null) return;

    final nextValue = _currentValue == false ? true : false;

    setState(() {
      _currentValue = nextValue;
    });

    widget.onChanged?.call(nextValue);
  }

  @override
  Widget build(BuildContext context) {
    final isDisabled = widget.onChanged == null;
    final checkboxTheme = Theme.of(context).checkboxTheme;

    return InkWell(
      onTap: isDisabled ? null : _handleToggle,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: Spacing.extraExtraSmall),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Row(
                spacing: Spacing.extraSmall,
                children: [
                  Text(
                    widget.label,
                    style: checkboxTheme.getLabelStyle(
                      context,
                      isDisabled,
                      _currentValue,
                    ),
                  ),
                  if (widget.info != null)
                    Text(
                      widget.info!,
                      style: checkboxTheme.getInfoStyle(context, isDisabled),
                    ),
                ],
              ),
            ),
            Checkbox(
              value: _currentValue,
              tristate: true,
              onChanged: isDisabled ? null : (_) => _handleToggle(),
              isError: widget.hasError,
            ),
          ],
        ),
      ),
    );
  }
}
