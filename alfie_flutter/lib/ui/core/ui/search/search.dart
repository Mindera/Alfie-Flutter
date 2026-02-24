import 'package:alfie_flutter/ui/core/themes/app_icons.dart';
import 'package:alfie_flutter/ui/core/themes/colors.dart';
import 'package:alfie_flutter/ui/core/themes/spacing.dart';
import 'package:alfie_flutter/ui/core/ui/button/app_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class Search extends HookWidget {
  /// Placeholder text shown when the field is empty.
  final String hintText;

  /// Called whenever the input text changes.
  ///
  /// Receives the current text value.
  final ValueChanged<String>? onChanged;

  static const icon = AppIcons.search;

  const Search({super.key, this.hintText = 'Placeholder', this.onChanged});

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

    return TextFormField(
      scrollPadding: EdgeInsets.zero,
      controller: controller,
      focusNode: focusNode,
      onChanged: onChanged,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.zero,
        fillColor: focusNode.hasFocus
            ? AppColors.neutral
            : AppColors.neutral100,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(Spacing.extraExtraSmall),
          borderSide: BorderSide(color: AppColors.neutral100),
        ),
        hintText: hintText,
        prefixIcon: Icon(icon),
        suffixIcon: showClearButton
            ? AppButton.tertiary(onPressed: clearInput, leading: AppIcons.clear)
            : null,
      ),
    );
  }
}
