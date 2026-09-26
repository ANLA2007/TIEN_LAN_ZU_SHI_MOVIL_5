import 'package:flutter/material.dart';
import '../../Themes/app_colors.dart';
import '../../Widgets/app_top_bar.dart';
import '../../Widgets/app_drawer.dart';
import '../../Widgets/navigation_bar.dart';
import '../../Widgets/pagination_bar.dart';
import '../../app_routes.dart';
import 'Widgets/role_card.dart';
import 'role_detail_screen.dart';

const List<Map<String, dynamic>> permisosDisponibles = [
  {
    'clave': 'Ventas',
    'icono': Icons.shopping_cart_outlined,
    'descripcion': 'Gestionar ventas y reportes.',
  },
  {
    'clave': 'Platillos',
    'icono': Icons.restaurant_menu_outlined,
    'descripcion': 'Administrar el catálogo de platillos.',
  },
  {
    'clave': 'Inventario',
    'icono': Icons.inventory_2_outlined,
    'descripcion': 'Controlar el stock de productos.',
  },
  {
    'clave': 'Clientes',
    'icono': Icons.people_outline,
    'descripcion': 'Gestionar la información de clientes.',
  },
  {
    'clave': 'Historial de ventas',
    'icono': Icons.receipt_long_outlined,
    'descripcion': 'Consultar y exportar reportes de ventas.',
  },
  {
    'clave': 'Usuarios',
    'icono': Icons.person_outline,
    'descripcion': 'Administrar los usuarios del sistema.',
  },
  {
    'clave': 'Configuración',
    'icono': Icons.settings_outlined,
    'descripcion': 'Ajustar la configuración del sistema.',
  },
];

final List<Map<String, dynamic>> roles = [
  {
    'nombre': 'Administrador',
    'icono': Icons.shield_outlined,
    'descripcion':
        'Acceso completo al sistema. Puede gestionar usuarios, roles, configuración y reportes.',
    'activo': true,
    'usuariosAsignados': 1,
    'fechaCreacion': '15/08/2025',
    'permisos': {
      'Ventas': true,
      'Platillos': true,
      'Inventario': true,
      'Clientes': true,
      'Historial de ventas': true,
      'Usuarios': true,
      'Configuración': true,
    },
  },
  {
    'nombre': 'Cajero',
    'icono': Icons.point_of_sale_outlined,
    'descripcion': 'Gestiona ventas y cobros. No puede modificar inventario.',
    'activo': true,
    'usuariosAsignados': 3,
    'fechaCreacion': '15/08/2025',
    'permisos': {
      'Ventas': true,
      'Platillos': true,
      'Inventario': false,
      'Clientes': false,
      'Historial de ventas': true,
      'Usuarios': false,
      'Configuración': false,
    },
  },
];

class RolesScreen extends StatelessWidget {
  const RolesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      drawer: const AppDrawer(),
      appBar: const AppTopBar(title: 'Roles'),
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 14, 16, 4),
              child: Align(
                alignment: Alignment.centerRight,
                child: InkWell(
                  borderRadius: BorderRadius.circular(14),
                  onTap: () {
                    Navigator.of(context).pushNamed(AppRoutes.newRol);
                  },
                  child: Container(
                    height: 46,
                    width: 46,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: const Icon(Icons.add, color: Colors.white, size: 22),
                  ),
                ),
              ),
            ),
            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.fromLTRB(16, 10, 16, 16),
                itemCount: roles.length,
                separatorBuilder: (context, index) => const SizedBox(height: 12),
                itemBuilder: (context, index) {
                  final rol = roles[index];

                  return RoleCard(
                    nombre: rol['nombre'] as String,
                    descripcion: rol['descripcion'] as String,
                    icono: rol['icono'] as IconData,
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (_) => RoleDetailScreen(rol: rol)),
                      );
                    },
                  );
                },
              ),
            ),
            PaginationBar(
              currentPage: 1,
              totalPages: 1,
              infoText: 'Mostrando 1-${roles.length} de ${roles.length} roles',
            ),
          ],
        ),
      ),
      bottomNavigationBar: const AppNavigatorBar(currentIndex: null),
    );
  }
}