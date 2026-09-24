import 'package:flutter/material.dart';

import '../../../Themes/app_colors.dart';

class ListItemCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String imageAsset;
  final bool isActive;
  final Color accentColor;
  final VoidCallback onTap;
  final VoidCallback? onView;
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
    this.onView,
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 62,
                  height: 62,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(color: accentColor, width: 2),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.asset(
                      imageAsset,
                      width: 62,
                      height: 62,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => Container(
                        width: 62,
                        height: 62,
                        color: accentColor.withOpacity(0.25),
                        alignment: Alignment.center,
                        child: Icon(Icons.image_outlined, color: accentColor, size: 30),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(title,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(color: Colors.black,
                           fontWeight: FontWeight.w700, fontSize: 16)),
                      Text(subtitle,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(color: AppColors.textGrey, fontSize: 12.5)),
                    ],
                  ),
                ),
              ],
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 8),
              child: Divider(height: 1, color: AppColors.border),
            ),
            Row(
              children: [
                const Text('Estado',
                    style: TextStyle(color: AppColors.primary,
                        fontWeight: FontWeight.w600, fontSize: 12.5)),
                const SizedBox(width: 8),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                  decoration: BoxDecoration(
                    color: statusColor.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(isActive ? 'Activa' : 'Inactiva',
                      style: TextStyle(color: statusColor, fontSize: 10.5,
                          fontWeight: FontWeight.w600)),
                ),
                const Spacer(),
                if (onView != null) cardIcon(Icons.visibility_outlined, onView!, AppColors.primary),
                cardIcon(Icons.edit_outlined, onEdit, AppColors.primary),
                cardIcon(Icons.delete_outline, () => confirmarEliminar(context), AppColors.danger),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget cardIcon(IconData icon, VoidCallback onTap, Color color) {
    return Padding(
      padding: const EdgeInsets.only(left: 8),
      child: InkWell(
        borderRadius: BorderRadius.circular(8),
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(color: color.withOpacity(0.1),
           borderRadius: BorderRadius.circular(8)),
          child: Icon(icon, size: 20, color: color),
        ),
      ),
    );
  }

  void confirmarEliminar(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) => Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: AppColors.cardBackground,
          borderRadius: BorderRadius.circular(28),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 64,
              height: 64,
              decoration: BoxDecoration(
                color: AppColors.danger.withOpacity(0.12),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.delete_outline_rounded,
                color: AppColors.danger,
                size: 32,
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              '¿Eliminar elemento?',
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 17,
                color: AppColors.primary,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              '¿Deseas eliminar "$title"? Esta acción no se puede deshacer.',
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: AppColors.textGrey,
                fontSize: 13.5,
                height: 1.4,
              ),
            ),
            const SizedBox(height: 22),
            Row(
              children: [
                Expanded(
                  child: InkWell(
                    borderRadius: BorderRadius.circular(30),
                    onTap: () => Navigator.of(context).pop(),
                    child: Container(
                      height: 46,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: AppColors.background,
                        borderRadius: BorderRadius.circular(30),
                        border: Border.all(color: AppColors.border),
                      ),
                      child: const Text(
                        'Cancelar',
                        style: TextStyle(
                          color: AppColors.primary,
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: InkWell(
                    borderRadius: BorderRadius.circular(30),
                    onTap: () {
                      Navigator.of(context).pop();
                      onDelete();
                    },
                    child: Container(
                      height: 46,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: AppColors.danger,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: const Text(
                        'Eliminar',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    ),
  );
}
}