import 'package:flutter/material.dart';
import '../../Themes/app_colors.dart';
import '../../Widgets/app_top_bar.dart';
import 'Widgets/platillo_item_card.dart';
import '../../Widgets/navigation_bar.dart';
import '../../Widgets/pagination_bar.dart';
import '../../Widgets/search_bar.dart';
import '../../Widgets/app_drawer.dart';
import '../../app_routes.dart';

final List<Map<String, dynamic>> platillos = [
  {
    'nombre': 'Nasi Lemak Vegetariano',
    'descripcion':
        'Arroz al vapor en leche de coco con sambal, tofu marinado y vegetales frescos.',
    'imagen': 'assets/nasi_lemak.jpg',
    'precio': 75.00,
    'disponible': true,
  },
  {
    'nombre': 'Curry Laksa Vegetal',
    'descripcion':
        'Sopa tradicional de fideos con caldo de coco especiado y tofu.',
    'imagen': 'assets/curry_laksa.jpg',
    'precio': 85.00,
    'disponible': true,
  },
  {
    'nombre': 'Roti Canaï con Curry',
    'descripcion':
        'Pan plano artesanal hojaldrado acompañado de salsa curry aromática.',
    'imagen': 'assets/roti_canai.jpg',
    'precio': 60.00,
    'disponible': true,
  },
];

class PlatillosScreen extends StatefulWidget {
  const PlatillosScreen({super.key});

  @override
  State<PlatillosScreen> createState() => _PlatillosScreenState();
}

class _PlatillosScreenState extends State<PlatillosScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _query = '';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<Map<String, dynamic>> get _platillosFiltrados {
    if (_query.trim().isEmpty) return platillos;
    final q = _query.trim().toLowerCase();
    return platillos.where((p) {
      final nombre = (p['nombre'] as String).toLowerCase();
      return nombre.contains(q);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final lista = _platillosFiltrados;

    return Scaffold(
      backgroundColor: AppColors.background,
      drawer: const AppDrawer(),
      appBar: const AppTopBar(title: 'Platillos'),
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 14, 16, 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppSearchBar(
                    hintText: 'Buscar platillo...',
                    controller: _searchController,
                    onChanged: (value) {
                      setState(() => _query = value);
                    },
                    onPressed: () {
                      Navigator.of(context).pushNamed(AppRoutes.newplatillos);
                    },
                  ),
                  const SizedBox(height: 14),
                  const Text(
                    'Platillos principales',
                    style: TextStyle(
                      color: AppColors.textGrey,
                      fontWeight: FontWeight.w600,
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: lista.isEmpty
                  ? const Center(
                      child: Text(
                        'No se encontraron platillos',
                        style: TextStyle(color: AppColors.textGrey, fontSize: 13.5),
                      ),
                    )
                  : ListView.separated(
                      padding: const EdgeInsets.fromLTRB(16, 4, 16, 16),
                      itemCount: lista.length,
                      separatorBuilder: (context, index) => const SizedBox(height: 12),
                      itemBuilder: (context, index) {
                        final platillo = lista[index];

                        return PlatilloItemCard(
                          title: platillo['nombre'] as String,
                          subtitle: platillo['descripcion'] as String,
                          imageAsset: platillo['imagen'] as String,
                          price: platillo['precio'] as double,
                          available: platillo['disponible'] as bool,
                          onTap: () {},
                          onEdit: () {},
                          onDelete: () {},
                        );
                      },
                    ),
            ),
            const PaginationBar(
              currentPage: 1,
              totalPages: 7,
              infoText: 'Mostrando 1-4 de 28',
            ),
          ],
        ),
      ),
      bottomNavigationBar: const AppNavigatorBar(currentIndex: 2),
    );
  }
}