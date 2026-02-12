import 'package:alfie_flutter/ui/core/themes/checkbox_theme.dart';
import 'package:alfie_flutter/ui/core/themes/spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

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
class CheckboxTile extends HookWidget {
  /// The main label text displayed next to the checkbox.
  final String label;

  /// Optional supplementary text displayed next to the label (e.g. no. of items available)
  final String? info;

  /// The initial checkbox value (true, false, or null).
  final bool? initialValue;

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
    this.initialValue,
    this.onChanged,
    this.hasError = false,
  });

  @override
  Widget build(BuildContext context) {
    final state = useState<bool?>(initialValue);
    final isDisabled = onChanged == null;
    final checkboxTheme = Theme.of(context).checkboxTheme;

    void handleToggle() {
      if (hasError || isDisabled) return;
      // Cycle logic: true/null -> false, false -> true
      final nextValue = (state.value == false) ? true : false;
      state.value = nextValue;
      onChanged?.call(nextValue);
    }

    return InkWell(
      onTap: isDisabled ? null : handleToggle,
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
                    label,
                    style: checkboxTheme.getLabelStyle(
                      context,
                      isDisabled,
                      state.value,
                    ),
                  ),
                  if (info != null)
                    Text(
                      info!,
                      style: checkboxTheme.getInfoStyle(context, isDisabled),
                    ),
                ],
              ),
            ),
            Checkbox(
              value: state.value,
              tristate: true,
              onChanged: isDisabled ? null : (_) => handleToggle(),
              isError: hasError,
            ),
          ],
        ),
      ),
    );
  }
}
