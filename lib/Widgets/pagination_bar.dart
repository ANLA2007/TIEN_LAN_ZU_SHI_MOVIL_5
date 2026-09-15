import 'package:flutter/material.dart';

import '../Themes/app_colors.dart';

class PaginationBar extends StatelessWidget {
  final int currentPage;
  final int totalPages;
  final String infoText;

  const PaginationBar({
    super.key,
    this.currentPage = 1,
    this.totalPages = 3,
    this.infoText = 'Mostrando 1-10 de 30',
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: const BoxDecoration(color: AppColors.background, 
      border: Border(top: BorderSide(color: AppColors.border))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(infoText, style: const TextStyle(color: AppColors.textGrey, fontSize: 12)),
          Row(
            children: [
              IconButton(
                icon: const Icon(Icons.chevron_left, color: AppColors.primary),
                onPressed: () {},
              ),
              Text(
                'Pagina $currentPage de $totalPages',
                style: const TextStyle(color: AppColors.textGrey, 
                fontSize: 13,
                 fontWeight: FontWeight.w600),
              ),
              IconButton(
                icon: const Icon(Icons.chevron_right, color: AppColors.primary),
                onPressed: () {},
              ),
            ],
          ),
        ],
      ),
    );
  }
}