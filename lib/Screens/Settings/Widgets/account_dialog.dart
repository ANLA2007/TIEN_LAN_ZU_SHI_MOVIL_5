import 'package:flutter/material.dart';
import '../../../Themes/app_colors.dart';
import '../../../Widgets/form_buttons.dart';

class LanguageDialog extends StatelessWidget {
  final String idiomaActual;

  const LanguageDialog({
    super.key,
    required this.idiomaActual,
  });

  static Future<String?> mostrar(
    BuildContext context,
    String idiomaActual,
  ) {
    return showModalBottomSheet<String>(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (_) => SafeArea(
        top: false,
        child: LanguageDialog(
          idiomaActual: idiomaActual,
        ),
      ),
    );
  }

  static const List<Map<String, String>> opciones = [
    {'nombre': 'Español', 'bandera': '🇳🇮'},
    {'nombre': 'Malayo', 'bandera': '🇨🇳'}
  ];

  TextStyle estilo(Color color, double size, FontWeight weight) {
    return TextStyle(
      color: color,
      fontSize: size,
      fontWeight: weight,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.85,
      ),
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 28),
      decoration: const BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(24),
        ),
      ),
      child: SingleChildScrollView(
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
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            Text(
              'Idioma',
              style: estilo(Colors.black, 17, FontWeight.w700),
            ),
            const SizedBox(height: 4),
            Text(
              'Selecciona el idioma de la aplicación',
              style: estilo(AppColors.textGrey, 12.5, FontWeight.w400),
            ),
            const SizedBox(height: 14),
            ...opciones.map((op) {
              final seleccionado = op['nombre'] == idiomaActual;

              return Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: InkWell(
                  borderRadius: BorderRadius.circular(14),
                  onTap: () => Navigator.of(context).pop(op['nombre']),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 12,
                    ),
                    decoration: BoxDecoration(
                      color: seleccionado
                          ? AppColors.primary.withOpacity(0.08)
                          : AppColors.background,
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(
                        color: seleccionado
                            ? AppColors.primary
                            : AppColors.border,
                      ),
                    ),
                    child: Row(
                      children: [
                        Text(
                          op['bandera']!,
                          style: const TextStyle(fontSize: 20),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            op['nombre']!,
                            style: estilo(
                              Colors.black87,
                              14.5,
                              seleccionado
                                  ? FontWeight.w700
                                  : FontWeight.w500,
                            ),
                          ),
                        ),
                        if (seleccionado)
                          const Icon(
                            Icons.check_circle,
                            color: AppColors.primary,
                            size: 20,
                          ),
                      ],
                    ),
                  ),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}