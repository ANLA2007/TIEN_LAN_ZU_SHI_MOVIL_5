import 'package:flutter/material.dart';
import 'package:flutter_buffet/Themes/app_colors.dart';

TextStyle estiloTexto(Color color, double size, FontWeight weight) {
  return TextStyle(color: color, fontSize: size, fontWeight: weight);
}

Widget iconoCircular(IconData icon) {
  return Container(
    width: 38,
    height: 38,
    alignment: Alignment.center,
    decoration: BoxDecoration(
      color: AppColors.accentYellow.withOpacity(0.18),
      shape: BoxShape.circle,
    ),
    child: Icon(icon, size: 19, color: AppColors.primary),
  );
}

class SettingsSectionHeader extends StatelessWidget {
  final IconData icon;
  final String label;

  const SettingsSectionHeader({super.key, required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10, top: 4),
      child: Row(
        children: [
          Icon(icon, size: 17, color: AppColors.primary),
          const SizedBox(width: 8),
          Text(
            label,
            style: estiloTexto(AppColors.primary, 12.5, FontWeight.w700).copyWith(letterSpacing: 0.4),
          ),
        ],
      ),
    );
  }
}

class SettingsCard extends StatelessWidget {
  final List<Widget> children;

  const SettingsCard({super.key, required this.children});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        children: [
          for (int i = 0; i < children.length; i++) ...[
            children[i],
            if (i != children.length - 1)
              const Divider(height: 1, color: AppColors.border, indent: 16, endIndent: 16),
          ],
        ],
      ),
    );
  }
}

class SettingsSwitchTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final bool value;
  final ValueChanged<bool> onChanged;

  const SettingsSwitchTile({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      child: Row(
        children: [
          iconoCircular(icon),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: estiloTexto(Colors.black, 15, FontWeight.w600)),
                const SizedBox(height: 2),
                Text(subtitle, style: estiloTexto(AppColors.textGrey, 12, FontWeight.w400)),
              ],
            ),
          ),
          Switch(
            value: value,
            onChanged: onChanged,
            activeColor: Colors.white,
            activeTrackColor: AppColors.primary,
            inactiveThumbColor: Colors.white,
            inactiveTrackColor: AppColors.border,
          ),
        ],
      ),
    );
  }
}

class SettingsNavTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String? subtitle;
  final String? trailingText;
  final Color? iconColor;
  final VoidCallback onTap;

  const SettingsNavTile({
    super.key,
    required this.icon,
    required this.title,
    this.subtitle,
    this.trailingText,
    this.iconColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        child: Row(
          children: [
            iconoCircular(icon),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: estiloTexto(iconColor ?? Colors.black, 15, FontWeight.w600)),
                  if (subtitle != null) ...[
                    const SizedBox(height: 2),
                    Text(subtitle!, style: estiloTexto(AppColors.textGrey, 12, FontWeight.w400)),
                  ],
                ],
              ),
            ),
            if (trailingText != null) ...[
              Text(trailingText!, style: estiloTexto(AppColors.primary, 12.5, FontWeight.w600)),
              const SizedBox(width: 4),
            ],
            const Icon(Icons.chevron_right, color: AppColors.textGrey, size: 20),
          ],
        ),
      ),
    );
  }
}