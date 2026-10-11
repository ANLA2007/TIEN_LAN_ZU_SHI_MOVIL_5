import 'package:flutter/material.dart';
import 'package:flutter_buffet/Themes/app_colors.dart';
import 'package:flutter_buffet/Presentation/Widgets/app_top_bar.dart';
import 'package:flutter_buffet/Presentation/Widgets/date_range_filter.dart';
import 'package:flutter_buffet/Presentation/Widgets/navigation_bar.dart';
import 'package:flutter_buffet/Presentation/Widgets/pagination_bar.dart';
import 'package:flutter_buffet/Presentation/Widgets/search_bar.dart';
import 'package:flutter_buffet/Presentation/Widgets/app_drawer.dart';
import 'package:flutter_buffet/Presentation/Screens/movimiento/Widgets/movement_stat_card.dart';
import 'package:flutter_buffet/Presentation/Screens/movimiento/Widgets/movement_item_card.dart';
import 'package:flutter_buffet/app_routes.dart';
import 'package:flutter_buffet/Presentation/Screens/movimiento/Widgets/detalle_movimiento.dart';

final List<Map<String, dynamic>> movimientos = [
  {
    'titulo': 'Tofu Firme',
    'tipo': 'Entrada',
    'fecha': '25/05/2024',
    'hora': '10:30 AM',
    'cantidad': 50,
  },
  {
    'titulo': 'Curry Laksa Vegetal',
    'tipo': 'Salida',
    'fecha': '25/05/2024',
    'hora': '01:15 PM',
    'cantidad': -25,
  },
  {
    'titulo': 'Salsa Sambal',
    'tipo': 'Merma',
    'fecha': '24/05/2024',
    'hora': '11:20 AM',
    'cantidad': -4,
  },
  {
    'titulo': 'Tempeh',
    'tipo': 'Salida',
    'fecha': '23/05/2024',
    'hora': '06:45 PM',
    'cantidad': -15,
  },
];

class MovimientoScreen extends StatefulWidget {
  const MovimientoScreen({super.key});

  @override
  State<MovimientoScreen> createState() => MovimientoScreenState();
}

class MovimientoScreenState extends State<MovimientoScreen> {
  String busqueda = '';
  final TextEditingController buscadorController = TextEditingController();
  List<Map<String, dynamic>> movimientosFiltrados = [];

  DateTime desde = DateTime(2024, 5, 1);
  DateTime hasta = DateTime(2024, 5, 25);

  @override
  void initState() {
    super.initState();
    filtrarMovimientos();
  }

  @override
  void dispose() {
    buscadorController.dispose();
    super.dispose();
  }

  bool coincideNombre(Map<String, dynamic> movimiento) {
    if (busqueda.isEmpty) return true;
    return (movimiento['titulo'] as String)
        .toLowerCase()
        .contains(busqueda.toLowerCase());
  }

  bool coincideFecha(Map<String, dynamic> movimiento) {
  final partes = (movimiento['fecha'] as String).split('/');
  final fechaMovimiento = DateTime(
    int.parse(partes[2]),
    int.parse(partes[1]),
    int.parse(partes[0]),
  );
  return !fechaMovimiento.isBefore(desde) && !fechaMovimiento.isAfter(hasta);
}

  void filtrarMovimientos() {
    setState(() {
      movimientosFiltrados = movimientos
          .where((m) =>
              coincideNombre(m) && coincideFecha(m))
          .toList();
    });
  }

  String formatFecha(DateTime f) =>
      '${f.day.toString().padLeft(2, '0')}/${f.month.toString().padLeft(2, '0')}/${f.year}';


  IconData iconoPorTipo(String tipo) {
    switch (tipo) {
      case 'Entrada':
        return Icons.arrow_downward;
      case 'Salida':
        return Icons.arrow_upward;
      case 'Merma':
        return Icons.warning_amber_rounded;
      default:
        return Icons.swap_horiz;
    }
  }

  Color colorPorTipo(String tipo) {
    switch (tipo) {
      case 'Entrada':
        return AppColors.active;
      case 'Salida':
        return AppColors.inactive;
      case 'Merma':
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
      appBar: const AppTopBar(title: 'Movimiento Inventario'),
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
                        child: MovementStatCard(
                          label: 'Entradas',
                          value: 145,
                          color: AppColors.active,
                        ),
                      ),
                      const SizedBox(width: 10),
                      const Expanded(
                        child: MovementStatCard(
                          label: 'Salidas',
                          value: -92,
                          color: AppColors.inactive,
                        ),
                      ),
                      const SizedBox(width: 10),
                      const Expanded(
                        child: MovementStatCard(
                          label: 'Mermas',
                          value: -8,
                          color: AppColors.danger,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  AppSearchBar(
                    hintText: 'Buscar platillo...',
                    actionIcon: Icons.add,
                    controller: buscadorController,
                    onChanged: (valor) {
                      busqueda = valor;
                      filtrarMovimientos();
                    },
                    onPressed: () {
                      Navigator.of(context).pushNamed(AppRoutes.newmovimiento);
                    },
                  ),
                  const SizedBox(height: 12),
                  DateRangeFilter(
                    desde: formatFecha(desde),
                    hasta: formatFecha(hasta),
                    onDesdeTap: () {},
                    onHastaTap: () {},
                    onDesdeFecha: (fecha) {
                      setState(() {
                        desde = fecha;
                        filtrarMovimientos();
                      });
                    },
                    onHastaFecha: (fecha) {
                      setState(() {
                        hasta = fecha;
                        filtrarMovimientos();
                      });
                    },
                  ),
                  const SizedBox(height: 16),
                  for (int i = 0; i < movimientosFiltrados.length; i++) ...[
                    _buildItem(movimientosFiltrados[i]),
                    if (i < movimientosFiltrados.length - 1)
                      const SizedBox(height: 12),
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
      bottomNavigationBar: const AppNavigatorBar(currentIndex: 4),
    );
  }

  Widget _buildItem(Map<String, dynamic> movimiento) {
    final tipo = movimiento['tipo'] as String;
    final icon = iconoPorTipo(tipo);
    final color = colorPorTipo(tipo);

    return MovementItemCard(
      icon: icon,
      color: color,
      title: movimiento['titulo'] as String,
      badgeText: tipo,
      fecha: movimiento['fecha'] as String,
      hora: movimiento['hora'] as String,
      cantidad: movimiento['cantidad'] as int,
      onTap: () {
        showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.white,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
        builder: (context) => DetalleMovimiento(
          movimiento: movimiento,
          icon: icon,
          color: color,
        ),
      );
      },
    );
  }
}