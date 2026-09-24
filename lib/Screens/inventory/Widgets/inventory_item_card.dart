import 'package:flutter/material.dart';

import '../../../Themes/app_colors.dart';

class InventoryItemCard extends StatelessWidget {
  final String title;
  final int stock;
  final int stockDiario;
  final String imageAsset;
  final bool reconsumible;
  final bool stockBajo;
  final ValueChanged<bool> onReconsumibleChanged;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const InventoryItemCard({
    super.key,
    required this.title,
    required this.stock,
    required this.stockDiario,
    required this.imageAsset,
    required this.reconsumible,
    required this.onReconsumibleChanged,
    required this.onEdit,
    required this.onDelete,
    this.stockBajo = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border),
        boxShadow: const [
          BoxShadow(
            color: AppColors.shadow,
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.asset(
                  imageAsset,
                  width: 62,
                  height: 62,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Container(
                    width: 62,
                    height: 62,
                    color: AppColors.softBackground,
                    alignment: Alignment.center,
                    child: const Icon(
                      Icons.image_outlined,
                      color: AppColors.textGrey,
                      size: 30,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: AppColors.textTitle,
                        fontWeight: FontWeight.w700,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text.rich(
                      TextSpan(
                        text: 'Stock: ',
                        style: const TextStyle(
                          color: AppColors.textTitle,
                          fontSize: 13.5,
                        ),
                        children: [
                          TextSpan(
                            text: '$stock',
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              color: stockBajo
                                  ? AppColors.danger
                                  : AppColors.textTitle,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      'Stock diario acumulado: $stockDiario',
                      style: const TextStyle(
                        color: AppColors.textGrey,
                        fontSize: 12.5,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          const Divider(height: 1, color: AppColors.border),
          Row(
            children: [
              const Text(
                'Reconsumible',
                style: TextStyle(
                  color: AppColors.textTitle,
                  fontWeight: FontWeight.w600,
                  fontSize: 12.5,
                ),
              ),
              const SizedBox(width: 4),
              Transform.scale(
                scale: 0.75,
                child: Switch(
                  value: reconsumible,
                  onChanged: onReconsumibleChanged,
                  activeColor: Colors.white,
                  activeTrackColor: AppColors.primary,
                  inactiveThumbColor: Colors.white,
                  inactiveTrackColor: AppColors.border,
                ),
              ),
              const Spacer(),
              cardIcon(Icons.edit_outlined, onEdit, AppColors.primary),
              cardIcon(Icons.delete_outline, onDelete, AppColors.danger),
            ],
          ),
        ],
      ),
    );
  }

  Widget cardIcon(IconData icon, VoidCallback onTap, Color color) {
    return Padding(
      padding: const EdgeInsets.only(left: 6),
      child: InkWell(
      borderRadius: BorderRadius.circular(8),
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.only(left: 6),
        child: Container(
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
        child: Icon(icon, size: 20, color: color),
        ),
      ),
      ),
      );
  }
}