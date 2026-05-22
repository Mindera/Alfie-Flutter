import 'package:alfie_flutter/ui/core/themes/checkbox_theme.dart';
import 'package:alfie_flutter/ui/core/themes/spacing.dart';
import 'package:alfie_flutter/utils/build_context_extensions.dart';
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

  /// Called when the checkbox value changes.
  ///
  /// If null, the checkbox is disabled and cannot be toggled.
  final ValueChanged<bool>? onChanged;

  final bool leftCheckbox;

  final String? Function(bool?)? validator;

  const CheckboxTile({
    super.key,
    required this.label,
    this.info,
    this.initialValue,
    this.onChanged,
    this.leftCheckbox = false,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    final checkboxTheme = context.theme.checkboxTheme;
    final isDisabled = onChanged == null;

    return FormField<bool>(
      initialValue: initialValue,
      validator: validator,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      builder: (FormFieldState<bool> field) {
        void handleToggle() {
          if (isDisabled) return;

          final nextValue = (field.value == false) ? true : false;

          field.didChange(nextValue);
          onChanged?.call(nextValue);
        }

        final checkBox = SizedBox(
          width: 24,
          height: 24,
          child: Checkbox(
            value: field.value,
            tristate: true,
            onChanged: isDisabled ? null : (_) => handleToggle(),
            isError: field.hasError,
          ),
        );

        return InkWell(
          onTap: isDisabled ? null : handleToggle,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (leftCheckbox) ...[
                    checkBox,
                    const SizedBox(width: Spacing.extraSmall),
                  ],

                  Expanded(
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            label,
                            style: checkboxTheme.getLabelStyle(
                              context,
                              isDisabled,
                              field.value,
                            ),
                          ),
                        ),
                        if (info != null)
                          Text(
                            info!,
                            style: checkboxTheme.getInfoStyle(
                              context,
                              isDisabled,
                            ),
                          ),
                      ],
                    ),
                  ),

                  if (!leftCheckbox) checkBox,
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
