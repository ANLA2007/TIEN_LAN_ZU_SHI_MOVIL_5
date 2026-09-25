import 'package:flutter/material.dart';
import '../Themes/app_colors.dart';

class StatusSwitch extends StatelessWidget {
  final bool value;
  final Function(bool) onChanged;
  final String label;
  const StatusSwitch({super.key, required this.value, required this.onChanged, this.label = 'Estado',});

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
          Text(label, style: const TextStyle(fontWeight: FontWeight.w600)),
          Switch(value: value, onChanged: onChanged, activeColor: Colors.white, activeTrackColor: AppColors.primary, inactiveThumbColor: Colors.white, inactiveTrackColor: AppColors.border,),
        ],
      ),
    );
  }
}