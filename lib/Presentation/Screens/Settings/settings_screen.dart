import 'package:flutter/material.dart';
import 'package:flutter_buffet/Themes/app_colors.dart';
import 'package:flutter_buffet/Presentation/Widgets/app_top_bar.dart';
import 'package:flutter_buffet/Presentation/Widgets/app_drawer.dart';
import 'package:flutter_buffet/Presentation/Widgets/navigation_bar.dart';
import 'package:flutter_buffet/Presentation/Screens/Settings/Widgets/account_dialog.dart';
import 'package:flutter_buffet/Presentation/Screens/Settings/Widgets/profile_dialog.dart';
import 'package:flutter_buffet/Presentation/Screens/Settings/Widgets/settings_components.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => SettingsScreenState();
}

class SettingsScreenState extends State<SettingsScreen> {
  final String nombreUsuario = 'Roberta Baltodano';
  final String correoUsuario = 'roberta.baltodano@tlshz.com';
  final String rolUsuario = 'Admin';
  final String telefonoUsuario = '+505 8888 1234';
  final bool usuarioActivo = true;

  bool notificacionesActivas = true;
  bool sonidosActivos = false;
  bool modoOscuro = false;
  String idioma = 'Español';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      drawer: const AppDrawer(),
      appBar: const AppTopBar(title: 'Configuración'),
      body: SafeArea(
        bottom: false,
        child: ListView(
          padding: const EdgeInsets.fromLTRB(16, 14, 16, 24),
          children: [
            const SettingsSectionHeader(
              icon: Icons.person_outline,
              label: 'Cuenta',
            ),
            InkWell(
              borderRadius: BorderRadius.circular(18),
              onTap: () => ProfileDialog.mostrar(
                context,
                nombre: nombreUsuario,
                correo: correoUsuario,
                rol: rolUsuario,
                telefono: telefonoUsuario,
                iniciales: 'RB',
                activo: usuarioActivo,
              ),
              child: Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: AppColors.cardBackground,
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(
                    color: AppColors.border,
                  ),
                ),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 26,
                      backgroundColor: AppColors.primary,
                      child: const Text(
                        'RB',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 17,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Flexible(
                                child: Text(
                                  nombreUsuario,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 16.5,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 8),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 9,
                                  vertical: 2,
                                ),
                                decoration: BoxDecoration(
                                  color: AppColors.accentYellow.withOpacity(0.25),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Text(
                                  rolUsuario,
                                  style: const TextStyle(
                                    color: AppColors.primary,
                                    fontSize: 11,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 3),
                          Text(
                            correoUsuario,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              color: AppColors.textGrey,
                              fontSize: 13,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Icon(
                      Icons.chevron_right,
                      color: AppColors.textGrey,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 26),
            const SettingsSectionHeader(
              icon: Icons.tune,
              label: 'Preferencias',
            ),
            SettingsCard(
              children: [
                SettingsSwitchTile(
                  icon: Icons.notifications_none,
                  title: 'Notificaciones',
                  subtitle: 'Recibe alertas y novedades importantes',
                  value: notificacionesActivas,
                  onChanged: (v) =>
                      setState(() => notificacionesActivas = v),
                ),
                SettingsSwitchTile(
                  icon: Icons.volume_up_outlined,
                  title: 'Sonidos',
                  subtitle: 'Activa o desactiva los sonidos de la app',
                  value: sonidosActivos,
                  onChanged: (v) => setState(() => sonidosActivos = v),
                ),
                SettingsNavTile(
                  icon: Icons.language,
                  title: 'Idioma',
                  valorDerecha: idioma,
                  onTap: () async {
                    final seleccionado =
                        await LanguageDialog.mostrar(context, idioma);

                    if (seleccionado != null && seleccionado != idioma) {
                      setState(() => idioma = seleccionado);
                    }
                  },
                ),
                SettingsSwitchTile(
                  icon: Icons.dark_mode_outlined,
                  title: 'Modo oscuro',
                  subtitle: 'Cambia la apariencia de la app',
                  value: modoOscuro,
                  onChanged: (v) => setState(() => modoOscuro = v),
                ),
              ],
            ),
            const SizedBox(height: 26),
            const SettingsSectionHeader(
              icon: Icons.shield_outlined,
              label: 'Seguridad',
            ),
            SettingsCard(
              children: [
                SettingsNavTile(
                  icon: Icons.lock_outline,
                  title: 'Cambiar contraseña',
                  subtitle: 'Actualiza tu contraseña periódicamente',
                  onTap: () {},
                ),
                SettingsNavTile(
                  icon: Icons.verified_user_outlined,
                  title: 'Dispositivos y sesiones',
                  subtitle: 'Revisa dónde has iniciado sesión',
                  valorDerecha: '1 activo',
                  onTap: () {},
                ),
              ],
            ),
            const SizedBox(height: 14),
            SettingsCard(
              children: [
                SettingsNavTile(
                  icon: Icons.logout,
                  title: 'Cerrar sesión',
                  subtitle: 'Finalizar sesión actual',
                  iconColor: AppColors.danger,
                  onTap: () => Navigator.of(context).pushNamed('/login'),
                ),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: const AppNavigatorBar(currentIndex: null),
    );
  }
}