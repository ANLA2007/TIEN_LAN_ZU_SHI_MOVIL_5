import 'package:flutter/material.dart';

import '../../../Themes/app_colors.dart';
import '../../../app_routes.dart';

final List<Map<String, String>> _ventasRecientes = [
  {
    'fecha': '25 ago. 2026 - 12:32',
    'cliente': 'David Sanchez',
    'total': '\$18.50',
    'metodo': 'Efectivo',
    'estado': 'Completada',
  },
  {
    'fecha': '28 ago. 2026 - 11:45',
    'cliente': 'Carolina Reyes',
    'total': '\$24.00',
    'metodo': 'Tarjeta',
    'estado': 'Completada',
  },
  {
    'fecha': '10 sep. 2026 - 10:20',
    'cliente': 'Ana Torres',
    'total': '\$12.75',
    'metodo': 'Efectivo',
    'estado': 'Completada',
  },
  {
    'fecha': '15 sep. 2026 - 09:15',
    'cliente': 'Jose Tapia',
    'total': '\$30.50',
    'metodo': 'Tarjeta',
    'estado': 'Completada',
  },
];

class RecentSalesCard extends StatelessWidget {
  const RecentSalesCard({super.key});

  static const List<double> _colWidths = [128, 110, 68, 88, 96, 24];

  @override
  Widget build(BuildContext context) {
    final totalWidth = _colWidths.reduce((a, b) => a + b);

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.history, color: AppColors.primary, size: 20),
              const SizedBox(width: 8),
              const Expanded(
                child: Text(
                  'Últimas ventas',
                  style: TextStyle(
                    color: AppColors.textTitle,
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              InkWell(
                borderRadius: BorderRadius.circular(20),
                onTap: () => Navigator.of(context).pushNamed(AppRoutes.reportes),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  decoration: BoxDecoration(
                    color: AppColors.softBackground,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Ver historial completo',
                        style: TextStyle(
                          color: AppColors.primary,
                          fontSize: 11.5,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Icon(Icons.chevron_right, size: 16, color: AppColors.primary),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: SizedBox(
              width: totalWidth,
              child: Column(
                children: [
                  Row(
                    children: [
                      SizedBox(
                        width: _colWidths[0],
                        child: const Text(
                          'Fecha',
                          style: TextStyle(color: AppColors.textGrey, fontSize: 11.5, fontWeight: FontWeight.w600),
                        ),
                      ),
                      SizedBox(
                        width: _colWidths[1],
                        child: const Text(
                          'Cliente',
                          style: TextStyle(color: AppColors.textGrey, fontSize: 11.5, fontWeight: FontWeight.w600),
                        ),
                      ),
                      SizedBox(
                        width: _colWidths[2],
                        child: const Text(
                          'Total',
                          style: TextStyle(color: AppColors.textGrey, fontSize: 11.5, fontWeight: FontWeight.w600),
                        ),
                      ),
                      SizedBox(
                        width: _colWidths[3],
                        child: const Text(
                          'Método',
                          style: TextStyle(color: AppColors.textGrey, fontSize: 11.5, fontWeight: FontWeight.w600),
                        ),
                      ),
                      SizedBox(
                        width: _colWidths[4],
                        child: const Text(
                          'Estado',
                          style: TextStyle(color: AppColors.textGrey, fontSize: 11.5, fontWeight: FontWeight.w600),
                        ),
                      ),
                      SizedBox(width: _colWidths[5]),
                    ],
                  ),
                  const Divider(height: 18, color: AppColors.border),
                  ..._ventasRecientes.map((venta) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: _colWidths[0],
                            child: Text(
                              venta['fecha']!,
                              style: const TextStyle(color: AppColors.textTitle, fontSize: 12),
                            ),
                          ),
                          SizedBox(
                            width: _colWidths[1],
                            child: Row(
                              children: [
                                const Icon(Icons.person_outline, size: 14, color: AppColors.textGrey),
                                const SizedBox(width: 4),
                                Expanded(
                                  child: Text(
                                    venta['cliente']!,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(color: AppColors.textTitle, fontSize: 12),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: _colWidths[2],
                            child: Text(
                              venta['total']!,
                              style: const TextStyle(
                                color: AppColors.textTitle,
                                fontSize: 12,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: _colWidths[3],
                            child: Text(
                              venta['metodo']!,
                              style: const TextStyle(color: AppColors.textGrey, fontSize: 12),
                            ),
                          ),
                          SizedBox(
                            width: _colWidths[4],
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                              decoration: BoxDecoration(
                                color: AppColors.active.withOpacity(0.15),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Text(
                                venta['estado']!,
                                style: const TextStyle(
                                  color: AppColors.active,
                                  fontSize: 10.5,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: _colWidths[5],
                            child: const Icon(Icons.chevron_right, size: 16, color: AppColors.textGrey),
                          ),
                        ],
                      ),
                    );
                  }),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}