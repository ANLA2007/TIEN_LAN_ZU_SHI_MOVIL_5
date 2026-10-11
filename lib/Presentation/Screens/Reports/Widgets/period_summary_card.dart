import 'package:flutter/material.dart';
import 'package:flutter_buffet/Themes/app_colors.dart';

class ResumenDesplegable extends StatefulWidget {
  const ResumenDesplegable({super.key});

  @override
  State<ResumenDesplegable> createState() => _ResumenDesplegableState();
}

class _ResumenDesplegableState extends State<ResumenDesplegable> {
  bool expandido = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        children: [
          InkWell(
            onTap: () => setState(() => expandido = !expandido),
            child: Padding(
              padding: const EdgeInsets.all(14),
              child: Row(
                children: [
                  Container(
                    width: 36,
                    height: 36,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: AppColors.primary.withOpacity(0.12),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Icon(
                      Icons.calendar_month_outlined,
                      color: AppColors.primary,
                      size: 20,
                    ),
                  ),
                  const SizedBox(width: 8),
                  const Expanded(
                    child: Text(
                      'Resumen del período',
                      style: TextStyle(
                        color: AppColors.textTitle,
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  Text(
                    expandido ? 'Ocultar resumen' : 'Ver resumen',
                    style: const TextStyle(
                      color: AppColors.primary,
                      fontSize: 12.5,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  AnimatedRotation(
                    turns: expandido ? 0.5 : 0,
                    duration: const Duration(milliseconds: 200),
                    child: const Icon(
                      Icons.keyboard_arrow_down,
                      color: AppColors.primary,
                      size: 20,
                    ),
                  ),
                ],
              ),
            ),
          ),
          AnimatedCrossFade(
            duration: const Duration(milliseconds: 200),
            crossFadeState: expandido
                ? CrossFadeState.showSecond
                : CrossFadeState.showFirst,
            firstChild: const SizedBox(
              width: double.infinity,
              height: 0,
            ),
            secondChild: Padding(
              padding: const EdgeInsets.fromLTRB(14, 0, 14, 14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Divider(
                    height: 1,
                    color: AppColors.border,
                  ),
                  const SizedBox(height: 14),
                  const Row(
                    children: [
                      Expanded(
                        child: DatoResumen(
                          etiqueta: 'Subtotal',
                          monto: 'C\$ 2,035.00',
                        ),
                      ),
                      Expanded(
                        child: DatoResumen(
                          etiqueta: 'Descuentos',
                          monto: 'C\$ 0.00',
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 14),
                  const CajaTotal(
                    monto: 'C\$ 2,340.25',
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'Reporte generado el 25/05/2026 a las 11:45 a.m.',
                    style: TextStyle(
                      color: AppColors.textGrey,
                      fontSize: 11,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class DatoResumen extends StatelessWidget {
  final String etiqueta;
  final String monto;

  const DatoResumen({
    super.key,
    required this.etiqueta,
    required this.monto,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          etiqueta,
          style: const TextStyle(
            color: AppColors.textGrey,
            fontSize: 12.5,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          monto,
          style: const TextStyle(
            color: AppColors.primary,
            fontSize: 17,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }
}

class CajaTotal extends StatelessWidget {
  final String monto;

  const CajaTotal({
    super.key,
    required this.monto,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 14),
      decoration: BoxDecoration(
        color: AppColors.softBackground,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          const Text(
            'Total en ventas',
            style: TextStyle(
              color: AppColors.textTitle,
              fontSize: 12.5,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            monto,
            style: const TextStyle(
              color: AppColors.primary,
              fontSize: 22,
              fontWeight: FontWeight.w800,
            ),
          ),
        ],
      ),
    );
  }
}