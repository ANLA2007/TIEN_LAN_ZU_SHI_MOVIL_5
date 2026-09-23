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
  String busqueda = '';
  final TextEditingController buscadorController = TextEditingController();
  List<Map<String, dynamic>> logsFiltrados = [];

  DateTime desde = DateTime(2024, 5, 1);
  DateTime hasta = DateTime(2024, 5, 25);

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

  bool coincideNombre(Map<String, dynamic> log) {
    if (busqueda.isEmpty) return true;
    return (log['titulo'] as String)
        .toLowerCase()
        .contains(busqueda.toLowerCase());
  }

  bool coincideFecha(Map<String, dynamic> log) {
    final partes = (log['fecha'] as String).split('/');
    final fechaLog = DateTime(
      int.parse(partes[2]),
      int.parse(partes[1]),
      int.parse(partes[0]),
    );
    return !fechaLog.isBefore(desde) && !fechaLog.isAfter(hasta);
  }

  void filtrarLogs() {
    setState(() {
      logsFiltrados = logs
          .where((log) => coincideNombre(log) && coincideFecha(log))
          .toList();
    });
  }

  String formatFecha(DateTime f) =>
      '${f.day.toString().padLeft(2, '0')}/${f.month.toString().padLeft(2, '0')}/${f.year}';

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
                  DateRangeFilter(
                    desde: formatFecha(desde),
                    hasta: formatFecha(hasta),
                    onDesdeTap: () {},
                    onHastaTap: () {},
                    onDesdeFecha: (fecha) {
                      setState(() {
                        desde = fecha;
                        filtrarLogs();
                      });
                    },
                    onHastaFecha: (fecha) {
                      setState(() {
                        hasta = fecha;
                        filtrarLogs();
                      });
                    },
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