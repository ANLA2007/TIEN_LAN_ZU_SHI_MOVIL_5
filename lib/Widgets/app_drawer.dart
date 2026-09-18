import 'package:flutter/material.dart';

import '../Themes/app_colors.dart';
import '../app_routes.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  void _onItemSelected(BuildContext context, int index) {
    Navigator.of(context).pop();

    switch (index) {
      case 0: // Perfil
       // Navigator.of(context).pushNamed(AppRoutes.perfil);
        break;
      case 1: // Usuarios
        // Navigator.of(context).pushNamed(AppRoutes.usuarios);
        break;
      case 2: // Roles
        // Navigator.of(context).pushNamed(AppRoutes.roles);
        break;
      case 3: // Logs
        Navigator.of(context).pushNamed(AppRoutes.logs);
        break;
      case 4: // Configuracion
        // Navigator.of(context).pushNamed(AppRoutes.configuracion);
        break;
    
    }
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: AppColors.background,
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 28),
              color: AppColors.primary,
              child: Column(
                children: [
                  Container(
                    width: 90,
                    height: 90,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                      border: Border.all(color: Colors.white, width: 3),
                    ),
                    child: const Icon(
                      Icons.account_circle,
                      color: AppColors.primary,
                      size: 90,
                    ),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'Admin Tien Lan Zu Shi',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 16),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            drawerItem(
              context,
              icon: Icons.account_circle_outlined,
              label: 'Perfil',
              onTap: () => _onItemSelected(context, 0),
            ),
            drawerItem(
              context,
              icon: Icons.people_outline,
              label: 'Usuarios',
              onTap: () => _onItemSelected(context, 1),
            ),
            drawerItem(
              context,
              icon: Icons.admin_panel_settings_outlined,
              label: 'Roles',
              onTap: () => _onItemSelected(context, 2),
            ),
            drawerItem(
              context,
              icon: Icons.receipt_long_outlined,
              label: 'Logs',
              onTap: () => _onItemSelected(context, 3),
            ),
            drawerItem(
              context,
              icon: Icons.settings_outlined,
              label: 'Configuracion',
              onTap: () => _onItemSelected(context, 4),
            ),
            const Spacer(),
            const Divider(height: 1),
            drawerItem(
              context,
              icon: Icons.logout,
              label: 'Cerrar sesion',
              color: AppColors.accentRed,
              onTap: () => _onItemSelected(context, 5),
            ),
            const SizedBox(height: 12),
          ],
        ),
      ),
    );
  }

  Widget drawerItem(
    BuildContext context, {
    required IconData icon,
    required String label,
    required VoidCallback onTap,
    Color color = AppColors.primary,
  }) {
    return ListTile(
      leading: Icon(icon, color: color, size: 24),
      title: Text(
        label,
        style: TextStyle(color: color, fontWeight: FontWeight.w600, fontSize: 14.5),
      ),
      onTap: onTap,
    );
  }
}