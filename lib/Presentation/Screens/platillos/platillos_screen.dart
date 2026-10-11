import 'package:flutter/material.dart';
import 'package:flutter_buffet/Themes/app_colors.dart';
import 'package:flutter_buffet/Presentation/Widgets/app_top_bar.dart';
import 'package:flutter_buffet/Presentation/Screens/platillos/Widgets/platillo_item_card.dart';
import 'package:flutter_buffet/Presentation/Widgets/navigation_bar.dart';
import 'package:flutter_buffet/Presentation/Widgets/pagination_bar.dart';
import 'package:flutter_buffet/Presentation/Widgets/search_bar.dart';
import 'package:flutter_buffet/Presentation/Widgets/app_drawer.dart';
import 'package:flutter_buffet/app_routes.dart';
import 'package:flutter_buffet/Presentation/Screens/platillos/Widgets/detalle_platillo.dart';
import 'package:flutter_buffet/Services/user_session.dart';

final List<Map<String, dynamic>> platillos = [
  {
    'nombre': 'Nasi Lemak Vegetariano',
    'descripcion':'Arroz al vapor en leche de coco con sambal, tofu marinado y vegetales frescos.',
    'imagen': 'assets/nasi_lemak.jpg',
    'precio': 75.00,
    'disponible': true,
    'reconsumible': true,
  },
  {
    'nombre': 'Curry Laksa Vegetal',
    'descripcion':'Sopa tradicional de fideos con caldo de coco especiado y tofu.',
    'imagen': 'assets/curry_laksa.jpg',
    'precio': 85.00,
    'disponible': true,
    'reconsumible': false,
  },
  {
    'nombre': 'Roti Canaï con Curry',
    'descripcion':'Pan plano artesanal hojaldrado acompañado de salsa curry aromática.',
    'imagen': 'assets/roti_canai.jpg',
    'precio': 60.00,
    'disponible': true,
    'reconsumible': true,
  },
  {
    'nombre': 'Mee Goreng Vegetariano',
    'descripcion':'Fideos fritos con salsa de soja, tofu, vegetales y especias.',
    'imagen': 'assets/mee_goreng.jpg',
    'precio': 70.00,
    'disponible': true,
    'reconsumible': false,
  },
  {
    'nombre': 'Char Kway Teow Vegetariano',
    'descripcion':'Fideos planos salteados con tofu, brotes de soja y salsa de soja oscura.',
    'imagen': 'assets/Char_Kway_Teow.jpg',
    'precio': 80.00,
    'disponible': false,
    'reconsumible': true,
  },
];

class PlatillosScreen extends StatefulWidget {
  const PlatillosScreen({super.key});

  @override
  State<PlatillosScreen> createState() => _PlatillosScreenState();
}

class _PlatillosScreenState extends State<PlatillosScreen> {
  String busqueda = '';
  final TextEditingController buscadorController = TextEditingController();
  List<Map<String, dynamic>> platillosFiltrados = [];

  @override
  void initState() {
    super.initState();
    filtrarPlatillos();
  }

  @override
  void dispose() {
    buscadorController.dispose();
    super.dispose();
  }

  bool coincideNombre(Map<String, dynamic> platillo) {
    if (busqueda.isEmpty) return true;
    return (platillo['nombre'] as String).toLowerCase().contains(busqueda.toLowerCase());
  }

  void filtrarPlatillos() {
    setState(() {
      platillosFiltrados = platillos.where(coincideNombre).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
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
                    actionIcon: Icons.add,
                    controller: buscadorController,
                    showAction: UserSession.esAdministrador, // <-- nueva
                    onChanged: (value) {
                      busqueda = value;
                      filtrarPlatillos();
                    },
                    onPressed: () {
                      Navigator.of(context).pushNamed(AppRoutes.newplatillos);
                    },
                  ),
                  const SizedBox(height: 14),
                ],
              ),
            ),
            Expanded(
              child: ListView.separated(
                      padding: const EdgeInsets.fromLTRB(16, 4, 16, 16),
                      itemCount: platillosFiltrados.length,
                      separatorBuilder: (context, index) => const SizedBox(height: 12),
                      itemBuilder: (context, index) {
                        final platillo = platillosFiltrados[index];

                        return PlatilloItemCard(
                          title: platillo['nombre'] as String,
                          subtitle: platillo['descripcion'] as String,
                          imageAsset: platillo['imagen'] as String,
                          price: platillo['precio'] as double,
                          available: platillo['disponible'] as bool,
                          canEdit: UserSession.esAdministrador,   // <-- nueva
                          canDelete: UserSession.esAdministrador, // <-- nueva
                          onTap: () {
                            showModalBottomSheet(
                              context: context,
                              isScrollControlled: true,
                              backgroundColor: Colors.white,
                              builder: (context) => DetallePlatillo(platillo: platillo),
                            );
                          },
                          onEdit: () {
                            Navigator.of(context).pushNamed(AppRoutes.newplatillos);
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
      bottomNavigationBar: const AppNavigatorBar(currentIndex: 2),
    );
  }
}