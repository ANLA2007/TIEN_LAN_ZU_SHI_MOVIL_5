import 'package:flutter/material.dart';

class LogIcono extends StatelessWidget {
  final IconData icono;
  final Color color;

  const LogIcono({super.key, required this.icono, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 56,
      height: 56,
      decoration: BoxDecoration(
        color: color.withOpacity(0.12),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Icon(icono, color: color, size: 30),
    );
  }
}