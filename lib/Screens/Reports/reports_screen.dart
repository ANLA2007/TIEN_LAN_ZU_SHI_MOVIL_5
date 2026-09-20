import 'package:flutter/material.dart';
import '../../Themes/app_colors.dart';
import '../../Widgets/app_top_bar.dart';
import '../../Widgets/date_range_filter.dart';
import '../../Widgets/navigation_bar.dart';
import '../../Widgets/pagination_bar.dart';
import '../../Widgets/search_bar.dart';
import '../../Widgets/app_drawer.dart';

final List<Map<String, dynamic>> ventas = [
  {
    'venta': '#VTA-150',
    'cliente': 'María López',
    'concepto': 'Pato Pekín',
    'subtotal': 'C\$ 225.00',
    'totalLinea': 'C\$ 258.75',
  },
  {
    'venta': '#VTA-149',
    'cliente': 'Carlos Pérez',
    'concepto': 'Nasi Lemak',
    'subtotal': 'C\$ 170.00',
    'totalLinea': 'C\$ 195.50',
  },
  {
    'venta': '#VTA-148',
    'cliente': 'Ana Torres',
    'concepto': 'Dumplings de Cerdo',
    'subtotal': 'C\$ 270.00',
    'totalLinea': 'C\$ 310.50',
  },
  {
    'venta': '#VTA-147',
    'cliente': 'Consumidor final',
    'concepto': 'Laksa de Curry',
    'subtotal': 'C\$ 180.00',
    'totalLinea': 'C\$ 207.00',
  },
  {
    'venta': '#VTA-146',
    'cliente': 'Lucía Gómez',
    'concepto': 'Arroz Frito Yangzhou',
    'subtotal': 'C\$ 320.00',
    'totalLinea': 'C\$ 368.00',
  },
  {
    'venta': '#VTA-145',
    'cliente': 'Consumidor final',
    'concepto': 'Mee Goreng',
    'subtotal': 'C\$ 140.00',
    'totalLinea': 'C\$ 161.00',
  },
  {
    'venta': '#VTA-144',
    'cliente': 'Roberta Aguilar',
    'concepto': 'Cerdo Agridulce',
    'subtotal': 'C\$ 200.00',
    'totalLinea': 'C\$ 230.00',
  },
  {
    'venta': '#VTA-143',
    'cliente': 'Consumidor final',
    'concepto': 'Satay de Pollo',
    'subtotal': 'C\$ 120.00',
    'totalLinea': 'C\$ 138.00',
  },
  {
    'venta': '#VTA-142',
    'cliente': 'Dulce Mora',
    'concepto': 'Rendang de Res',
    'subtotal': 'C\$ 260.00',
    'totalLinea': 'C\$ 299.00',
  },
  {
    'venta': '#VTA-141',
    'cliente': 'Luis Martínez',
    'concepto': 'Roti Canai',
    'subtotal': 'C\$ 150.00',
    'totalLinea': 'C\$ 172.50',
  },
];

class ReportsScreen extends StatelessWidget {
  const ReportsScreen({super.key});

  static const List<double> anchosColumnas = [76, 112, 140, 88, 100, 84];

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
                          actionLabel: 'Exportar',
                          actionIcon: Icons.file_download_outlined,
                          onPressed: () {},
                        ),
                      ),
                      const SizedBox(width: 8),
                      const BotonImprimir(),
                    ],
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
                itemCount: 2,
                separatorBuilder: (context, index) =>
                    const SizedBox(height: 16),
                itemBuilder: (context, index) {
                  if (index == 0) {
                    return const TablaVentas();
                  }

                  return const ResumenPeriodo();
                },
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

class BotonImprimir extends StatelessWidget {
  const BotonImprimir({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
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
        child: const Icon(Icons.print_outlined, color: Colors.white, size: 20),
      ),
    );
  }
}

class TablaVentas extends StatelessWidget {
  const TablaVentas({super.key});

