import 'package:flutter/material.dart';
import '../../../Themes/app_colors.dart';

class DetallePlatillo extends StatelessWidget {
  final Map<String, dynamic> platillo;

  const DetallePlatillo({super.key, required this.platillo});

  @override
  Widget build(BuildContext context) {
    final bool available = platillo['disponible'] as bool;
    final bool reconsumible = platillo['reconsumible'] as bool? ?? false;
    final double price = platillo['precio'] as double;

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
                    Icons.restaurant_menu_outlined,
                    color: AppColors.primary,
                    size: 24,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    platillo['nombre'] as String,
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
              etiqueta: 'Descripcion',
              valor: platillo['descripcion'] as String,
            ),
            FilaDetalle(
              etiqueta: 'Precio',
              valor: 'C\$ ${price.toStringAsFixed(2)}',
            ),
            FilaDetalle(
              etiqueta: 'Estado',
              valor: available ? 'Activo' : 'Inactivo',
              valorColor: available ? AppColors.active : AppColors.inactive,
            ),
            FilaDetalle(
              etiqueta: 'Reconsumible',
              valor: reconsumible ? 'Reconsumible' : 'No reconsumible',
              valorColor: reconsumible ? AppColors.active : AppColors.textGrey,
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
          Expanded (
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