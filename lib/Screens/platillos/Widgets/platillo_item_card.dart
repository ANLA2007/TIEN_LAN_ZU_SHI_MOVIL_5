import 'package:flutter/material.dart';

import '../../../Themes/app_colors.dart';

class PlatilloItemCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String imageAsset;
  final double price;
  final bool available;
  final VoidCallback onTap;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const PlatilloItemCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.imageAsset,
    required this.price,
    required this.onTap,
    required this.onEdit,
    required this.onDelete,
    this.available = true,
  });

  @override
  Widget build(BuildContext context) {
    final Color statusColor = available ? AppColors.active : AppColors.inactive;

    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: AppColors.cardBackground,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.border),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
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
                  child: const Icon(Icons.image_outlined,
                      color: AppColors.textGrey, size: 30),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          title,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            color: AppColors.textTitle,
                            fontWeight: FontWeight.w700,
                            fontSize: 16,
                          ),
                        ),
                      ),
                      const Icon(Icons.chevron_right,
                          color: AppColors.textGrey, size: 20),
                    ],
                  ),
                  const SizedBox(height: 2),
                  Text(
                    subtitle,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                        color: AppColors.textGrey, fontSize: 12.5),
                  ),
                  const SizedBox(height: 6),
                  const Divider(height: 1, color: AppColors.border),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      Text(
                        'C\$ ${price.toStringAsFixed(2)}',
                        style: const TextStyle(
                          color: AppColors.textTitle,
                          fontWeight: FontWeight.w700,
                          fontSize: 13.5,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 3),
                        decoration: BoxDecoration(
                          color: statusColor.withOpacity(0.15),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          available ? 'Activo' : 'Inactivo',
                          style: TextStyle(
                            color: statusColor,
                            fontSize: 10.5,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      const Spacer(),
                      cardIcon(Icons.edit_outlined, onEdit , AppColors.primary),
                      cardIcon(Icons.delete_outline, onDelete, AppColors.danger),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
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
          child: Icon(icon, size: 18, color: color),
        ),
      ),
    ),
    );
  }
}