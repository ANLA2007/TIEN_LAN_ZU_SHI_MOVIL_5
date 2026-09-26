import 'package:flutter/material.dart';
import '../Themes/app_colors.dart';
import '../app_routes.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  void _onItemSelected(BuildContext context, int index) {
    Navigator.of(context).pop();

    switch (index) {
      case 0: // Usuarios
         Navigator.of(context).pushNamed(AppRoutes.usuarios);
        break;
      case 1: // Roles
         Navigator.of(context).pushNamed(AppRoutes.roles);
        break;
      case 2: // Logs
        Navigator.of(context).pushNamed(AppRoutes.logs);
        break;
      case 3: // Configuracion
         Navigator.of(context).pushNamed(AppRoutes.settings);
        break;
      case 4: // Cerrar sesion
      Navigator.of(context).pushNamedAndRemoveUntil(AppRoutes.login, (route) => false);
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
            encabezado(context),
            const SizedBox(height: 12),
            drawerItem(
              context,
              icon: Icons.people_outline,
              label: 'Usuarios',
              onTap: () => _onItemSelected(context, 0),
            ),
            drawerItem(
              context,
              icon: Icons.admin_panel_settings_outlined,
              label: 'Roles',
              onTap: () => _onItemSelected(context, 1),
            ),
            drawerItem(
              context,
              icon: Icons.receipt_long_outlined,
              label: 'Logs',
              onTap: () => _onItemSelected(context, 2),
            ),
            drawerItem(
              context,
              icon: Icons.settings_outlined,
              label: 'Configuracion',
              onTap: () => _onItemSelected(context, 3),
            ),
            const Spacer(),
            Divider(
              height: 1,
              indent: 16,
              endIndent: 16,
              color: AppColors.primary.withOpacity(0.2),
            ),
            const SizedBox(height: 8),
            drawerItem(
              context,
              icon: Icons.logout,
              label: 'Cerrar sesion',
              color: AppColors.accentRed,
              onTap: () => _onItemSelected(context, 4),
            ),
            const SizedBox(height: 12),
          ],
        ),
      ),
    );
  }

  Widget encabezado(BuildContext context) {
    return Container(
      width: double.infinity,
      clipBehavior: Clip.hardEdge,
      padding: const EdgeInsets.symmetric(vertical: 28),
      decoration: const BoxDecoration(
        color: AppColors.primary,
      ),
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.center,
        children: [
          burbuja(120, top: -50, right: -40),
          burbuja(70, bottom: 10, left: -25),
          Column(
            children: [
              Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Colors.white70,
                    width: 3,
                  ),
                ),
                child: const CircleAvatar(
                  radius: 40,
                  backgroundColor: Colors.white,
                  child: Icon(
                    Icons.person,
                    size: 46,
                    color: AppColors.primary,
                  ),
                ),
              ),
              const SizedBox(height: 12),
              const Text(
                'Tien Lan Zu Shi',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 5,
                ),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.12),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: Colors.white24,
                  ),
                ),
                child: const Text(
                  'ADMINISTRADOR',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 11,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget burbuja(
    double tamano, {
    double? top,
    double? bottom,
    double? left,
    double? right,
  }) {
    return Positioned(
      top: top,
      bottom: bottom,
      left: left,
      right: right,
      child: Container(
        width: tamano,
        height: tamano,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: AppColors.primaryLight.withOpacity(0.35),
          border: Border.all(
            color: Colors.white.withOpacity(0.3),
          ),
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
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 4,
      ),
      child: ListTile(
        onTap: onTap,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        leading: CircleAvatar(
          backgroundColor: color,
          child: Icon(
            icon,
            color: Colors.white,
            size: 22,
          ),
        ),
        title: Text(
          label,
          style: TextStyle(
            color: color,
            fontWeight: FontWeight.w700,
            fontSize: 15.5,
          ),
        ),
        trailing: Icon(
          Icons.chevron_right,
          color: color,
        ),
      ),
    );
  }
}