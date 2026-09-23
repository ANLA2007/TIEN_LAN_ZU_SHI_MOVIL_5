import 'package:flutter/material.dart';

import '../Themes/app_colors.dart';

class PlatilloItemCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String imageAsset;
  final double price;
  final bool available;
  final VoidCallback onTap;
  final VoidCallback onView;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const PlatilloItemCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.imageAsset,
    required this.price,
    required this.onTap,
    required this.onView,
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
                  const SizedBox(height: 8),
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
                        width: 6,
                        height: 6,
                        decoration:
                            BoxDecoration(color: statusColor, shape: BoxShape.circle),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        available ? 'Disponible' : 'No disponible',
                        style: TextStyle(
                          color: statusColor,
                          fontWeight: FontWeight.w600,
                          fontSize: 12,
                        ),
                      ),
                      const Spacer(),
                      cardIcon(Icons.visibility_outlined, onView),
                      cardIcon(Icons.edit_outlined, onEdit),
                      cardIcon(Icons.delete_outline, onDelete),
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

  Widget cardIcon(IconData icon, VoidCallback onTap) {
    return InkWell(
      borderRadius: BorderRadius.circular(8),
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.only(left: 6),
        child: Icon(icon, size: 19, color: AppColors.textGrey),
      ),
    );
  }
}