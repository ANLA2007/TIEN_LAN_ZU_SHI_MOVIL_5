import 'package:flutter/material.dart';
import '../../../Themes/app_colors.dart';

class RoleStatsBar extends StatelessWidget {
  final int usuariosAsignados;
  final String fechaCreacion;
  final bool activo;

  const RoleStatsBar({
    super.key,
    required this.usuariosAsignados,
    required this.fechaCreacion,
    required this.activo,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        children: [
          columna(Icons.people_alt_outlined, 'Usuarios asignados', '$usuariosAsignados'),
          divisor(),
          columna(Icons.calendar_today_outlined, 'Fecha de creación', fechaCreacion),
          divisor(),
          columna(
            Icons.toggle_on_outlined,
            'Estado',
            activo ? 'Activo' : 'Inactivo',
            valueColor: activo ? AppColors.active : AppColors.textGrey,
          ),
        ],
      ),
    );
  }

  Widget divisor() => Container(width: 1, height: 46, color: AppColors.border);

  Widget columna(IconData icono, String label, String valor, {Color? valueColor}) {
    return Expanded(
      child: Column(
        children: [
          Icon(icono, color: AppColors.primary, size: 18),
          const SizedBox(height: 6),
          Text(label, textAlign: TextAlign.center, style: const TextStyle(fontSize: 10.5, color: AppColors.textGrey)),
          const SizedBox(height: 4),
          Text(
            valor,
            style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: valueColor ?? AppColors.textTitle),
          ),
        ],
      ),
    );
  }
}