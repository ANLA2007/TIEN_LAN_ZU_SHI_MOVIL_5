import 'package:flutter/material.dart';

import '../Themes/app_colors.dart';
import '../app_routes.dart';

class AppNavigatorBar extends StatelessWidget {
  final int? currentIndex;

  const AppNavigatorBar({super.key, required this.currentIndex});

  @override
  Widget build(BuildContext context) {
    return NavigationBarTheme(
      data: NavigationBarThemeData(
        labelTextStyle: WidgetStateProperty.resolveWith((states) {
          final bool selected = states.contains(WidgetState.selected);
          return TextStyle(
            fontSize: 10.5,
            fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
            color: selected ? Colors.white : Colors.white70,
          );
        }),
      ),
      child: NavigationBar(
        backgroundColor: AppColors.primary,
        indicatorColor: AppColors.accentYellow.withOpacity(0.35),
        height: 64,
        labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
       selectedIndex: currentIndex ?? 0,
        onDestinationSelected: (int index) {
          if (currentIndex == index) return;

          switch (index) {
            case 0:
             Navigator.of(context).pushReplacementNamed(AppRoutes.home);
              break;
            case 1:
              Navigator.of(context).pushReplacementNamed(AppRoutes.categories);
              break;
            case 2:
             // Navigator.of(context).pushReplacementNamed(AppRoutes.platillos);
              break;
            case 3:
             // Navigator.of(context).pushReplacementNamed(AppRoutes.inventario);
              break;
            case 4:
              //Navigator.of(context).pushReplacementNamed(AppRoutes.movimiento);
              break;
            case 5:
              //Navigator.of(context).pushReplacementNamed(AppRoutes.reportes);
              break;
          }
        },
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home, color: Colors.white), label: 'Home'),
          NavigationDestination(icon: Icon(Icons.category, color: Colors.white), label: 'Categoria'),
          NavigationDestination(icon: Icon(Icons.restaurant_menu, color: Colors.white), label: 'platillos'),
          NavigationDestination(icon: Icon(Icons.inventory_2, color: Colors.white), label: 'Inventario'),
          NavigationDestination(icon: Icon(Icons.swap_horiz, color: Colors.white), label: 'Movimiento'),
          NavigationDestination(icon: Icon(Icons.bar_chart, color: Colors.white), label: 'Reportes'),
        ],
      ),
    );
  }
}