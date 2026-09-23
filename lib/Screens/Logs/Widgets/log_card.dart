import 'package:flutter/material.dart';

import '../../../Themes/app_colors.dart';
import 'log_icono.dart';
import 'log_titulo.dart';

class LogCard extends StatelessWidget {
  final Map<String, dynamic> log;

  const LogCard({super.key, required this.log});

  @override
  Widget build(BuildContext context) {
    final color = log['color'] as Color;

    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        children: [
          LogIcono(icono: log['icono'] as IconData, color: color),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                LogTitulo(titulo: log['titulo'] as String, hora: log['hora'] as String),
                Text(log['descripcion'] as String,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(color: AppColors.textGrey, fontSize: 12.5)),
                const SizedBox(height: 6),
                Text(log['fecha'] as String, style: const TextStyle(color: AppColors.textGrey, fontSize: 11)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}