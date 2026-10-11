import 'package:flutter/material.dart';
import 'package:flutter_buffet/Themes/app_colors.dart';
import 'package:flutter_buffet/Presentation/Widgets/app_top_bar.dart';
import 'package:flutter_buffet/Presentation/Widgets/app_drawer.dart';
import 'package:flutter_buffet/Presentation/Widgets/navigation_bar.dart';
import 'package:flutter_buffet/Presentation/Widgets/photos_picker.dart';
import 'package:flutter_buffet/Presentation/Widgets/form_text_field.dart';
import 'package:flutter_buffet/Presentation/Widgets/status_switch.dart';
import 'package:flutter_buffet/Presentation/Widgets/form_buttons.dart';
import 'package:flutter_buffet/Presentation/Screens/Users/Widgets/role_dropdown.dart';
import 'package:flutter_buffet/Presentation/Screens/Users/users_screen.dart' show rolesDisponibles;

class NewUserScreen extends StatefulWidget {
  const NewUserScreen({super.key});

  @override
  State<NewUserScreen> createState() => NewUserScreenState();
}

class NewUserScreenState extends State<NewUserScreen> {
  String? rolSeleccionado;
  bool activo = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      drawer: const AppDrawer(),
      appBar: const AppTopBar(title: 'Nuevo Usuario'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            PhotoPicker(onPressed: () {}),
            const SizedBox(height: 24),
            const FormTextField(label: 'Nombre completo', hint: 'Sofia Tapia'),
            const SizedBox(height: 16),
            const FormTextField(label: 'Correo electrónico', hint: 'softap@buffet.com'),
            const SizedBox(height: 16),
            const FormTextField(label: 'Teléfono', hint: '8888-8888'),
            const SizedBox(height: 16),
            RoleDropdown(
              value: rolSeleccionado,
              opciones: rolesDisponibles,
              onChanged: (valor) => setState(() => rolSeleccionado = valor),
            ),
            const SizedBox(height: 20),
            StatusSwitch(
              value: activo,
              onChanged: (valor) => setState(() => activo = valor),
            ),
            const SizedBox(height: 28),
            FormButtons(
              onCancel: () => Navigator.of(context).pop(),
              onSave: () {},
            ),
          ],
        ),
      ),
      bottomNavigationBar: const AppNavigatorBar(currentIndex: null),
    );
  }
}