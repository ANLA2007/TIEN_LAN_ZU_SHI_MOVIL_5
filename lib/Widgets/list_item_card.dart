import 'package:flutter/material.dart';

import '../Themes/app_colors.dart';

class ListItemCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String imageAsset;
  final bool isActive;
  final Color accentColor;
  final VoidCallback onTap;
  final VoidCallback onView;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const ListItemCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.imageAsset,
    required this.isActive,
    required this.accentColor,
    required this.onTap,
    required this.onView,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final Color statusColor = isActive ? AppColors.active : AppColors.inactive;

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
                width: 56,
                height: 56,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(title,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(color: AppColors.primary,
                             fontWeight: FontWeight.w700, fontSize: 16)),

                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                        decoration: BoxDecoration(color: statusColor.withOpacity(0.15),
                        borderRadius: BorderRadius.circular(20)),
                        
                        child: Text(isActive ? 'Activa' : 'Inactiva',
                            style: TextStyle(color: statusColor, fontSize: 10.5, 
                            fontWeight: FontWeight.w600)),
                      ),
                    ],
                  ),
                  Text(subtitle,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(color: AppColors.textGrey, fontSize: 12.5)),
                  Row(children: [
                    cardIcon(Icons.visibility_outlined, onView, AppColors.primary),
                    cardIcon(Icons.edit_outlined, onEdit, AppColors.primary),
                    cardIcon(Icons.delete_outline, onDelete, AppColors.danger),
                  ]),
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
      padding: const EdgeInsets.only(top: 6, right: 8),
      child: InkWell(
        borderRadius: BorderRadius.circular(8),
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(color: color.withOpacity(0.1), borderRadius: BorderRadius.circular(8)),
          child: Icon(icon, size: 16, color: color),
        ),
      ),
    );
  }
}