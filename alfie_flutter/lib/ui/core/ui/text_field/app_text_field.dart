import 'package:alfie_flutter/ui/core/themes/app_icons.dart';
import 'package:alfie_flutter/ui/core/themes/spacing.dart';
import 'package:flutter/material.dart';

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
class AppInputField extends StatefulWidget {
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
  State<AppInputField> createState() => _AppInputFieldState();
}

class _AppInputFieldState extends State<AppInputField> {
  late final TextEditingController _controller;
  late final FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    _focusNode = FocusNode();
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  /// Clears the input field and notifies the parent widget.
  void _clearInput() {
    _controller.clear();
    widget.onChanged?.call('');
  }

  /// Builds the suffix icon that shows a clear button when appropriate.
  ///
  /// The clear button appears only when the field is focused AND contains text.
  /// Uses [ListenableBuilder] to reactively update based on controller and focus
  /// state changes.
  Widget _buildSuffixIcon() {
    return ListenableBuilder(
      listenable: Listenable.merge([_controller, _focusNode]),
      builder: (context, child) {
        final showClearButton =
            _focusNode.hasFocus && _controller.text.isNotEmpty;

        if (!showClearButton) {
          return const SizedBox.shrink();
        }

        return IconButton(
          icon: const Icon(AppIcons.clear),
          onPressed: _clearInput,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: Spacing.extraExtraSmall,
      children: [
        Text(widget.label, style: Theme.of(context).textTheme.bodyMedium),
        TextFormField(
          controller: _controller,
          focusNode: _focusNode,
          onChanged: widget.onChanged,
          decoration: InputDecoration(
            hintText: widget.hintText,
            prefixIcon: widget.leadingIcon != null
                ? Icon(widget.leadingIcon)
                : null,
            suffixIcon: _buildSuffixIcon(),
          ),
        ),
      ],
    );
  }
}
