import 'package:flutter/material.dart';
import '../../../../Themes/app_colors.dart';


class DetalleVenta extends StatelessWidget {
  final Map<String, dynamic> venta;

  const DetalleVenta({
    super.key,
    required this.venta,
  });

  @override
  Widget build(BuildContext context) {
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
                    color: AppColors.primary.withOpacity(0.12),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(
                    Icons.receipt_long_outlined,
                    color: AppColors.primary,
                    size: 24,
                  ),
                ),
                const SizedBox(width: 12),
                Text(
                  venta['venta'] as String,
                  style: const TextStyle(
                    color: AppColors.textTitle,
                    fontWeight: FontWeight.w700,
                    fontSize: 18,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 18),
            FilaDetalle(
              etiqueta: 'Cliente',
              valor: venta['cliente'] as String,
            ),
            FilaDetalle(
              etiqueta: 'Platillo',
              valor: venta['concepto'] as String,
            ),
            FilaDetalle(
              etiqueta: 'Fecha',
              valor: venta['fecha'] as String,
            ),
            FilaDetalle(
              etiqueta: 'Subtotal',
              valor: venta['subtotal'] as String,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: Divider(
                height: 1,
                color: AppColors.border,
              ),
            ),
            Row(
              children: [
                const Text(
                  'Total de línea',
                  style: TextStyle(
                    color: AppColors.textTitle,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const Spacer(),
                Text(
                  venta['totalLinea'] as String,
                  style: const TextStyle(
                    color: AppColors.primary,
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 18),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                icon: const Icon(
                  Icons.print_outlined,
                  color: Colors.white,
                  size: 18,
                ),
                label: const Text(
                  'Imprimir comprobante',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
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

  const FilaDetalle({
    super.key,
    required this.etiqueta,
    required this.valor,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        children: [
          Text(
            etiqueta,
            style: const TextStyle(
              color: AppColors.textGrey,
              fontSize: 13,
            ),
          ),
          const Spacer(),
          Text(
            valor,
            style: const TextStyle(
              color: AppColors.textTitle,
              fontSize: 13,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}