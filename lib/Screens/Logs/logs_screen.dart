import 'package:flutter/material.dart';
import '../../Themes/app_colors.dart';
import '../../Widgets/app_top_bar.dart';
import '../../Widgets/date_range_filter.dart';
//import '../../Widgets/navigation_bar.dart';
import '../../Widgets/pagination_bar.dart';
import '../../Widgets/search_bar.dart';
//import '../../app_routes.dart';

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
    'descripcion':
        'Se registro una merma de un platillo indicando la justificacion correspondiente.',
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

class LogsScreen extends StatelessWidget {
  const LogsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      drawer: const Drawer(),
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
                    actionLabel: 'Cargar más datos',
                    actionIcon: Icons.refresh,
                    onPressed: () {},
                  ),
                  const SizedBox(height: 12),
                  DateRangeFilter(
                    desde: '01/05/2026',
                    hasta: '25/05/2026',
                    onDesdeTap: () {},
                    onHastaTap: () {},
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.fromLTRB(16, 4, 16, 16),
                itemCount: logs.length,
                separatorBuilder: (context, index) =>
                    const SizedBox(height: 12),
                itemBuilder: (context, index) => logCard(logs[index]),
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
  
    );
  }

  Widget logCard(Map<String, dynamic> log) {
    final Color color = log['color'] as Color;

    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          logIcono(log['icono'] as IconData, color),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                logTitulo(log['titulo'] as String, log['hora'] as String),
                Text(
                  log['descripcion'] as String,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(color: AppColors.textGrey, fontSize: 12.5),
                ),
                const SizedBox(height: 6),
                logFecha(log['fecha'] as String),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget logIcono(IconData icono, Color color) {
    return Container(
      width: 56,
      height: 56,
      decoration: BoxDecoration(
        color: color.withOpacity(0.12),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Icon(icono, color: color, size: 30),
    );
  }

  Widget logTitulo(String titulo, String hora) {
    return Row(
      children: [
        Expanded(
          child: Text(
            titulo,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              color: AppColors.primary,
              fontWeight: FontWeight.w700,
              fontSize: 15,
            ),
          ),
        ),
        Text(hora, style: const TextStyle(color: AppColors.textGrey, fontSize: 11)),
      ],
    );
  }

  Widget logFecha(String fecha) {
    return Text(fecha, style: const TextStyle(color: AppColors.textGrey, fontSize: 11));
  }
}