  @override
  Widget build(BuildContext context) {
    final double anchoTabla =
        ReportsScreen.anchosColumnas.reduce((a, b) => a + b) + 20;

    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border),
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: SizedBox(
          width: anchoTabla,
          child: Column(
            children: [
              const EncabezadoTabla(),
              for (int posicion = 0; posicion < ventas.length; posicion++) ...[
                FilaVenta(venta: ventas[posicion]),
                if (posicion < ventas.length - 1)
                  const Divider(height: 1, color: AppColors.border),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class EncabezadoTabla extends StatelessWidget {
  const EncabezadoTabla({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.primary,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
      child: Row(
        children: [
          SizedBox(
            width: ReportsScreen.anchosColumnas[0],
            child: const TextoEncabezado(texto: 'Venta'),
          ),
          SizedBox(
            width: ReportsScreen.anchosColumnas[1],
            child: const TextoEncabezado(texto: 'Cliente'),
          ),
          SizedBox(
            width: ReportsScreen.anchosColumnas[2],
            child: const TextoEncabezado(texto: 'Concepto'),
          ),
          SizedBox(
            width: ReportsScreen.anchosColumnas[3],
            child: const TextoEncabezado(texto: 'Subtotal'),
          ),
          SizedBox(
            width: ReportsScreen.anchosColumnas[4],
            child: const TextoEncabezado(texto: 'Total de línea'),
          ),
          SizedBox(width: ReportsScreen.anchosColumnas[5]),
        ],
      ),
    );
  }
}

class TextoEncabezado extends StatelessWidget {
  final String texto;

  const TextoEncabezado({super.key, required this.texto});

  @override
  Widget build(BuildContext context) {
    return Text(
      texto,
      style: const TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.w600,
        fontSize: 11.5,
      ),
    );
  }
}

class FilaVenta extends StatelessWidget {
  final Map<String, dynamic> venta;

  const FilaVenta({super.key, required this.venta});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
      child: Row(
        children: [
          SizedBox(
            width: ReportsScreen.anchosColumnas[0],
            child: Text(
              venta['venta'] as String,
              style: const TextStyle(
                color: AppColors.primary,
                fontWeight: FontWeight.w700,
                fontSize: 12,
              ),
            ),
          ),
          SizedBox(
            width: ReportsScreen.anchosColumnas[1],
            child: Text(
              venta['cliente'] as String,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(color: AppColors.textTitle, fontSize: 12),
            ),
          ),
          SizedBox(
            width: ReportsScreen.anchosColumnas[2],
            child: Text(
              venta['concepto'] as String,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(color: AppColors.textTitle, fontSize: 12),
            ),
          ),
          SizedBox(
            width: ReportsScreen.anchosColumnas[3],
            child: Text(
              venta['subtotal'] as String,
              style: const TextStyle(color: AppColors.textGrey, fontSize: 12),
            ),
          ),
          SizedBox(
            width: ReportsScreen.anchosColumnas[4],
            child: Text(
              venta['totalLinea'] as String,
              style: const TextStyle(
                color: AppColors.textTitle,
                fontWeight: FontWeight.w700,
                fontSize: 12,
              ),
            ),
          ),
          SizedBox(
            width: ReportsScreen.anchosColumnas[5],
            child: const Align(
              alignment: Alignment.centerLeft,
              child: ChipVerDetalle(),
            ),
          ),
        ],
      ),
    );
  }
}

class ChipVerDetalle extends StatelessWidget {
  const ChipVerDetalle({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(20),
      onTap: () {},
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
        decoration: BoxDecoration(
          color: AppColors.primary.withOpacity(0.1),
          borderRadius: BorderRadius.circular(20),
        ),
        child: const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Ver detalle',
              style: TextStyle(
                color: AppColors.primary,
                fontSize: 10,
                fontWeight: FontWeight.w600,
              ),
            ),
            Icon(Icons.chevron_right, size: 12, color: AppColors.primary),
          ],
        ),
      ),
    );
  }
}

class ResumenPeriodo extends StatelessWidget {
  const ResumenPeriodo({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.calendar_month_outlined, color: AppColors.primary, size: 20),
              SizedBox(width: 8),
              Text(
                'Resumen del período',
                style: TextStyle(
                  color: AppColors.textTitle,
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          SizedBox(height: 14),
          Row(
            children: [
              Expanded(child: DatoResumen(etiqueta: 'Subtotal', monto: 'C\$ 2,035.00')),
              Expanded(child: DatoResumen(etiqueta: 'Descuentos', monto: 'C\$ 0.00')),
            ],
          ),
          SizedBox(height: 14),
          CajaTotal(monto: 'C\$ 2,340.25'),
          SizedBox(height: 12),
          Text(
            'Reporte generado el 25/05/2026 a las 11:45 a.m.',
            style: TextStyle(color: AppColors.textGrey, fontSize: 11),
          ),
        ],
      ),
    );
  }
}

class DatoResumen extends StatelessWidget {
  final String etiqueta;
  final String monto;

  const DatoResumen({super.key, required this.etiqueta, required this.monto});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(etiqueta, style: const TextStyle(color: AppColors.textGrey, fontSize: 12.5)),
        const SizedBox(height: 4),
        Text(
          monto,
          style: const TextStyle(
            color: AppColors.primary,
            fontSize: 17,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }
}

class CajaTotal extends StatelessWidget {
  final String monto;

  const CajaTotal({super.key, required this.monto});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 14),
      decoration: BoxDecoration(
        color: AppColors.softBackground,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          const Text(
            'Total en ventas',
            style: TextStyle(
              color: AppColors.textTitle,
              fontSize: 12.5,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            monto,
            style: const TextStyle(
              color: AppColors.primary,
              fontSize: 22,
              fontWeight: FontWeight.w800,
            ),
          ),
        ],
      ),
    );
  }
}