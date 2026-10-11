import 'package:flutter/material.dart';
import 'package:flutter_buffet/Themes/app_colors.dart';
import 'package:flutter_buffet/Presentation/Widgets/app_top_bar.dart';
import 'package:flutter_buffet/Presentation/Widgets/app_drawer.dart';
import 'package:flutter_buffet/Presentation/Widgets/navigation_bar.dart';
import 'package:flutter_buffet/app_routes.dart';
import 'package:flutter_buffet/Presentation/Screens/Roles/Widgets/permission_switch_row.dart';
import 'package:flutter_buffet/Presentation/Screens/Roles/Widgets/role_stats_bar.dart';
import 'package:flutter_buffet/Presentation/Screens/Roles/roles_screen.dart' show permisosDisponibles;

class RoleDetailScreen extends StatefulWidget {
  final Map<String, dynamic> rol;

  const RoleDetailScreen({super.key, required this.rol});

  @override
  State<RoleDetailScreen> createState() => RoleDetailScreenState();
}

class RoleDetailScreenState extends State<RoleDetailScreen> {
  late Map<String, bool> permisos;

  @override
  void initState() {
    super.initState();
    permisos = Map<String, bool>.from(widget.rol['permisos'] as Map);
  }

  @override
  Widget build(BuildContext context) {
    final bool activo = widget.rol['activo'] as bool;

    return Scaffold(
      backgroundColor: AppColors.background,
      drawer: const AppDrawer(),
      appBar: const AppTopBar(title: 'Rol'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.cardBackground,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppColors.border),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 64,
                    height: 64,
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: BorderRadius.circular(18),
                    ),
                    child: Icon(widget.rol['icono'] as IconData, color: Colors.white, size: 30),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.rol['nombre'] as String,
                          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: AppColors.textTitle),
                        ),
                        const SizedBox(height: 6),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                          decoration: BoxDecoration(
                            color: (activo ? AppColors.active : AppColors.textGrey).withOpacity(0.15),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            activo ? 'Activo' : 'Inactivo',
                            style: TextStyle(
                              color: activo ? AppColors.active : AppColors.textGrey,
                              fontSize: 11.5,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          widget.rol['descripcion'] as String,
                          style: const TextStyle(fontSize: 12.5, color: AppColors.textGrey, height: 1.35),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            RoleStatsBar(
              usuariosAsignados: widget.rol['usuariosAsignados'] as int,
              fechaCreacion: widget.rol['fechaCreacion'] as String,
              activo: activo,
            ),
            const SizedBox(height: 22),
            const Text(
              'Permisos',
              style: TextStyle(fontSize: 15.5, fontWeight: FontWeight.w700, color: AppColors.textTitle),
            ),
            const SizedBox(height: 3),
            const Text(
              'Acceso a las siguientes funcionalidades:',
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
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.of(context).pushNamed(AppRoutes.newRol);
                },
                icon: const Icon(Icons.edit_outlined),
                label: const Text('Editar rol'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const AppNavigatorBar(currentIndex: null),
    );
  }
}