import 'package:alfie_flutter/ui/core/themes/app_button_theme.dart';
import 'package:alfie_flutter/ui/core/themes/spacing.dart';
import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  final String? label;
  final Widget? leading;
  final Widget? trailing;
  final VoidCallback? onPressed;
  final bool isLoading;
  final ButtonSize _size;
  final ButtonVariant _variant;

  const AppButton._({
    this.label,
    this.leading,
    this.trailing,
    this.onPressed,
    this.isLoading = false,
    required ButtonSize size,
    required ButtonVariant variant,
  }) : _size = size,
       _variant = variant;

  /// Factory for Primary
  factory AppButton.primary({
    String? label,
    Widget? leading,
    Widget? trailing,
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
    Widget? leading,
    Widget? trailing,
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
    Widget? leading,
    Widget? trailing,
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
    Widget? leading,
    Widget? trailing,
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
    final style = theme?.styleWith(variant: _variant, size: _size);
    return ElevatedButton(
      style: style,
      onPressed: (isLoading) ? null : onPressed,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        spacing: Spacing.xs,
        children: [
          isLoading
              ? SizedBox(
                  width: Spacing.m,
                  height: Spacing.m,
                  child: CircularProgressIndicator(strokeWidth: 1),
                )
              : leading!,

          // Label (always centered)
          if (label != null) Text(label!),

          if (trailing != null && !isLoading) trailing!,
        ],
      ),
    );
  }
}
