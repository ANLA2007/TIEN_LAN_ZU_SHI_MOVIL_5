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
                        child: StatCard(label: 'Total Porciones', value: 56),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: StatCard(
                          label: 'Stock bajo',
                          value: 8,
                          dotColor: AppColors.danger,
                          valueColor: AppColors.danger,
                          backgroundColor: AppColors.danger.withOpacity(0.06),
                        ),
                      ),
                      const SizedBox(width: 10),
                      const Expanded(
                        child: StatCard(
                          label: 'Sin stock',
                          value: 2,
                          valueColor: AppColors.textGrey,
                          backgroundColor: AppColors.softBackground,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  AppSearchBar(
                    hintText: 'Buscar porcion...',
                    actionLabel: 'Nuevo',
                    onPressed: () {
                      // Navigator.of(context).pushNamed(AppRoutes.newinventario);
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
              totalPages: 3,
              infoText: 'Mostrando 1-10 de 30',
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
      onView: () {},
      onEdit: () {},
      onDelete: () {},
    );
  }
}