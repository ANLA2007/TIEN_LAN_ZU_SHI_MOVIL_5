import 'package:flutter/material.dart';
import '../../Themes/app_colors.dart';
import '../../Widgets/app_top_bar.dart';
import '../../Widgets/date_range_filter.dart';
import '../../Widgets/navigation_bar.dart';
import '../../Widgets/pagination_bar.dart';
import '../../Widgets/search_bar.dart';
import '../../Widgets/app_drawer.dart';
import 'Widgets/report_card.dart';
import 'Widgets/period_summary_card.dart';

final List<Map<String, dynamic>> ventas = [
  {
    'venta': '#VTA-150',
    'cliente': 'Roberta Baltodano',
    'concepto': 'Pato Pekín',
    'subtotal': 'C\$ 225.00',
    'totalLinea': 'C\$ 258.75',
    'fecha': '25/05/2026',
  },
  {
    'venta': '#VTA-149',
    'cliente': 'Alexa Lara',
    'concepto': 'Nasi Lemak',
    'subtotal': 'C\$ 170.00',
    'totalLinea': 'C\$ 195.50',
    'fecha': '24/05/2026',
  },
  {
    'venta': '#VTA-148',
    'cliente': 'Dulce Velasquez',
    'concepto': 'Dumplings de Cerdo',
    'subtotal': 'C\$ 270.00',
    'totalLinea': 'C\$ 310.50',
    'fecha': '23/05/2026',
  },
  {
    'venta': '#VTA-147',
    'cliente': 'Anahi Lopez',
    'concepto': 'Laksa de Curry',
    'subtotal': 'C\$ 180.00',
    'totalLinea': 'C\$ 207.00',
    'fecha': '22/05/2026',
  },
  {
    'venta': '#VTA-146',
    'cliente': 'Lucía Gómez',
    'concepto': 'Arroz Frito Yangzhou',
    'subtotal': 'C\$ 320.00',
    'totalLinea': 'C\$ 368.00',
    'fecha': '21/05/2026',
  },
  {
    'venta': '#VTA-145',
    'cliente': 'Carlos Torres',
    'concepto': 'Mee Goreng',
    'subtotal': 'C\$ 140.00',
    'totalLinea': 'C\$ 161.00',
    'fecha': '20/05/2026',
  },
  {
    'venta': '#VTA-144',
    'cliente': 'Brandon Soza',
    'concepto': 'Cerdo Agridulce',
    'subtotal': 'C\$ 200.00',
    'totalLinea': 'C\$ 230.00',
    'fecha': '19/05/2026',
  },
  {
    'venta': '#VTA-143',
    'cliente': 'Carolina Ramirez',
    'concepto': 'Satay de Pollo',
    'subtotal': 'C\$ 120.00',
    'totalLinea': 'C\$ 138.00',
    'fecha': '18/05/2026',
  },
  {
    'venta': '#VTA-142',
    'cliente': 'Luz Gonzalez',
    'concepto': 'Rendang de Res',
    'subtotal': 'C\$ 260.00',
    'totalLinea': 'C\$ 299.00',
    'fecha': '17/05/2026',
  },
  {
    'venta': '#VTA-141',
    'cliente': 'Luis Martínez',
    'concepto': 'Roti Canai',
    'subtotal': 'C\$ 150.00',
    'totalLinea': 'C\$ 172.50',
    'fecha': '16/05/2026',
  },
];

class ReportsScreen extends StatefulWidget {
  const ReportsScreen({super.key});

  @override
  State<ReportsScreen> createState() => ReportsScreenState();
}

class ReportsScreenState extends State<ReportsScreen> {
  String busqueda = '';
  final TextEditingController buscadorController = TextEditingController();
  List<Map<String, dynamic>> ventasFiltradas = [];

  DateTime desde = DateTime(2026, 5, 1);
  DateTime hasta = DateTime(2026, 5, 25);

  @override
  void initState() {
    super.initState();
    filtrarVentas();
  }

  @override
  void dispose() {
    buscadorController.dispose();
    super.dispose();
  }

  bool coincideNombre(Map<String, dynamic> venta) {
    if (busqueda.isEmpty) return true;

    final texto = busqueda.toLowerCase();

    return (venta['venta'] as String).toLowerCase().contains(texto) ||
        (venta['cliente'] as String).toLowerCase().contains(texto) ||
        (venta['concepto'] as String).toLowerCase().contains(texto);
  }

  bool coincideFecha(Map<String, dynamic> venta) {
    final partes = (venta['fecha'] as String).split('/');

    final fechaVenta = DateTime(
      int.parse(partes[2]),
      int.parse(partes[1]),
      int.parse(partes[0]),
    );

    return !fechaVenta.isBefore(desde) && !fechaVenta.isAfter(hasta);
  }

  void filtrarVentas() {
    setState(() {
      ventasFiltradas = ventas
          .where((venta) => coincideNombre(venta) && coincideFecha(venta))
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
      appBar: const AppTopBar(title: 'Reporte de ventas'),
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
                  Row(
                    children: [
                      Expanded(
                        child: AppSearchBar(
                          hintText: 'Buscar por venta o platillo...',
                          actionIcon: Icons.file_download_outlined,
                          controller: buscadorController,
                          onChanged: (valor) {
                            busqueda = valor;
                            filtrarVentas();
                          },
                          onPressed: () {},
                        ),
                      ),
                      const SizedBox(width: 8),
                      InkWell(
                        borderRadius: BorderRadius.circular(14),
                        onTap: () {},
                        child: Container(
                          height: 46,
                          width: 48,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: AppColors.primary,
                            borderRadius: BorderRadius.circular(14),
                          ),
                          child: const Icon(
                            Icons.print_outlined,
                            color: Colors.white,
                            size: 20,
                          ),
                        ),
                      ),
                    ],
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
                        filtrarVentas();
                      });
                    },
                    onHastaFecha: (fecha) {
                      setState(() {
                        hasta = fecha;
                        filtrarVentas();
                      });
                    },
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.fromLTRB(16, 4, 16, 16),
                children: [
                  const ResumenDesplegable(),
                  const SizedBox(height: 12),
                  for (int i = 0; i < ventasFiltradas.length; i++) ...[
                    VentaCard(venta: ventasFiltradas[i]),
                    if (i < ventasFiltradas.length - 1)
                      const SizedBox(height: 12),
                  ],
                ],
              ),
            ),
            const PaginationBar(
              currentPage: 1,
              totalPages: 3,
              infoText: 'Mostrando 1-10 de 30 ',
            ),
          ],
        ),
      ),
      bottomNavigationBar: const AppNavigatorBar(currentIndex: 5),
    );
  }
}