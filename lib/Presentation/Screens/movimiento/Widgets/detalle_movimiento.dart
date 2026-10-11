import 'package:flutter/material.dart';
import 'package:flutter_buffet/Themes/app_colors.dart';

class DetalleMovimiento extends StatelessWidget {
  final Map<String, dynamic> movimiento;
  final IconData icon;
  final Color color;

  const DetalleMovimiento({
    super.key,
    required this.movimiento,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    final int cantidad = movimiento['cantidad'] as int;
    final String cantidadTexto =
        cantidad > 0 ? '+$cantidad pz' : '$cantidad pz';
    final String? nota = movimiento['nota'] as String?;

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 12, 20, 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 40,
                height: 4,
                margin: const EdgeInsets.only(bottom: 16),
                decoration: BoxDecoration(
                  color: AppColors.border,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ),
            Row(
              children: [
                Container(
                  width: 48,
                  height: 48,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.12),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(icon, color: color, size: 24),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    movimiento['titulo'] as String,
                    style: const TextStyle(
                      color: AppColors.textTitle,
                      fontWeight: FontWeight.w700,
                      fontSize: 18,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 18),
            FilaDetalle(
              etiqueta: 'Tipo de Movimiento',
              valor: movimiento['tipo'] as String,
              valorColor: color,
            ),
            FilaDetalle(
              etiqueta: 'Cantidad',
              valor: cantidadTexto,
              valorColor: color,
            ),
            FilaDetalle(
              etiqueta: 'Justificacion',
              valor: (nota == null || nota.isEmpty) ? 'Sin justificación' : nota,
            ),
            FilaDetalle(
              etiqueta: 'Fecha',
              valor: '${movimiento['fecha']} • ${movimiento['hora']}',
            ),
          ],
        ),
      ),
    );
  }
}

class FilaDetalle extends StatelessWidget {
  final String etiqueta;
  final String valor;
  final Color? valorColor;

  const FilaDetalle({
    super.key,
    required this.etiqueta,
    required this.valor,
    this.valorColor,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 1,
            child: Text(
              etiqueta,
              style: const TextStyle(color: AppColors.textGrey, fontSize: 13),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            flex: 2,
            child: Text(
              valor,
              textAlign: TextAlign.right,
              style: TextStyle(
                color: valorColor ?? AppColors.textTitle,
                fontSize: 13,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}