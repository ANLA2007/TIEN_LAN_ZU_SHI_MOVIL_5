import 'package:flutter/material.dart';
import 'package:flutter_buffet/Services/user_session.dart';
import 'package:flutter_buffet/Themes/app_colors.dart';
import 'package:flutter_buffet/app_routes.dart';
import 'package:flutter_buffet/Presentation/Screens/Login/Widgets/login_form_panel.dart';
import 'package:flutter_buffet/Presentation/Screens/Login/Widgets/decorative_bubble.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController usuarioController = TextEditingController();
  final TextEditingController contrasenaController = TextEditingController();

  @override
  void dispose() {
    usuarioController.dispose();
    contrasenaController.dispose();
    super.dispose();
  }

  void _iniciarSesion() {
    final usuario = usuarioController.text.trim().toLowerCase();
    final contrasena = contrasenaController.text;

    if (usuario == 'administrador' &&
        contrasena == UserSession.claveAdministrador) {
      UserSession.rol = 'administrador';
    } else if (usuario != 'administrador' &&
        contrasena == UserSession.claveCajero) {
      UserSession.rol = 'cajero';
    } else {
      return;
    }

    Navigator.of(context).pushReplacementNamed(AppRoutes.home);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: Stack(
        clipBehavior: Clip.none,
        children: [
          const BubblesBackground(),
          SafeArea(
            child: Column(
              children: [
                const SizedBox(height: 32),
                const AppLogo(),
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 32,
                    ),
                    child: LoginFormPanel(
                      usuarioController: usuarioController,
                      contrasenaController: contrasenaController,
                      onLoginPressed: _iniciarSesion,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}