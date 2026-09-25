import 'package:flutter/material.dart';
import '../../../../Themes/app_colors.dart';

class RoleDropdown extends StatelessWidget {
  final String label;
  final String? value;
  final List<String> opciones;
  final ValueChanged<String?> onChanged;

  const RoleDropdown({
    super.key,
    this.label = 'Rol',
    required this.value,
    required this.opciones,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.w600, color: AppColors.primary)),
        const SizedBox(height: 8),
        DropdownButtonFormField<String>(
          initialValue: value,
          icon: const Icon(Icons.keyboard_arrow_down, color: AppColors.primary),
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: AppColors.primary, width: 1.5),
            ),
          ),
          hint: const Text('Selecciona un rol'),
          items: opciones
              .map((rol) => DropdownMenuItem(value: rol, child: Text(rol)))
              .toList(),
          onChanged: onChanged,
        ),
      ],
    );
  }
}