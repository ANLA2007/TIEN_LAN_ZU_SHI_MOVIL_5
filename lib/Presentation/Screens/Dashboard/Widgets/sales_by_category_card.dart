import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../../../Themes/app_colors.dart';

class SalesByCategoryCard extends StatelessWidget {
  const SalesByCategoryCard({super.key});

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

class _CategorySlice {
  final String label;
  final double percent;
  final Color color;

  const _CategorySlice(this.label, this.percent, this.color);
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