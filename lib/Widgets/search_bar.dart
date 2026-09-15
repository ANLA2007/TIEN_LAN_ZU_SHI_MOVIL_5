import 'package:flutter/material.dart';

import '../Themes/app_colors.dart';

class AppSearchBar extends StatelessWidget {
  final String hintText;
  final String actionLabel;
  final VoidCallback onPressed;

  const AppSearchBar({
    super.key,
    this.hintText = 'Buscar...',
    required this.actionLabel,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            height: 46,
            decoration: BoxDecoration(
              color: AppColors.cardBackground,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: AppColors.border),
            ),
            child: TextField(
              decoration: InputDecoration(
                isDense: true,
                hintText: hintText,
                hintStyle: const TextStyle(color: AppColors.textGrey, fontSize: 14),
                prefixIcon: const Icon(Icons.search, color: AppColors.primary, size: 20),
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(vertical: 12),
              ),
            ),
          ),
        ),
        const SizedBox(width: 10),
        InkWell(
          borderRadius: BorderRadius.circular(14),
          onTap: onPressed,
          child: Container(
            height: 46,
            padding: const EdgeInsets.symmetric(horizontal: 14),
            alignment: Alignment.center,
            decoration: BoxDecoration(color: AppColors.primary, borderRadius: BorderRadius.circular(14)),
            child: Row(mainAxisSize: MainAxisSize.min, children: [
              const Icon(Icons.add, color: Colors.white, size: 20),
              const SizedBox(width: 6),
              Text(actionLabel, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 13)),
            ]),
          ),
        ),
      ],
    );
  }
}