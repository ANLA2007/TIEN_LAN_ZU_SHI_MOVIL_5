import 'package:flutter/material.dart';

import '../../Themes/app_colors.dart';
import '../../Widgets/app_top_bar.dart';
import '../../Widgets/list_item_card.dart';
import '../../Widgets/navigation_bar.dart';
import '../../Widgets/pagination_bar.dart';
import '../../Widgets/search_bar.dart';
import '../../app_routes.dart';

class Categoria {
  final String nombre;
  final String descripcion;
  final String imagen;
  final bool activa;
  final IconData icono;
  final Color color;

  const Categoria({
    required this.nombre,
    required this.descripcion,
    required this.imagen,
    required this.activa,
    required this.icono,
    required this.color,
  });
}

final List<Categoria> categorias = [
  const Categoria(
    nombre: 'Principales',
    descripcion: 'Platos fuertes, especialidades y recetas de la casa.',
    imagen: 'assets/principales.jpeg',
    activa: true,
    icono: Icons.restaurant_menu,
    color: AppColors.accentRed,
  ),
  const Categoria(
    nombre: 'Entradas',
    descripcion: 'Aperitivos, bocadillos y opciones para compartir.',
    imagen: 'assets/entradas.jpeg',
    activa: false,
    icono: Icons.soup_kitchen,
    color: AppColors.accentYellow,
  ),
  const Categoria(
    nombre: 'Bebidas',
    descripcion: 'Refrescos naturales, cocteles y cafe.',
    imagen: 'assets/bebidas.jpeg',
    activa: true,
    icono: Icons.local_bar,
    color: AppColors.accentYellow,
  ),
  const Categoria(
    nombre: 'Postres',
    descripcion: 'Dulces artesanales, helados y reposteria.',
    imagen: 'assets/postres.jpeg',
    activa: false,
    icono: Icons.icecream,
    color: AppColors.accentGreen,
  ),
];

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      drawer: const Drawer(),
      appBar: const AppTopBar(title: 'Categorias'),
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 14, 16, 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 12),
                  AppSearchBar(
                    hintText: 'Buscar categoria...',
                    actionLabel: 'Nueva Categoria',
                    onPressed: () {
                      Navigator.of(context).pushNamed(AppRoutes.newcategories);
                    },
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.fromLTRB(16, 4, 16, 16),
                itemCount: categorias.length,
                separatorBuilder: (context, index) => const SizedBox(height: 12),
                itemBuilder: (context, index) {
                  final Categoria categoria = categorias[index];

                  return ListItemCard(
                    title: categoria.nombre,
                    subtitle: categoria.descripcion,
                    imageAsset: categoria.imagen,
                    isActive: categoria.activa,
                    icon: categoria.icono,
                    accentColor: categoria.color,
                    onTap: () {},
                    onView: () {},
                    onEdit: () {},
                    onDelete: () {},
                  );
                },
              ),
            ),
            const PaginationBar(
              currentPage: 1,
              totalPages: 3,
              infoText: 'Mostrando 1-10 de 30',
            ),
          ],
        ),
      ),
      bottomNavigationBar: const AppNavigatorBar(currentIndex: 1),
    );
  }
}