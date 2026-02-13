import 'package:alfie_flutter/ui/core/themes/app_button_theme.dart';
import 'package:alfie_flutter/ui/core/themes/app_icons.dart';
import 'package:alfie_flutter/ui/core/themes/spacing.dart';
import 'package:alfie_flutter/utils/build_context_extensions.dart';
import 'package:flutter/material.dart';

/// A customizable button widget supporting multiple variants, sizes, and states.
///
/// [AppButton] provides a unified button interface with support for:
/// - Multiple visual variants: primary, secondary, tertiary, and destructive
/// - Adjustable sizing through [ButtonSize]
/// - Optional leading/trailing icons with automatic icon-only layout detection
/// - Loading state with visual feedback
///
/// Use the factory constructors ([AppButton.primary], [AppButton.secondary], etc.)
/// to create buttons with specific styling. The button automatically disables
/// itself during loading states to prevent multiple actions.
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
       // Icon-only layout when label is absent and exactly one icon (leading XOR trailing) exists
       _isIconOnly = label == null && ((leading != null) ^ (trailing != null));

  /// Creates a primary [AppButton] with the standard button styling.
  ///
  /// It is intended to be used to move forward in a flow, acknowledge and dismiss,
  /// or finish a task. Main buttons can be paired with secondary buttons to maintain
  /// action hierarchy balance. There should be only one primary button on a screen.
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

  /// Creates a secondary [AppButton] with subtle styling.
  ///
  /// The secondary variant is light weight. It is the most common and many times
  /// combined with a primary button as a way to create action hierarchy.
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

  /// Creates a tertiary [AppButton] with minimal styling.
  ///
  /// Tertiary variant buttons are the most subtle type of buttons. They can
  /// be used for dismissive actions give users a way out of something,
  /// letting them cancel, do nothing, dismiss, or skip.
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

  /// Creates a destructive [AppButton] indicating a dangerous action.
  ///
  /// The destructive variant should represent actions that permanently cause data
  /// loss. Because these actions can not be undone, using button hierarchy is
  /// essential to reduce errors.
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
    final theme = context.theme.extension<AppButtonTheme>();
    final style = theme?.styleWith(
      variant: _variant,
      size: _size,
      isIconOnly: _isIconOnly,
    );

    return ElevatedButton(
      style: style,
      onPressed: isLoading ? null : onPressed,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        spacing: Spacing.extraSmall,
        children: _buildButtonContent(),
      ),
    );
  }

  /// Builds the button's content based on loading state and provided icons/label.
  ///
  /// Returns a list of widgets containing:
  /// - A progress indicator if loading
  /// - Leading icon if present and not loading
  /// - Label text if present
  /// - Trailing icon if present and not loading
  List<Widget> _buildButtonContent() {
    return [
      if (isLoading)
        AppIcons.progressIndicator
      else if (leading != null)
        Icon(leading!),
      if (label != null) Text(label!),
      if (trailing != null && !isLoading) Icon(trailing!),
    ];
  }
}
