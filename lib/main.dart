import 'package:flutter/material.dart';
import 'package:flutter_buffet/Screens/Logs/logs_screen.dart';
import 'app_routes.dart';
import 'screens/categories/categories_screen.dart';
import 'screens/categories/new_category_screen.dart';
//import 'Screens/login/login_screen.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: AppRoutes.categories,
      routes: {
        //ACA CADA QUIEN PONDRA SUS RUTAS PERO AHORITA NO PARA EVITAR CONFLICTOS EN GIT
        //AppRoutes.login: (_) => const LoginScreen(),
        AppRoutes.categories: (_) => const CategoriesScreen(),
        AppRoutes.newcategories: (_) => const NuevaCategoriaScreen(),
        AppRoutes.logs:(_)=>const LogsScreen()
      },
    );
  }
}