import 'package:alfie_flutter/ui/core/themes/checkbox_theme.dart';
import 'package:alfie_flutter/ui/core/themes/spacing.dart';
import 'package:flutter/material.dart';

class CheckboxTile extends StatefulWidget {
  final String label;
  final String? info;
  final bool? value; // Initial value
  final bool hasError;
  final ValueChanged<bool?>? onChanged;

  const CheckboxTile({
    super.key,
    required this.label,
    this.info,
    this.value,
    this.onChanged,
    this.hasError = false,
  });

  @override
  State<CheckboxTile> createState() => _CheckboxTileState();
}

class _CheckboxTileState extends State<CheckboxTile> {
  late bool? _currentValue;

  @override
  void initState() {
    super.initState();
    // Initialize the internal state from the widget property
    _currentValue = widget.value;
  }

  void _handleToggle() {
    if (widget.hasError) return;
    bool? nextValue;
    if (_currentValue == false) {
      nextValue = true;
    } else {
      nextValue = false;
    }

    setState(() {
      _currentValue = nextValue;
    });

    widget.onChanged?.call(nextValue);
  }

  @override
  Widget build(BuildContext context) {
    final bool isDisabled = widget.onChanged == null;

    final labelStyle = Theme.of(
      context,
    ).checkboxTheme.getLabelStyle(context, isDisabled, _currentValue);

    final infoStyle = Theme.of(
      context,
    ).checkboxTheme.getInfoStyle(context, isDisabled);

    return InkWell(
      onTap: isDisabled ? null : _handleToggle,
      child: Container(
        color: Colors.transparent,
        padding: const EdgeInsets.symmetric(vertical: Spacing.extraExtraSmall),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Row(
                spacing: Spacing.extraSmall,
                children: [
                  Text(widget.label, style: labelStyle),
                  if (widget.info != null) Text(widget.info!, style: infoStyle),
                ],
              ),
            ),
            Checkbox(
              value: _currentValue,
              tristate: true,
              onChanged: isDisabled ? null : (_) => _handleToggle(),
              isError: widget.hasError,
            ),
          ],
        ),
      ),
    );
  }
}
