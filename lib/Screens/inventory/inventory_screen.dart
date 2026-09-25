import 'package:flutter/material.dart';
import '../../Themes/app_colors.dart';
import '../../Widgets/app_top_bar.dart';
import '../../Widgets/date_range_filter.dart';
import './Widgets/inventory_item_card.dart';
import '../../Widgets/navigation_bar.dart';
import '../../Widgets/pagination_bar.dart';
import '../../Widgets/search_bar.dart';
import './Widgets/stat_card.dart';
import '../../Widgets/app_drawer.dart';
import '../../app_routes.dart';

const int _umbralStockBajo = 5;

final List<Map<String, dynamic>> inventario = [
  {
    'nombre': 'Tofu Firme',
    'stock': 3,
    'stockDiario': 12,
    'imagen': 'assets/tofu.jpg',
    'reconsumible': true,
  },
  {
    'nombre': 'Leche de Coco',
    'stock': 30,
    'stockDiario': 30,
    'imagen': 'assets/leche_coco.jpg',
    'reconsumible': false,
  },
  {
    'nombre': 'Salsa Sambal',
    'stock': 15,
    'stockDiario': 15,
    'imagen': 'assets/salsa_sambal.jpg',
    'reconsumible': false,
  },
  {
    'nombre': 'Char Kway Teow',
    'stock': 0,
    'stockDiario': 30,
    'imagen': 'assets/char_kway_teow.jpg',
    'reconsumible': false,
  },
  {
    'nombre': 'Nasi goreng y Mee goreng',
    'stock': 8,
    'stockDiario': 25,
    'imagen': 'assets/Nasi_goreng_y_Mee_goreng.jpg',
    'reconsumible': false,
  },
];

class InventoryScreen extends StatefulWidget {
  const InventoryScreen({super.key});

  @override
  State<InventoryScreen> createState() => _InventoryScreenState();
}

class _InventoryScreenState extends State<InventoryScreen> {
  DateTime _desde = DateTime(2024, 5, 1);
  DateTime _hasta = DateTime(2024, 5, 25);

  String _formatFecha(DateTime f) =>
      '${f.day.toString().padLeft(2, '0')}/${f.month.toString().padLeft(2, '0')}/${f.year}';

  Color colorPorTipo(String tipo) {
    switch (tipo) {
      case 'TOTAL PORCIONES':
        return AppColors.active;
      case 'Stock bajo':
        return AppColors.inactive;
      case 'Sin stock':
        return AppColors.danger;
      default:
        return AppColors.textGrey;
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      drawer: const AppDrawer(),
      appBar: const AppTopBar(title: 'Inventario'),
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            Expanded(
              child: ListView(
                padding: const EdgeInsets.fromLTRB(16, 14, 16, 16),
                children: [
                  Row(
                    children: [
                      const Expanded(
                        child: StatCard(label: 'TOTAL PORCIONES', value: 56, color: AppColors.active,),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: StatCard(
                          label: 'STOCK BAJO',
                          value: 8,
                          color: AppColors.inactive,
                        ),
                      ),
                      const SizedBox(width: 10),
                      const Expanded(
                        child: StatCard(
                          label: 'SIN STOCK',
                          value: 2,
                          
                          color: AppColors.danger,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  AppSearchBar(
                    hintText: 'Buscar porcion...',
                    
                    onPressed: () {
                     Navigator.of(context).pushNamed(AppRoutes.newinventario);
                    },
                  ),
                  const SizedBox(height: 12),
                  DateRangeFilter(
                    desde: _formatFecha(_desde),
                    hasta: _formatFecha(_hasta),
                    onDesdeTap: () {},
                    onHastaTap: (){},
                    onDesdeFecha: (fecha) {
                      setState(() =>_desde = fecha);
                    },
                    onHastaFecha: (fecha) {
                      setState(() =>_hasta = fecha);
                    },
                  ),
                  const SizedBox(height: 16),
                  for (int i = 0; i < inventario.length; i++) ...[
                    _buildItem(i),
                    if (i < inventario.length - 1) const SizedBox(height: 12),
                  ],
                ],
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
      bottomNavigationBar: const AppNavigatorBar(currentIndex: 3),
    );
  }

  Widget _buildItem(int index) {
    final item = inventario[index];
    final stock = item['stock'] as int;

    return InventoryItemCard(
      title: item['nombre'] as String,
      stock: stock,
      stockDiario: item['stockDiario'] as int,
      imageAsset: item['imagen'] as String,
      reconsumible: item['reconsumible'] as bool,
      stockBajo: stock <= _umbralStockBajo,
      onReconsumibleChanged: (value) {
        setState(() => inventario[index]['reconsumible'] = value);
      },
      onEdit: () { Navigator.of(context).pushNamed(AppRoutes.newinventario);},
      onDelete: () {},
    );
  }
}