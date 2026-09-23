import 'package:flutter/material.dart';

import '../../../Themes/app_colors.dart';

class LogTitulo extends StatelessWidget {
  final String titulo;
  final String hora;

  const LogTitulo({super.key, required this.titulo, required this.hora});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(titulo,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w700,
                fontSize: 15,
              )),
        ),
        Text(hora, style: const TextStyle(color: AppColors.textGrey, fontSize: 11)),
      ],
    );
  }
}