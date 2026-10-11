import 'package:flutter/material.dart';
import 'package:flutter_buffet/Themes/app_colors.dart';
import 'package:flutter_buffet/Presentation/Widgets/app_top_bar.dart';
import 'package:flutter_buffet/Presentation/Widgets/navigation_bar.dart';
import 'package:flutter_buffet/Presentation/Widgets/photos_picker.dart';
import 'package:flutter_buffet/Presentation/Widgets/form_text_field.dart';
import 'package:flutter_buffet/Presentation/Widgets/status_switch.dart';
import 'package:flutter_buffet/Presentation/Widgets/form_buttons.dart';
import 'package:flutter_buffet/Presentation/Widgets/app_drawer.dart';



class NuevoPlatilloScreen extends StatefulWidget {
  const NuevoPlatilloScreen({super.key});

  @override
  State<NuevoPlatilloScreen> createState() => _NuevoPlatilloScreenState();
}

class _NuevoPlatilloScreenState extends State<NuevoPlatilloScreen> {
  bool estado = true;
  bool reconsumible = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
  drawer: const AppDrawer(),
      appBar: const AppTopBar(title: 'Nuevo Platillo'),
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
            const FormTextField(label: 'Precio', hint: 'Ej. 9.99', lines: 1, keyboardType: TextInputType.number),
            const SizedBox(height: 20),
            StatusSwitch(value: reconsumible, onChanged: (value) {setState(() => reconsumible = value);}, label: 'Reconsumible'),
            const SizedBox(height: 20),
            StatusSwitch(value: estado, onChanged: (value) {setState(() => estado = value);}),
            const SizedBox(height: 28),
            FormButtons(
              onCancel: () => Navigator.of(context).pop(),
              onSave: () {},
            ),
          ],
        ),
      ),
      bottomNavigationBar: const AppNavigatorBar(currentIndex: 2),
    );
  }
}