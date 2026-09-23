import 'package:flutter/material.dart';
import '../../Themes/app_colors.dart';
import '../../Widgets/app_top_bar.dart';
import '../../Widgets/date_range_filter.dart';
import 'Widgets/log_card.dart';
import '../../Widgets/navigation_bar.dart';
import '../../Widgets/pagination_bar.dart';
import '../../Widgets/search_bar.dart';
import '../../app_routes.dart';
import '../../Widgets/app_drawer.dart';

final List<Map<String, dynamic>> logs = [
  {
    'titulo': 'Actualizacion de inventario',
    'descripcion': 'Se actualizo la cantidad disponible de un platillo.',
    'icono': Icons.inventory_2_outlined,
    'hora': '10:45 AM',
    'fecha': '25/05/2024',
    'esAlerta': false,
    'color': AppColors.accentGreen,
  },
  {
    'titulo': 'Entrada de inventario',
    'descripcion': 'Se registro una entrada de platillos al inventario.',
    'icono': Icons.move_to_inbox_outlined,
    'hora': '09:30 AM',
    'fecha': '25/05/2024',
    'esAlerta': false,
    'color': AppColors.accentGreen,
  },
  {
    'titulo': 'Registro de merma',
    'descripcion':'Se registro una merma de un platillo indicando la justificacion correspondiente.',
    'icono': Icons.warning_amber_rounded,
    'hora': '11:20 AM',
    'fecha': '25/05/2024',
    'esAlerta': true,
    'color': AppColors.accentRed,
  },
  {
    'titulo': 'Modificacion de platillo',
    'descripcion': 'Se actualizo la informacion de un platillo del buffet.',
    'icono': Icons.edit_outlined,
    'hora': '04:50 PM',
    'fecha': '24/05/2024',
    'esAlerta': false,
    'color': AppColors.accentYellow,
  },
  {
    'titulo': 'Eliminacion de platillo',
    'descripcion': 'Se elimino un platillo del catalogo.',
    'icono': Icons.delete_outline,
    'hora': '02:10 PM',
    'fecha': '24/05/2024',
    'esAlerta': true,
    'color': AppColors.accentRed,
  },
  {
    'titulo': 'Entrada de inventario',
    'descripcion': 'Se registro una entrada de platillos al inventario.',
    'icono': Icons.move_to_inbox_outlined,
    'hora': '08:05 AM',
    'fecha': '23/05/2024',
    'esAlerta': false,
    'color': AppColors.accentGreen,
  },
];

class LogsScreen extends StatefulWidget {
  const LogsScreen({super.key});

  @override
  State<LogsScreen> createState() => LogsScreenState();
}

class LogsScreenState extends State<LogsScreen> {
  String fechaDesde = '01/05/2024';
  String fechaHasta = '25/05/2024';
  String busqueda = '';
  final TextEditingController buscadorController = TextEditingController();
  List<Map<String, dynamic>> logsFiltrados = [];

  @override
  void initState() {
    super.initState();
    filtrarLogs();
  }

  @override
  void dispose() {
    buscadorController.dispose();
    super.dispose();
  }

  DateTime aFecha(String t) {
    var p = t.split('/');
    return DateTime(int.parse(p[2]), int.parse(p[1]), int.parse(p[0]));
  }

  bool enRango(String fecha) {
    DateTime f = aFecha(fecha);
    DateTime desde = aFecha(fechaDesde);
    DateTime hasta = aFecha(fechaHasta);
    return !f.isBefore(desde) && !f.isAfter(hasta);
  }

  bool coincideNombre(Map<String, dynamic> log) {
    if (busqueda.isEmpty) return true;
    return log['titulo'].toLowerCase().contains(busqueda.toLowerCase());
  }

  void filtrarLogs() {
    setState(() {
      logsFiltrados = logs
          .where((log) => enRango(log['fecha']) && coincideNombre(log))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      drawer: const AppDrawer(),
      appBar: const AppTopBar(title: 'Logs'),
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
                    hintText: 'Buscar en logs...',
                    actionIcon: Icons.refresh,
                    controller: buscadorController,
                    onChanged: (valor) {
                      busqueda = valor;
                      filtrarLogs();
                    },
                    onPressed: filtrarLogs,
                  ),
                  const SizedBox(height: 12),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Expanded(
                        child: DateRangeFilter(
                          desde: fechaDesde,
                          hasta: fechaHasta,
                          onDesdeTap: () {},
                          onHastaTap: () {},
                          onDesdeFecha: (fecha) => setState(
                              () => fechaDesde = '${fecha.day}/${fecha.month}/${fecha.year}'),
                          onHastaFecha: (fecha) => setState(
                              () => fechaHasta = '${fecha.day}/${fecha.month}/${fecha.year}'),
                        ),
                      ),
                      const SizedBox(width: 10),
                      InkWell(
                        borderRadius: BorderRadius.circular(12),
                        onTap: filtrarLogs,
                        child: Container(
                          height: 44,
                          width: 44,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: AppColors.primary,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Icon(
                            Icons.filter_alt_outlined,
                            color: Colors.white,
                            size: 20,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.fromLTRB(16, 4, 16, 16),
                itemCount: logsFiltrados.length,
                separatorBuilder: (context, index) =>
                    const SizedBox(height: 12),
                itemBuilder: (context, index) => LogCard(log: logsFiltrados[index]),
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
      bottomNavigationBar: const AppNavigatorBar(currentIndex: null),
    );
  }
}