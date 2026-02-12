import 'package:alfie_flutter/ui/core/themes/app_icons.dart';
import 'package:alfie_flutter/ui/core/themes/spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

/// A text input field with label, optional leading icon, and clearable state.
///
/// [AppInputField] provides a complete text input component with:
/// - Associated label text above the input
/// - Optional leading icon for semantic context (e.g., search icon)
/// - Context-aware clear button that appears only when focused and non-empty
/// - Text change notifications through [onChanged] callback
///
/// The clear button provides immediate text deletion with a single tap,
/// improving usability for quick corrections without manual text selection.
///
/// Example:
/// ```dart
/// AppInputField(
///   'Search',
///   hintText: 'Enter search term...',
///   leadingIcon: Icons.search,
///   onChanged: (value) => print('Search: $value'),
/// )
/// ```
class AppInputField extends HookWidget {
  /// The label text displayed above the input field.
  final String label;

  /// Placeholder text shown when the field is empty.
  final String hintText;

  /// Optional icon displayed at the start of the input field.
  ///
  /// Commonly used for semantic context (e.g., search, email, phone icons).
  final IconData? leadingIcon;

  /// Called whenever the input text changes.
  ///
  /// Receives the current text value.
  final ValueChanged<String>? onChanged;

  const AppInputField(
    this.label, {
    super.key,
    this.hintText = 'Placeholder',
    this.leadingIcon,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final TextEditingController controller = useTextEditingController();
    final FocusNode focusNode = useFocusNode();

    useListenable(Listenable.merge([controller, focusNode]));

    /// Clears the input field and notifies the parent widget.
    void clearInput() {
      controller.clear();
      onChanged?.call('');
    }

    final showClearButton = focusNode.hasFocus && controller.text.isNotEmpty;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: Spacing.extraExtraSmall,
      children: [
        Text(label, style: Theme.of(context).textTheme.bodyMedium),
        TextFormField(
          controller: controller,
          focusNode: focusNode,
          onChanged: onChanged,
          decoration: InputDecoration(
            hintText: hintText,
            prefixIcon: leadingIcon != null ? Icon(leadingIcon) : null,
            suffixIcon: showClearButton
                ? IconButton(
                    icon: const Icon(AppIcons.clear),
                    onPressed: clearInput,
                  )
                : null,
          ),
        ),
      ],
    );
  }
}
