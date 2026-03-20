import 'package:alfie_flutter/ui/core/themes/spacing.dart';
import 'package:flutter/material.dart';

class AccountMenuItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback? onTap;

  const AccountMenuItem({
    super.key,
    required this.icon,
    required this.label,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Row(
          spacing: Spacing.extraSmall,
          children: [Icon(icon), Text(label)],
        ),
      ),
    );
  }
}
