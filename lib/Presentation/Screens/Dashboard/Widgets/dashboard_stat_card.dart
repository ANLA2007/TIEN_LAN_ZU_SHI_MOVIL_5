import 'package:flutter/material.dart';
import 'package:flutter_buffet/Themes/app_colors.dart';

class DashboardStatCard extends StatelessWidget {
  final IconData icon;
  final Color iconBg;
  final Color iconColor;
  final String label;
  final String value;
  final String? trendText;
  final String? trendLabel;
  final Color? sparklineColor;
  final Widget? footer;

  const DashboardStatCard({
    super.key,
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