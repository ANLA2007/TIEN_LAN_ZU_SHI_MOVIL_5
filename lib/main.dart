import 'package:flutter/material.dart';
import 'package:flutter_buffet/app_routes.dart';
import 'package:flutter_buffet/Presentation/Screens/Login/login_screen.dart';
import 'package:flutter_buffet/Presentation/Screens/Dashboard/dashboard_screen.dart';
import 'package:flutter_buffet/Presentation/Screens/categories/categories_screen.dart';
import 'package:flutter_buffet/Presentation/Screens/categories/new_category_screen.dart';
import 'package:flutter_buffet/Presentation/Screens/Logs/logs_screen.dart';
import 'package:flutter_buffet/Presentation/Screens/Reports/reports_screen.dart';
import 'package:flutter_buffet/Presentation/Screens/inventory/inventory_screen.dart';
import 'package:flutter_buffet/Presentation/Screens/inventory/new_inventario_screen.dart';
import 'package:flutter_buffet/Presentation/Screens/platillos/platillos_screen.dart';
import 'package:flutter_buffet/Presentation/Screens/platillos/new_platillo_screen.dart';
import 'package:flutter_buffet/Presentation/Screens/movimiento/movimiento_screen.dart';
import 'package:flutter_buffet/Presentation/Screens/movimiento/new_movimiento_screen.dart';
import 'package:flutter_buffet/Presentation/Screens/Users/users_screen.dart';
import 'package:flutter_buffet/Presentation/Screens/Users/new_user_screen.dart';
import 'package:flutter_buffet/Presentation/Screens/Roles/roles_screen.dart';
import 'package:flutter_buffet/Presentation/Screens/Roles/new_role_screen.dart';
import 'package:flutter_buffet/Presentation/Screens/Settings/settings_screen.dart';

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