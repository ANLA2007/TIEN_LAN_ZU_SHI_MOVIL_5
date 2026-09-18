import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../Themes/app_colors.dart';
import '../../Widgets/navigation_bar.dart';
import '../../Widgets/app_top_bar.dart';
import '../../Widgets/app_drawer.dart';

final List<Map<String, String>> _ventasRecientes = [
  {
    'fecha': '1 sep. 2026 - 12:32',
    'cliente': 'María López',
    'total': '\$18.50',
    'metodo': 'Efectivo',
    'estado': 'Completada',
  },
  {
    'fecha': '8 ago. 2026 - 11:45',
    'cliente': 'Carlos Pérez',
    'total': '\$24.00',
    'metodo': 'Tarjeta',
    'estado': 'Completada',
  },
  {
    'fecha': '12 ago. 2026 - 10:20',
    'cliente': 'Ana Torres',
    'total': '\$12.75',
    'metodo': 'Efectivo',
    'estado': 'Completada',
  },
  {
    'fecha': '20 ago. 2026 - 09:15',
    'cliente': 'Luis Martínez',
    'total': '\$30.50',
    'metodo': 'Tarjeta',
    'estado': 'Completada',
  },
];

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      drawer: const AppDrawer(),
      appBar: const AppTopBar(title: 'Tien Lan Zhu Shi'),
      body: SafeArea(
        bottom: false,
        child: ListView(
          padding: const EdgeInsets.fromLTRB(16, 14, 16, 20),
          children: [
            IntrinsicHeight(child: 
            Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: _StatCard(
                    icon: Icons.storage,
                    iconBg: AppColors.primary.withOpacity(0.12),
                    iconColor: AppColors.primary,
                    label: 'Ventas del día',
                    value: '\$2,850.00',
                    trendText: '+12%',
                    trendLabel: 'vs. ayer',
                    sparklineColor: AppColors.primaryLight,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _StatCard(
                    icon: Icons.restaurant,
                    iconBg: AppColors.accentGreen.withOpacity(0.12),
                    iconColor: AppColors.accentGreen,
                    label: 'Platillos vendidos',
                    value: '128',
                    trendText: '+8%',
                    trendLabel: 'vs. ayer',
                    sparklineColor: AppColors.accentGreen,
                  ),
                ),
              ],
            )),
            const SizedBox(height: 12),
            IntrinsicHeight(child: 
            Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: _StatCard(
                    icon: Icons.shopping_bag_outlined,
                    iconBg: AppColors.accentYellow.withOpacity(0.15),
                    iconColor: AppColors.accentYellow,
                    label: 'Promedio de ventas\npor compra',
                    value: '\$96.00',
                    trendText: '+5%',
                    trendLabel: 'vs. ayer',
                    sparklineColor: AppColors.accentYellow,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _StatCard(
                    icon: Icons.inventory_2_outlined,
                    iconBg: AppColors.primary.withOpacity(0.12),
                    iconColor: AppColors.primary,
                    label: 'Porciones en inventario',
                    value: '56',
                    footer: Row(
                      children: [
                        const Icon(Icons.info, size: 14, color: AppColors.inactive),
                        const SizedBox(width: 4),
                        Expanded(
                          child: Text(
                            '2 productos en stock bajo',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              color: AppColors.inactive,
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            )),
            const SizedBox(height: 16),
            const _SalesByCategoryCard(),
            const SizedBox(height: 16),
            const _RecentSalesCard(),
          ],
        ),
      ),
      bottomNavigationBar: const AppNavigatorBar(currentIndex: 0),
    );
  }
}

class _StatCard extends StatelessWidget {
  final IconData icon;
  final Color iconBg;
  final Color iconColor;
  final String label;
  final String value;
  final String? trendText;
  final String? trendLabel;
  final Color? sparklineColor;
  final Widget? footer;

