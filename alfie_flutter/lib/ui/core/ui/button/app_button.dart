import 'package:alfie_flutter/ui/core/themes/app_button_theme.dart';
import 'package:alfie_flutter/ui/core/themes/size_unit.dart';
import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  final String? label;
  final IconData? leading;
  final IconData? trailing;
  final VoidCallback? onPressed;
  final bool isLoading;
  final ButtonSize _size;
  final ButtonVariant _variant;
  final bool _isIconOnly;

  const AppButton._({
    this.label,
    this.leading,
    this.trailing,
    this.onPressed,
    this.isLoading = false,
    required ButtonSize size,
    required ButtonVariant variant,
  }) : _size = size,
       _variant = variant,
       _isIconOnly = label == null && ((leading != null) ^ (trailing != null));

  /// Factory for Primary
  factory AppButton.primary({
    String? label,
    IconData? leading,
    IconData? trailing,
    VoidCallback? onPressed,
    bool isLoading = false,
    ButtonSize size = ButtonSize.medium,
  }) {
    return AppButton._(
      label: label,
      leading: leading,
      trailing: trailing,
      onPressed: onPressed,
      isLoading: isLoading,
      size: size,
      variant: ButtonVariant.primary,
    );
  }

  /// Factory for Secundary
  factory AppButton.secondary({
    String? label,
    IconData? leading,
    IconData? trailing,
    VoidCallback? onPressed,
    bool isLoading = false,
    ButtonSize size = ButtonSize.medium,
  }) {
    return AppButton._(
      label: label,
      leading: leading,
      trailing: trailing,
      onPressed: onPressed,
      isLoading: isLoading,
      size: size,
      variant: ButtonVariant.secondary,
    );
  }

  /// Factory for Tertiary
  factory AppButton.tertiary({
    String? label,
    IconData? leading,
    IconData? trailing,
    VoidCallback? onPressed,
    bool isLoading = false,
    ButtonSize size = ButtonSize.medium,
  }) {
    return AppButton._(
      label: label,
      leading: leading,
      trailing: trailing,
      onPressed: onPressed,
      isLoading: isLoading,
      size: size,
      variant: ButtonVariant.tertiary,
    );
  }

  /// Factory for Tertiary
  factory AppButton.destructive({
    String? label,
    IconData? leading,
    IconData? trailing,
    VoidCallback? onPressed,
    bool isLoading = false,
    ButtonSize size = ButtonSize.medium,
  }) {
    return AppButton._(
      label: label,
      leading: leading,
      trailing: trailing,
      onPressed: onPressed,
      isLoading: isLoading,
      size: size,
      variant: ButtonVariant.destructive,
    );
  }

  @override
  Widget build(BuildContext context) {
    // Look up the style from the standard Flutter Theme
    final theme = Theme.of(context).extension<AppButtonTheme>();

    // Select the style based on the internal variant
    final style = theme?.styleWith(
      variant: _variant,
      size: _size,
      isIconOnly: _isIconOnly,
    );
    return ElevatedButton(
      style: style,
      onPressed: (isLoading) ? null : onPressed,
      child: Row(
        mainAxisSize: _isIconOnly ? MainAxisSize.min : MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        spacing: SizeUnit.xs,
        children: [
          if (isLoading)
            SizedBox(
              width: SizeUnit.m,
              height: SizeUnit.m,
              child: CircularProgressIndicator(strokeWidth: 1),
            )
          else if (leading != null)
            Icon(leading!, size: SizeUnit.m),

          // Label (always centered)
          if (label != null) Text(label!),

          if (trailing != null && !isLoading) Icon(trailing!, size: SizeUnit.m),
        ],
      ),
    );
  }
}
