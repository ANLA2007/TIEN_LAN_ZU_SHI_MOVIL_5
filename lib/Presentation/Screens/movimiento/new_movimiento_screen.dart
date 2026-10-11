import 'package:flutter/material.dart';
import 'package:flutter_buffet/Themes/app_colors.dart';
import 'package:flutter_buffet/Presentation/Widgets/app_top_bar.dart';
import 'package:flutter_buffet/Presentation/Widgets/navigation_bar.dart';
import 'package:flutter_buffet/Presentation/Widgets/form_text_field.dart';
import 'package:flutter_buffet/Presentation/Widgets/form_buttons.dart';
import 'package:flutter_buffet/Presentation/Widgets/app_drawer.dart';

const List<String> tiposMovimiento = ['Entrada', 'Salida', 'Merma'];

class NuevoMovimientoScreen extends StatefulWidget {
  const NuevoMovimientoScreen({super.key});

  @override
  State<NuevoMovimientoScreen> createState() => _NuevoMovimientoScreenState();
}

class _NuevoMovimientoScreenState extends State<NuevoMovimientoScreen> {
  String tipoMovimiento = tiposMovimiento.first;
  DateTime fecha = DateTime.now();

  String get fechaTexto =>
      '${fecha.day.toString().padLeft(2, '0')}/${fecha.month.toString().padLeft(2, '0')}/${fecha.year}';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      drawer: const AppDrawer(),
      appBar: const AppTopBar(title: 'Nuevo Movimiento'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const FormTextField(label: 'Platillo', hint: 'Ej. Tofu Firme'),
            const SizedBox(height: 16),
            const Text(
              'Tipo de Movimiento',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: AppColors.primary,
              ),
            ),
            const SizedBox(height: 8),
            DropdownButtonFormField<String>(
              initialValue: tipoMovimiento,
              icon: const Icon(Icons.keyboard_arrow_down, color: AppColors.textGrey),
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: AppColors.border),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: AppColors.primary, width: 1.5),
                ),
              ),
              items: tiposMovimiento
                  .map((tipo) => DropdownMenuItem(
                        value: tipo,
                        child: Text(tipo),
                      ))
                  .toList(),
              onChanged: (valor) {
                if (valor == null) return;
                setState(() => tipoMovimiento = valor);
              },
            ),
            const SizedBox(height: 16),
            const FormTextField(
              label: 'Stock actual',
              hint: 'Ej. 30',
              lines: 1,
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 16),
            const FormTextField(
              label: 'Cantidad',
              hint: 'Ej. 15',
              lines: 1,
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 16),
            const FormTextField(
              label: 'Justificacion',
              hint: 'Ej. Se cayo, vencimiento, uso interno...',
              lines: 3,
            ),
            const SizedBox(height: 16),
            const Text(
              'Fecha',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: AppColors.primary,
              ),
            ),
            const SizedBox(height: 8),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppColors.border),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      fechaTexto,
                      style: const TextStyle(color: Colors.black, fontSize: 14),
                    ),
                  ),
                  const Icon(Icons.event_outlined, size: 18, color: AppColors.textGrey),
                ],
              ),
            ),
            const SizedBox(height: 28),
            FormButtons(
              onCancel: () => Navigator.of(context).pop(),
              onSave: () {},
            ),
          ],
        ),
      ),
      bottomNavigationBar: const AppNavigatorBar(currentIndex: 4),
    );
  }
}