  const _StatCard({
    required this.icon,
    required this.iconBg,
    required this.iconColor,
    required this.label,
    required this.value,
    this.trendText,
    this.trendLabel,
    this.sparklineColor,
    this.footer,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(color: iconBg, shape: BoxShape.circle),
                child: Icon(icon, size: 16, color: iconColor),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  label,
                  style: const TextStyle(color: AppColors.textGrey, fontSize: 12),
                ),
              ),
              const Icon(Icons.more_horiz, color: AppColors.textGrey, size: 18),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            value,
            style: const TextStyle(
              color: AppColors.textTitle,
              fontSize: 20,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 6),
          if (trendText != null)
            Row(
              children: [
                const Icon(Icons.arrow_upward, size: 12, color: AppColors.active),
                const SizedBox(width: 2),
                Text(
                  trendText!,
                  style: const TextStyle(
                    color: AppColors.active,
                    fontSize: 11.5,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(width: 4),
                Expanded(
                  child: Text(
                    trendLabel ?? '',
                    style: const TextStyle(color: AppColors.textGrey, fontSize: 11),
                  ),
                ),
                if (sparklineColor != null)
                  SizedBox(
                    width: 46,
                    height: 22,
                    child: CustomPaint(painter: _SparklinePainter(color: sparklineColor!)),
                  ),
              ],
            ),
          if (footer != null) footer!,
        ],
      ),
    );
  }
}

class _SparklinePainter extends CustomPainter {
  final Color color;

  _SparklinePainter({required this.color});

  static const List<double> _points = [0.75, 0.55, 0.62, 0.4, 0.48, 0.22, 0.1];

  @override
  void paint(Canvas canvas, Size size) {
    final path = Path();
    final dx = size.width / (_points.length - 1);

    for (int i = 0; i < _points.length; i++) {
      final x = dx * i;
      final y = size.height * _points[i];
      if (i == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }
    }

    final paint = Paint()
      ..color = color
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant _SparklinePainter oldDelegate) => oldDelegate.color != color;
}

class _CategorySlice {
  final String label;
  final double percent;
  final Color color;

  const _CategorySlice(this.label, this.percent, this.color);
}

class _SalesByCategoryCard extends StatelessWidget {
  const _SalesByCategoryCard();

  static const List<_CategorySlice> _slices = [
    _CategorySlice('Platos principales', 45, AppColors.primaryDark),
    _CategorySlice('Bebidas', 25, AppColors.accentRed),
    _CategorySlice('Entradas', 15, AppColors.accentYellow),
    _CategorySlice('Postres', 15, Color(0xFFE8C7BB)),
  ];

  @override
  Widget build(BuildContext context) {
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
              const Icon(Icons.bar_chart, color: AppColors.primary, size: 20),
              const SizedBox(width: 8),
              const Expanded(
                child: Text(
                  'Ventas por categoría',
                  style: TextStyle(
                    color: AppColors.textTitle,
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: AppColors.softBackground,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Hoy',
                      style: TextStyle(
                        color: AppColors.textTitle,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Icon(Icons.keyboard_arrow_down, size: 16, color: AppColors.textTitle),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 18),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: 120,
                height: 120,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    CustomPaint(
                      size: const Size(120, 120),
                      painter: _DonutPainter(slices: _slices),
                    ),
                    const Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text('Total', style: TextStyle(color: AppColors.textGrey, fontSize: 11)),
                        SizedBox(height: 2),
                        Text(
                          '\$2,850.00',
                          style: TextStyle(
                            color: AppColors.textTitle,
                            fontSize: 13,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: Column(
                  children: _slices
                      .map(
                        (s) => Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5),
                          child: Row(
                            children: [
                              Container(
                                width: 10,
                                height: 10,
                                decoration: BoxDecoration(color: s.color, shape: BoxShape.circle),
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  s.label,
                                  style: const TextStyle(color: AppColors.textTitle, fontSize: 12.5),
                                ),
                              ),
                              Text(
                                '${s.percent.toInt()}%',
                                style: const TextStyle(
                                  color: AppColors.textTitle,
                                  fontSize: 12.5,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                      .toList(),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _DonutPainter extends CustomPainter {
  final List<_CategorySlice> slices;

  _DonutPainter({required this.slices});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;
    const strokeWidth = 18.0;
    double startAngle = -math.pi / 2;

    for (final slice in slices) {
      final sweep = (slice.percent / 100) * 2 * math.pi;
      final paint = Paint()
        ..color = slice.color
        ..style = PaintingStyle.stroke
        ..strokeWidth = strokeWidth
        ..strokeCap = StrokeCap.butt;

      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius - strokeWidth / 2),
        startAngle,
        sweep,
        false,
        paint,
      );
      startAngle += sweep;
    }
  }

  @override
  bool shouldRepaint(covariant _DonutPainter oldDelegate) => oldDelegate.slices != slices;
}

class _RecentSalesCard extends StatelessWidget {
  const _RecentSalesCard();

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
                onTap: () {},
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