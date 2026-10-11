import 'package:flutter/material.dart';
import 'package:flutter_buffet/Themes/app_colors.dart';
import 'package:flutter_buffet/Presentation/Widgets/app_top_bar.dart';
import 'package:flutter_buffet/Presentation/Widgets/app_drawer.dart';
import 'package:flutter_buffet/Presentation/Widgets/navigation_bar.dart';
import 'package:flutter_buffet/Presentation/Widgets/form_text_field.dart';
import 'package:flutter_buffet/Presentation/Widgets/form_buttons.dart';
import 'package:flutter_buffet/Presentation/Screens/Roles/Widgets/permission_switch_row.dart';
import 'package:flutter_buffet/Presentation/Screens/Roles/roles_screen.dart' show permisosDisponibles;

class NewRoleScreen extends StatefulWidget {
  const NewRoleScreen({super.key});

  @override
  State<NewRoleScreen> createState() => NewRoleScreenState();
}

class NewRoleScreenState extends State<NewRoleScreen> {
  final Map<String, bool> permisos = {
    for (final permiso in permisosDisponibles) permiso['clave'] as String: false,
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      drawer: const AppDrawer(),
      appBar: const AppTopBar(title: 'Nuevo rol'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const FormTextField(label: 'Nombre del rol', hint: 'Ej. Cajero, Mesero, Cocina...'),
            const SizedBox(height: 16),
            const FormTextField(
              label: 'Descripción',
              hint: 'Describe las funciones de este rol...',
              lines: 4,
            ),
            const SizedBox(height: 22),
            const Text(
              'Permisos',
              style: TextStyle(fontSize: 15.5, fontWeight: FontWeight.w700, color: AppColors.textTitle),
            ),
            const SizedBox(height: 3),
            const Text(
              'Selecciona los permisos que tendrá este rol.',
              style: TextStyle(fontSize: 12, color: AppColors.textGrey),
            ),
            const SizedBox(height: 12),
            Column(
              children: permisosDisponibles.map((permiso) {
                final clave = permiso['clave'] as String;
                return Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: PermissionSwitchRow(
                    icono: permiso['icono'] as IconData,
                    titulo: clave,
                    descripcion: permiso['descripcion'] as String,
                    value: permisos[clave] ?? false,
                    onChanged: (valor) => setState(() => permisos[clave] = valor),
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 20),
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