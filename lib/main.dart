import 'package:flutter/material.dart';
import 'package:flutter_buffet/Screens/Logs/logs_screen.dart';
import 'package:flutter_buffet/Screens/Reports/reports_screen.dart';
import 'app_routes.dart';
import 'screens/categories/categories_screen.dart';
import 'screens/categories/new_category_screen.dart';
import 'screens/dashboard/dashboard_screen.dart';
import 'screens/inventory/inventory_screen.dart';
import 'screens/platillos/platillos_screen.dart';
import 'screens/platillos/new_platillo_screen.dart';
import 'screens/movimiento/movimiento_screen.dart';
import 'screens/login/login_screen.dart';
import 'screens/users/users_screen.dart';
import 'screens/users/new_user_screen.dart';
import 'screens/inventory/new_inventario_screen.dart';
import 'screens/movimiento/new_movimiento_screen.dart';
import 'screens/Settings/settings_screen.dart';
import 'screens/roles/roles_screen.dart';
import 'screens/roles/new_role_screen.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: AppRoutes.login,
      routes: {
        //ACA CADA QUIEN PONDRA SUS RUTAS PERO AHORITA NO PARA EVITAR CONFLICTOS EN GIT
        AppRoutes.login: (_) => const LoginScreen(),
        AppRoutes.home: (_) => const DashboardScreen(),
        AppRoutes.categories: (_) => const CategoriesScreen(),
        AppRoutes.newcategories: (_) => const NuevaCategoriaScreen(),
        AppRoutes.logs:(_)=>const LogsScreen(),
        AppRoutes.reportes:(_)=>const ReportsScreen(),
        AppRoutes.inventario:(_)=>const InventoryScreen(),
        AppRoutes.platillos:(_)=>const PlatillosScreen(),
        AppRoutes.movimiento:(_)=>const MovimientoScreen(),
        AppRoutes.usuarios:(_)=>const UsersScreen(),
        AppRoutes.newUsuario:(_)=>const NewUserScreen(),
        AppRoutes.newplatillos:(_)=>const NuevoPlatilloScreen(),
        AppRoutes.newinventario:(_)=>const NuevoInventarioScreen(),
        AppRoutes.newmovimiento:(_)=>const NuevoMovimientoScreen(),
        AppRoutes.settings:(_)=>const SettingsScreen(),
        AppRoutes.roles:(_)=>const RolesScreen(),
        AppRoutes.newRol:(_)=>const NewRoleScreen(),
      },
    );
  }
}