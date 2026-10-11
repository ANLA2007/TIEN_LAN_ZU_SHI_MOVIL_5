import 'package:flutter/material.dart';
import '../../../../../Themes/app_colors.dart';

class UserCard extends StatelessWidget {
  final String nombre, correo, rol, iniciales;
  final bool activo;
  final Color colorAvatar;
  final VoidCallback onTap, onDelete;

  const UserCard({
    super.key,
    required this.nombre,
    required this.correo,
    required this.rol,
    required this.iniciales,
    required this.activo,
    required this.onTap,
    required this.onDelete,
    this.colorAvatar = AppColors.primary,
  });

  static TextStyle estilo(
    Color color,
    double size,
    FontWeight weight, [
    double? height,
  ]) {
    return TextStyle(color: color, fontSize: size, fontWeight: weight, height: height);
  }

  static BoxDecoration caja(Color color, double radius, {Color? border}) {
    return BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(radius),
      border: border == null ? null : Border.all(color: border),
    );
  }

  @override
  Widget build(BuildContext context) {
    final statusColor = activo ? AppColors.active : AppColors.textGrey;

    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: caja(AppColors.cardBackground, 16, border: AppColors.border),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              radius: 26,
              backgroundColor: colorAvatar,
              child: Text(
                iniciales,
                style: estilo(Colors.white, 15, FontWeight.w700),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    nombre,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: estilo(AppColors.textTitle, 15.5, FontWeight.w700),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    correo,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: estilo(AppColors.textGrey, 12.5, FontWeight.w400),
                  ),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 8,
                    runSpacing: 6,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        decoration: caja(AppColors.primary.withOpacity(0.1), 20),
                        child: Text(rol, style: estilo(AppColors.primary, 11.5, FontWeight.w600)),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        decoration: caja(statusColor.withOpacity(0.15), 20),
                        child: Text(
                          activo ? 'Activo' : 'Inactivo',
                          style: estilo(statusColor, 11.5, FontWeight.w600),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            cardIcon(Icons.delete_outline, () => confirmarEliminar(context), AppColors.danger),
          ],
        ),
      ),
    );
  }

  Widget cardIcon(IconData icon, VoidCallback onTap, Color color) {
    return InkWell(
      borderRadius: BorderRadius.circular(8),
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(6),
        decoration: caja(color.withOpacity(0.1), 8),
        child: Icon(icon, size: 20, color: color),
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
          decoration: caja(fondo, 30, border: border),
          child: Text(texto, style: estilo(colorTexto, 14, FontWeight.w600)),
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
          decoration: caja(AppColors.cardBackground, 28),
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
                child: const Icon(Icons.delete_outline_rounded, color: AppColors.danger, size: 32),
              ),
              const SizedBox(height: 16),
              Text(
                '¿Eliminar usuario?',
                style: estilo(AppColors.primary, 17, FontWeight.w700),
              ),
              const SizedBox(height: 8),
              Text(
                '¿Deseas eliminar a "$nombre"? Esta acción no se puede deshacer.',
                textAlign: TextAlign.center,
                style: estilo(AppColors.textGrey, 13.5, FontWeight.w400, 1.4),
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