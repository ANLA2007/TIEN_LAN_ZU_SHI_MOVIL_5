import 'package:flutter/material.dart';
import '../Themes/app_colors.dart';

class StatusSwitch extends StatelessWidget {
  final bool value;
  final Function(bool) onChanged;
  const StatusSwitch({super.key, required this.value, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: AppColors.primary.withOpacity(0.06),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text('Estado', style: TextStyle(fontWeight: FontWeight.w600)),
          Switch(value: value, onChanged: onChanged, activeColor: AppColors.primary),
        ],
      ),
    );
  }
}