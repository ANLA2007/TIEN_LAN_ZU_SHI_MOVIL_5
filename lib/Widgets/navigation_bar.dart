import 'package:flutter/material.dart';

import '../Themes/app_colors.dart';

class AppNavigatorBar extends StatelessWidget {
  final int currentIndex;

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
        selectedIndex: currentIndex,
        onDestinationSelected: (int index) {
          if (currentIndex == index) return;

          switch (index) {
            case 0:
              Navigator.of(context).pushReplacementNamed('/home');
              break;
            case 1:
              Navigator.of(context).pushReplacementNamed('/categorias');
              break;
            case 2:
              Navigator.of(context).pushReplacementNamed('/platillos');
              break;
            case 3:
              Navigator.of(context).pushReplacementNamed('/inventario');
              break;
            case 4:
              Navigator.of(context).pushReplacementNamed('/movimiento');
              break;
            case 5:
              Navigator.of(context).pushReplacementNamed('/reportes');
              break;
          }
        },
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home, color: Colors.white), label: 'Home'),
          NavigationDestination(icon: Icon(Icons.category, color: Colors.white), label: 'Categoria'),
          NavigationDestination(icon: Icon(Icons.restaurant_menu, color: Colors.white), label: 'Platillos'),
          NavigationDestination(icon: Icon(Icons.inventory_2, color: Colors.white), label: 'Inventario'),
          NavigationDestination(icon: Icon(Icons.swap_horiz, color: Colors.white), label: 'Movimiento'),
          NavigationDestination(icon: Icon(Icons.bar_chart, color: Colors.white), label: 'Reportes'),
        ],
      ),
    );
  }
}