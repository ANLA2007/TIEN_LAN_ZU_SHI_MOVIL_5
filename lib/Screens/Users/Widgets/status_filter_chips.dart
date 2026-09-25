import 'package:flutter/material.dart';
import '../../../../Themes/app_colors.dart';

class StatusFilterChips extends StatelessWidget {
  final String seleccionado;
  final ValueChanged<String> onChanged;
  final List<String> opciones;

  const StatusFilterChips({
    super.key,
    required this.seleccionado,
    required this.onChanged,
    this.opciones = const ['Todos', 'Activos', 'Inactivos'],
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: opciones.map((opcion) {
        final bool activo = opcion == seleccionado;
        return Padding(
          padding: const EdgeInsets.only(right: 10),
          child: InkWell(
            borderRadius: BorderRadius.circular(20),
            onTap: () => onChanged(opcion),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 9),
              decoration: BoxDecoration(
                color: activo ? AppColors.primary : AppColors.softBackground,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                opcion,
                style: TextStyle(
                  color: activo ? Colors.white : AppColors.textGrey,
                  fontWeight: FontWeight.w600,
                  fontSize: 13,
                ),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}