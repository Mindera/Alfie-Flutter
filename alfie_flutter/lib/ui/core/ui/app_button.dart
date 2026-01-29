import 'package:alfie_flutter/ui/core/themes/app_button_theme.dart';
import 'package:alfie_flutter/ui/core/themes/app_spacing.dart';
import 'package:flutter/material.dart';

enum ButtonVariant { primary, secondary, tertiary, destructive }

enum ButtonSize { medium, small }

class AppButton extends StatelessWidget {
  final String? label;
  final Widget? leading;
  final Widget? trailing;
  final VoidCallback? onPressed;
  final bool isLoading;
  final ButtonSize size;
  final ButtonVariant _variant;

  const AppButton._({
    this.label,
    this.leading,
    this.trailing,
    this.onPressed,
    this.isLoading = false,
    required this.size,
    required ButtonVariant variant,
  }) : _variant = variant;

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
    final style = switch (_variant) {
      ButtonVariant.primary => theme?.primary,
      ButtonVariant.secondary => theme?.secondary,
      ButtonVariant.tertiary => theme?.tertiary,
      ButtonVariant.destructive => theme?.destructive,
    };
    return ElevatedButton(
      style: style,
      onPressed: (isLoading || onPressed == null) ? null : onPressed,
      child: _ButtonContent(
        label: label,
        leading: leading,
        trailing: trailing,
        isLoading: isLoading,
      ),
    );
  }
}

class _ButtonContent extends StatelessWidget {
  final String? label;
  final Widget? leading;
  final Widget? trailing;
  final bool isLoading;

  const _ButtonContent({
    this.label,
    this.leading,
    this.trailing,
    required this.isLoading,
  });

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const SizedBox(
        height: AppSpacing.s,
        width: AppSpacing.s,
        child: CircularProgressIndicator(strokeWidth: 2),
      );
    }

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (leading != null) ...[leading!, const SizedBox(width: 8)],
        if (label != null) Text(label!),
        if (trailing != null) ...[const SizedBox(width: 8), trailing!],
      ],
    );
  }
}
