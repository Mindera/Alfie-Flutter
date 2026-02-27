import 'package:alfie_flutter/ui/core/themes/app_icons.dart';
import 'package:alfie_flutter/ui/core/themes/colors.dart';
import 'package:alfie_flutter/ui/core/themes/spacing.dart';
import 'package:alfie_flutter/ui/core/ui/button/app_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

/// A search input field.
class Search extends HookWidget {
  /// Placeholder text shown when the field is empty.
  final String hintText;

  /// Called whenever the input text changes.
  ///
  /// Receives the current text value.
  final ValueChanged<String>? onChanged;
  final bool autofocus;

  static const icon = AppIcons.search;

  const Search({
    super.key,
    this.hintText = 'What are you looking for?',
    this.onChanged,
    this.autofocus = false,
  });

  @override
  Widget build(BuildContext context) {
    final TextEditingController controller = useTextEditingController();
    final FocusNode focusNode = useFocusNode();

    // Rebuild the widget when focus changes or text is typed to toggle the clear button.
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
      autofocus: autofocus,
      decoration: InputDecoration(
        hintText: hintText,
        prefixIcon: const Icon(icon),
        suffixIcon: showClearButton
            ? AppButton.tertiary(onPressed: clearInput, leading: AppIcons.clear)
            : null,
      ),
    );
  }
}

/// A search input field placeholder button.
class SearchDummy extends StatelessWidget {
  final String hintText;
  final VoidCallback onTap;

  static const icon = AppIcons.search;

  const SearchDummy({
    super.key,
    this.hintText = 'What are you looking for?',
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onTap: onTap,
      readOnly: true,
      decoration: InputDecoration(
        hintText: hintText,
        prefixIcon: const Icon(icon),
        fillColor: AppColors.neutral100,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(Spacing.extraExtraSmall),
          borderSide: BorderSide(color: AppColors.neutral100),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(Spacing.extraExtraSmall),
          borderSide: BorderSide(color: AppColors.neutral100),
        ),
      ),
    );
  }
}
