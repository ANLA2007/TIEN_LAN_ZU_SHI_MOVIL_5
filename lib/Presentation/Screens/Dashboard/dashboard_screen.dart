import 'package:flutter/material.dart';
import 'package:flutter_buffet/Themes/app_colors.dart';
import 'package:flutter_buffet/Presentation/Widgets/app_drawer.dart';
import 'package:flutter_buffet/Presentation/Widgets/app_top_bar.dart';
import 'package:flutter_buffet/Presentation/Widgets/navigation_bar.dart';
import 'package:flutter_buffet/Presentation/Screens/Dashboard/widgets/dashboard_stat_card.dart';
import 'package:flutter_buffet/Presentation/Screens/Dashboard/widgets/recent_sales_card.dart';
import 'package:flutter_buffet/Presentation/Screens/Dashboard/widgets/sales_by_category_card.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      drawer: const AppDrawer(),
      appBar: const AppTopBar(title: 'Tien Lan Zhu Shi'),
      body: SafeArea(
        bottom: false,
        child: ListView(
          padding: const EdgeInsets.fromLTRB(16, 14, 16, 20),
          children: [
            IntrinsicHeight(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    child: DashboardStatCard(
                      icon: Icons.storage,
                      iconBg: AppColors.primary.withOpacity(0.12),
                      iconColor: AppColors.primary,
                      label: 'Ingresos mensuales',
                      value: '\$14,250.00',
                      trendText: '+4.5%',
                      trendLabel: 'vs. mes ant.',
                      sparklineColor: AppColors.primaryLight,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: DashboardStatCard(
                      icon: Icons.restaurant,
                      iconBg: AppColors.accentGreen.withOpacity(0.12),
                      iconColor: AppColors.accentGreen,
                      label: 'Rotación inventario',
                      value: '4.2x',
                      trendText: '≥ 4.0',
                      trendLabel: 'Meta',
                      sparklineColor: AppColors.accentGreen,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            IntrinsicHeight(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    child: DashboardStatCard(
                      icon: Icons.shopping_bag_outlined,
                      iconBg: AppColors.accentYellow.withOpacity(0.15),
                      iconColor: AppColors.accentYellow,
                      label: 'Ticket promedio',
                      value: '\$112.50',
                      trendText: '+5.2%',
                      trendLabel: 'vs. base',
                      sparklineColor: AppColors.accentYellow,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: DashboardStatCard(
                      icon: Icons.inventory_2_outlined,
                      iconBg: AppColors.primary.withOpacity(0.12),
                      iconColor: AppColors.primary,
                      label: 'Días de cobertura',
                      value: '5.5 dias',
                      footer: Row(
                        children: [
                          const Icon(Icons.info, size: 14, color: AppColors.inactive),
                          const SizedBox(width: 4),
                          Expanded(
                            child: Text(
                              'Optimo (3-7 d)',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                color: AppColors.inactive,
                                fontSize: 11,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            const SalesByCategoryCard(),
            const SizedBox(height: 16),
            const RecentSalesCard(),
          ],
        ),
      ),
      bottomNavigationBar: const AppNavigatorBar(currentIndex: 0),
    );
  }
}