import 'package:flutter/material.dart';

import '../Themes/app_colors.dart';

class AppTopBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  const AppTopBar({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.primary,
      foregroundColor: Colors.white,
      elevation: 0,
      centerTitle: true,
      leading: Builder(
        builder: (context) => IconButton(
          icon: const Icon(Icons.menu, color: Colors.white),
          onPressed: () => Scaffold.of(context).openDrawer(),
        ),
      ),
      title: Text(title, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 20)),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}