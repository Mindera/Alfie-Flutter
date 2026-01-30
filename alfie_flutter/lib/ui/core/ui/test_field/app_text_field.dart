import 'package:alfie_flutter/ui/core/themes/app_icons.dart';
import 'package:flutter/material.dart';

class AppInputField extends StatefulWidget {
  final String hintText;
  final IconData? leadingIcon;
  final ValueChanged<String>? onChanged;

  const AppInputField({
    super.key,
    this.hintText = 'Placeholder',
    this.leadingIcon,
    this.onChanged,
  });

  @override
  State<AppInputField> createState() => _AppInputFieldState();
}

class _AppInputFieldState extends State<AppInputField> {
  final TextEditingController _controller = TextEditingController();

  // 1. Add a FocusNode to track if the user is selecting this field
  final FocusNode _focusNode = FocusNode();

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose(); // Don't forget to dispose the FocusNode!
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _controller,
      focusNode: _focusNode, // 2. Attach the FocusNode
      onChanged: widget.onChanged,
      decoration: InputDecoration(
        hintText: widget.hintText,
        prefixIcon: widget.leadingIcon != null
            ? Icon(widget.leadingIcon)
            : null,

        // 3. ListenableBuilder listens to BOTH controller (text) and focusNode (focus)
        suffixIcon: ListenableBuilder(
          listenable: Listenable.merge([_controller, _focusNode]),
          builder: (context, child) {
            // Logic: Show only if focused AND has text
            final bool showIcon =
                _focusNode.hasFocus && _controller.text.isNotEmpty;

            if (!showIcon) {
              return const SizedBox.shrink();
            }

            return IconButton(
              icon: const Icon(AppIcons.clear),
              onPressed: () {
                _controller.clear();
                widget.onChanged?.call('');
              },
            );
          },
        ),
      ),
    );
  }
}
