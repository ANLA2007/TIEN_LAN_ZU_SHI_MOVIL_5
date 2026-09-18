import 'package:flutter/material.dart';
import '../../Themes/app_colors.dart';
import '../../Widgets/app_top_bar.dart';
import '../../Widgets/navigation_bar.dart';
import '../../Widgets/photos_picker.dart';
import '../../Widgets/form_text_field.dart';
import '../../Widgets/status_switch.dart';
import '../../Widgets/form_buttons.dart';
import '../../Widgets/app_drawer.dart';

class NuevaCategoriaScreen extends StatelessWidget {
  const NuevaCategoriaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
  drawer: const AppDrawer(),
      appBar: const AppTopBar(title: 'Nueva Categoria'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            PhotoPicker(onPressed: () {}),
            const SizedBox(height: 24),
            const FormTextField(label: 'Nombre', hint: 'Ej. Bebidas calientes'),
            const SizedBox(height: 16),
            const FormTextField(label: 'Descripción', hint: 'Para temporadas heladas...', lines: 3),
            const SizedBox(height: 20),
            StatusSwitch(value: true, onChanged: (value) {}),
            const SizedBox(height: 28),
            FormButtons(
              onCancel: () => Navigator.of(context).pop(),
              onSave: () {},
            ),
          ],
        ),
      ),
      bottomNavigationBar: const AppNavigatorBar(currentIndex: 1),
    );
  }
}