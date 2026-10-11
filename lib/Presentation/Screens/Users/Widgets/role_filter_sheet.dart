import 'package:flutter/material.dart';
import '../../../../../Themes/app_colors.dart';

Future<String?> showRoleFilterSheet(
  BuildContext context, {
  required List<String> roles,
  required String? rolSeleccionado,
}) {
  return showModalBottomSheet<String?>(
    context: context,
    backgroundColor: Colors.transparent,
    builder: (context) {
      String? seleccion = rolSeleccionado;
      return StatefulBuilder(
        builder: (context, setModalState) {
          return Container(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 28),
            decoration: const BoxDecoration(
              color: AppColors.background,
              borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    width: 42,
                    height: 4,
                    decoration: BoxDecoration(
                      color: AppColors.border,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                ),
                const SizedBox(height: 18),
                const Text(
                  'Filtrar por rol',
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.w700, color: AppColors.primary),
                ),
                const SizedBox(height: 14),
                Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children: [
                    _chip(context, 'Todos los roles', seleccion == null, () {
                      setModalState(() => seleccion = null);
                    }),
                    ...roles.map(
                      (rol) => _chip(context, rol, seleccion == rol, () {
                        setModalState(() => seleccion = rol);
                      }),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () => Navigator.of(context).pop(seleccion),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                    ),
                    child: const Text('Aplicar filtro'),
                  ),
                ),
              ],
            ),
          );
        },
      );
    },
  );
}

Widget _chip(BuildContext context, String texto, bool activo, VoidCallback onTap) {
  return InkWell(
    borderRadius: BorderRadius.circular(20),
    onTap: onTap,
    child: Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: activo ? AppColors.primary : AppColors.cardBackground,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: activo ? AppColors.primary : AppColors.border),
      ),
      child: Text(
        texto,
        style: TextStyle(
          color: activo ? Colors.white : AppColors.textGrey,
          fontWeight: FontWeight.w600,
          fontSize: 13,
        ),
      ),
    ),
  );
}