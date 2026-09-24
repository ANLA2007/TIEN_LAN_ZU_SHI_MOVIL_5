import 'package:flutter/material.dart';

import '../../Themes/app_colors.dart';
import '../../Widgets/app_drawer.dart';
import '../../Widgets/app_top_bar.dart';
import '../../Widgets/navigation_bar.dart';
import 'widgets/dashboard_stat_card.dart';
import 'widgets/recent_sales_card.dart';
import 'widgets/sales_by_category_card.dart';

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
                      label: 'Ventas del día',
                      value: '\$2,850.00',
                      trendText: '+12%',
                      trendLabel: 'vs. ayer',
                      sparklineColor: AppColors.primaryLight,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: DashboardStatCard(
                      icon: Icons.restaurant,
                      iconBg: AppColors.accentGreen.withOpacity(0.12),
                      iconColor: AppColors.accentGreen,
                      label: 'Platillos vendidos',
                      value: '128',
                      trendText: '+8%',
                      trendLabel: 'vs. ayer',
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
                      label: 'Promedio de ventas\npor compra',
                      value: '\$96.00',
                      trendText: '+5%',
                      trendLabel: 'vs. ayer',
                      sparklineColor: AppColors.accentYellow,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: DashboardStatCard(
                      icon: Icons.inventory_2_outlined,
                      iconBg: AppColors.primary.withOpacity(0.12),
                      iconColor: AppColors.primary,
                      label: 'Porciones en inventario',
                      value: '56',
                      footer: Row(
                        children: [
                          const Icon(Icons.info, size: 14, color: AppColors.inactive),
                          const SizedBox(width: 4),
                          Expanded(
                            child: Text(
                              '2 productos en stock bajo',
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