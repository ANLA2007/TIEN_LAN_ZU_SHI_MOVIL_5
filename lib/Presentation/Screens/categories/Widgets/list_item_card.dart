import 'package:flutter/material.dart';
import 'package:flutter_buffet/Themes/app_colors.dart';

class ListItemCard extends StatelessWidget {
  final String title, subtitle, imageAsset;
  final bool isActive;
  final Color accentColor;
  final VoidCallback onTap, onEdit, onDelete;
  final VoidCallback? onView;
  final bool canEdit;
 final bool canDelete;

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
    this.canEdit = true,   // <-- nueva
   this.canDelete = true, // <-- nueva
  });

  static TextStyle estilo(
    Color color,
    double size,
    FontWeight weight, [
    double? height,
  ]) {
    return TextStyle(
      color: color,
      fontSize: size,
      fontWeight: weight,
      height: height,
    );
  }

  static BoxDecoration caja(
    Color color,
    double radius, {
    Color? border,
  }) {
    return BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(radius),
      border: border == null ? null : Border.all(color: border),
    );
  }

  @override
  Widget build(BuildContext context) {
    final statusColor =
        isActive ? AppColors.active : AppColors.inactive;

    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: caja(
          AppColors.cardBackground,16,border: AppColors.border,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(14),
                  child: Image.asset(
                    imageAsset,
                    width: 62,height: 62,fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Container(
                      width: 62,height: 62,
                      alignment: Alignment.center,
                      color: accentColor.withOpacity(0.25),
                      child: Icon(
                        Icons.image_outlined,color: accentColor,size: 30,
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
                      Text(
                        title,
                        maxLines: 1,overflow: TextOverflow.ellipsis,
                        style: estilo( Colors.black,16,FontWeight.w700,)),
                      Text(
                        subtitle,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: estilo(
                          AppColors.textGrey,12.5,FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const Divider(
              height: 17,
              color: AppColors.border,
            ),
            Row(
              children: [
                Text(
                  'Estado',
                  style: estilo(
                    AppColors.primary,12.5,FontWeight.w600,
                  ),
                ),
                const SizedBox(width: 8),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,vertical: 3,
                  ),
                  decoration: caja(
                    statusColor.withOpacity(0.15),20,
                  ),
                  child: Text(
                    isActive ? 'Activa' : 'Inactiva',
                    style: estilo(
                      statusColor,10.5,FontWeight.w600,
                    ),
                  ),
                ),
                const Spacer(),
                
                  if (onView != null)
                  cardIcon(Icons.visibility_outlined, onView!, AppColors.primary),
                  if (canEdit)
                  cardIcon(Icons.edit_outlined, onEdit, AppColors.primary),
                  if (canDelete)
                  cardIcon(Icons.delete_outline, () => confirmarEliminar(context), AppColors.danger),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget cardIcon(
    IconData icon,
    VoidCallback onTap,
    Color color,
  ) {
    return Padding(
      padding: const EdgeInsets.only(left: 8),
      child: InkWell(
        borderRadius: BorderRadius.circular(8),
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(6),
          decoration: caja(
            color.withOpacity(0.1),
            8,
          ),
          child: Icon(
            icon,size: 20,color: color,
          ),
        ),
      ),
    );
  }

  Widget botonDialogo(
    String texto,
    VoidCallback onTap,
    Color fondo,
    Color colorTexto, {
    Color? border,
  }) {
    return Expanded(
      child: InkWell(
        borderRadius: BorderRadius.circular(30),
        onTap: onTap,
        child: Container(
          height: 46,
          alignment: Alignment.center,
          decoration: caja(
            fondo,30,border: border,
          ),
          child: Text(
            texto,
            style: estilo(
              colorTexto,14,FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }

  void confirmarEliminar(BuildContext context) {
    showDialog(
      context: context,
      builder: (dialogContext) => Dialog(
        backgroundColor: Colors.transparent,
        child: Container(
          padding: const EdgeInsets.all(24),
          decoration: caja(
            AppColors.cardBackground,
            28,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 64,height: 64,
                decoration: BoxDecoration(
                  color: AppColors.danger.withOpacity(0.12),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.delete_outline_rounded,
                  color: AppColors.danger,size: 32,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                '¿Eliminar elemento?',
                style: estilo(
                  AppColors.primary,17,FontWeight.w700,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                '¿Deseas eliminar "$title"? Esta acción no se puede deshacer.',
                textAlign: TextAlign.center,
                style: estilo(
                  AppColors.textGrey,13.5,FontWeight.w400,1.4,
                ),
              ),
              const SizedBox(height: 22),
              Row(
                children: [
                  botonDialogo(
                    'Cancelar',
                    () => Navigator.of(dialogContext).pop(),
                    AppColors.background,
                    AppColors.primary,
                    border: AppColors.border,
                  ),
                  const SizedBox(width: 12),
                  botonDialogo(
                    'Eliminar',
                    () {
                      Navigator.of(dialogContext).pop();
                      onDelete();
                    },
                    AppColors.danger,
                  Colors.white,
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