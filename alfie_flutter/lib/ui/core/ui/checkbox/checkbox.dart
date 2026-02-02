import 'package:alfie_flutter/ui/core/themes/colors.dart';
import 'package:alfie_flutter/ui/core/themes/size_unit.dart';
import 'package:alfie_flutter/ui/core/themes/typography.dart';
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

    final textStyle =
        (_currentValue == true
                ? Theme.of(context).textTheme.bodyMediumBold
                : Theme.of(context).textTheme.bodyMedium)!
            .copyWith(
              color: isDisabled ? AppColors.neutral400 : AppColors.neutral800,
            );

    return InkWell(
      onTap: isDisabled ? null : _handleToggle,
      child: Container(
        color: Colors.transparent, // Ensures the whole row is tappable
        padding: const EdgeInsets.symmetric(vertical: SizeUnit.xxs),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Row(
                spacing: SizeUnit.xs,
                children: [
                  Text(widget.label, style: textStyle),
                  if (widget.info != null)
                    Text(
                      widget.info!,
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        color: isDisabled
                            ? AppColors.neutral400
                            : AppColors.neutral500,
                      ),
                    ),
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
