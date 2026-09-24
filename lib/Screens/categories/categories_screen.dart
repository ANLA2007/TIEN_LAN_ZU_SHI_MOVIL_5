import 'package:flutter/material.dart';
import '../../Themes/app_colors.dart';
import '../../Widgets/app_top_bar.dart';
import 'Widgets/list_item_card.dart';
import '../../Widgets/navigation_bar.dart';
import '../../Widgets/pagination_bar.dart';
import '../../Widgets/search_bar.dart';
import '../../app_routes.dart';
import '../../Widgets/app_drawer.dart';

final List<Map<String, dynamic>> categorias = [
  {
    'nombre': 'Principales',
    'descripcion': 'Platos fuertes, especialidades y recetas de la casa.',
    'imagen': 'assets/principales.jpeg',
    'activa': true,
    'color': AppColors.accentRed,
  },
  {
    'nombre': 'Entradas',
    'descripcion': 'Aperitivos, bocadillos y opciones para compartir.',
    'imagen': 'assets/entradas.jpeg',
    'activa': false,
    'color': AppColors.accentYellow,
  },
  {
    'nombre': 'Bebidas',
    'descripcion': 'Refrescos naturales, cocteles y cafe.',
    'imagen': 'assets/bebidas.jpeg',
    'activa': true,
    'color': AppColors.accentYellow,
  },
  {
    'nombre': 'Postres',
    'descripcion': 'Dulces artesanales, helados y reposteria.',
    'imagen': 'assets/postres.jpeg',
    'activa': false,
    'color': AppColors.accentGreen,
  },
];

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key});

  @override
  State<CategoriesScreen> createState() => CategoriesScreenState();
}

class CategoriesScreenState extends State<CategoriesScreen> {
  String busqueda = '';
  final TextEditingController buscadorController = TextEditingController();
  List<Map<String, dynamic>> categoriasFiltradas = [];

  @override
  void initState() {
    super.initState();
    filtrarCategorias();
  }

  @override
  void dispose() {
    buscadorController.dispose();
    super.dispose();
  }

  bool coincideNombre(Map<String, dynamic> categoria) {
    if (busqueda.isEmpty) return true;
    return (categoria['nombre'] as String).toLowerCase().contains(busqueda.toLowerCase());
  }

  void filtrarCategorias() {
    setState(() {
      categoriasFiltradas = categorias.where(coincideNombre).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      drawer: const AppDrawer(),
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
                    actionIcon: Icons.add,
                    controller: buscadorController,
                    onChanged: (valor) {
                      busqueda = valor;
                      filtrarCategorias();
                    },
                    onPressed: () {
                      Navigator.of(context).pushNamed(
                        AppRoutes.newcategories,
                      );
                    },
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.fromLTRB(16, 4, 16, 16),
                itemCount: categoriasFiltradas.length,
                separatorBuilder: (context, index) =>
                    const SizedBox(height: 12),
                itemBuilder: (context, index) {
                  final categoria = categoriasFiltradas[index];

                  return ListItemCard(
                    title: categoria['nombre'] as String,
                    subtitle: categoria['descripcion'] as String,
                    imageAsset: categoria['imagen'] as String,
                    isActive: categoria['activa'] as bool,
                    accentColor: categoria['color'] as Color,
                    onTap: () {},
                    onEdit: () {
                      Navigator.of(context).pushNamed(
                        AppRoutes.newcategories,
                      );
                    },
                    onDelete: () {},
                  );
                },
              ),
            ),
            const PaginationBar(
              currentPage: 1,
              totalPages: 1,
              infoText: 'Mostrando 1-10 de 1',
            ),
          ],
        ),
      ),
      bottomNavigationBar: const AppNavigatorBar(currentIndex: 1),
    );
  }
}