import 'package:flutter/material.dart';
import 'package:flutter_buffet/Themes/app_colors.dart';
import 'package:flutter_buffet/Presentation/Widgets/app_top_bar.dart';
import 'package:flutter_buffet/Presentation/Widgets/navigation_bar.dart';
import 'package:flutter_buffet/Presentation/Widgets/photos_picker.dart';
import 'package:flutter_buffet/Presentation/Widgets/form_text_field.dart';
import 'package:flutter_buffet/Presentation/Widgets/form_buttons.dart';
import 'package:flutter_buffet/Presentation/Widgets/app_drawer.dart';

class NuevoInventarioScreen extends StatefulWidget {
  const NuevoInventarioScreen({super.key});

  @override
  State<NuevoInventarioScreen> createState() => _NuevoInventarioScreenState();
}

class _NuevoInventarioScreenState extends State<NuevoInventarioScreen> {
  DateTime fecha = DateTime.now();

  String get fechaTexto =>
      '${fecha.day.toString().padLeft(2, '0')}/${fecha.month.toString().padLeft(2, '0')}/${fecha.year}';

  Future<void> seleccionarFecha() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: fecha,
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
      builder: (context, child) => Theme(
        data: Theme.of(context).copyWith(
          colorScheme: Theme.of(context).colorScheme.copyWith(
                primary: AppColors.primary,
              ),
        ),
        child: child!,
      ),
    );
    if (picked == null) return;
    setState(() => fecha = picked);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      drawer: const AppDrawer(),
      appBar: const AppTopBar(title: 'Nueva Porcion'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            PhotoPicker(onPressed: () {}),
            const SizedBox(height: 24),
            const FormTextField(label: 'Nombre platillo', hint: 'Ej. Tofu Firme'),
            const SizedBox(height: 16),
            const FormTextField(
              label: 'Stock',
              hint: 'Ej. 12',
              lines: 1,
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 16),
            const FormTextField(
              label: 'Precio',
              hint: 'Ej. 9.99',
              lines: 1,
              keyboardType: TextInputType.number,
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
            InkWell(
              borderRadius: BorderRadius.circular(12),
              onTap: seleccionarFecha,
              child: Container(
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
                    const Icon(Icons.calendar_today_outlined,
                        size: 18, color: AppColors.textGrey),
                  ],
                ),
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
      bottomNavigationBar: const AppNavigatorBar(currentIndex: 3),
    );
  }
}