import 'package:alfie_flutter/ui/core/themes/app_icons.dart';
import 'package:alfie_flutter/ui/core/themes/spacing.dart';
import 'package:flutter/material.dart';

class AppInputField extends StatefulWidget {
  final String hintText;
  final String label;
  final IconData? leadingIcon;
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
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: Spacing.extraExtraSmall,
      children: [
        Text(widget.label, style: TextTheme.of(context).bodyMedium),
        TextFormField(
          controller: _controller,
          focusNode: _focusNode,
          onChanged: widget.onChanged,

          decoration: InputDecoration(
            hintText: widget.hintText,
            prefixIcon: widget.leadingIcon != null
                ? Icon(widget.leadingIcon)
                : null,

            suffixIcon: ListenableBuilder(
              listenable: Listenable.merge([_controller, _focusNode]),
              builder: (context, child) {
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
        ),
      ],
    );
  }
}
