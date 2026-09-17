import 'package:flutter/material.dart';

import '../Themes/app_colors.dart';

class DateRangeFilter extends StatelessWidget {
  final String desde;
  final String hasta;
  final VoidCallback onDesdeTap;
  final VoidCallback onHastaTap;

  const DateRangeFilter({
    super.key,
    required this.desde,
    required this.hasta,
    required this.onDesdeTap,
    required this.onHastaTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: campoFecha('Desde', desde, onDesdeTap)),
        const SizedBox(width: 12),
        Expanded(child: campoFecha('Hasta', hasta, onHastaTap)),
      ],
    );
  }

  Widget campoFecha(String label, String valor, VoidCallback onTap) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style: const TextStyle(color: AppColors.primary,
             fontWeight: FontWeight.w600, fontSize: 12.5)),
             
        const SizedBox(height: 6),
        InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: onTap,
          child: Container(
            height: 44,
            padding: const EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              color: AppColors.cardBackground,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppColors.border),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(valor,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(fontSize: 13)),
                ),
                const Icon(Icons.calendar_today_outlined, size: 16, color: AppColors.textGrey),
              ],
            ),
          ),
        ),
      ],
    );
  }
}