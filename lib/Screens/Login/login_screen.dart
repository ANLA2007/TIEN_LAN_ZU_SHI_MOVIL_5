import 'package:flutter/material.dart';
import 'package:flutter_buffet/Services/user_session.dart';
import '../../Themes/app_colors.dart';
import '../../app_routes.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController usuarioController = TextEditingController();
  final TextEditingController contrasenaController = TextEditingController();

  bool ocultarContrasena = true;
  bool recordarSesion = true;

  @override
  void dispose() {
    usuarioController.dispose();
    contrasenaController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: Stack(
        clipBehavior: Clip.none,
        children: [
          burbuja(220, top: -60, right: -60),
          burbuja(140, top: 260, left: -50),
          burbuja(260, bottom: -80, right: -70),
          burbuja(120, bottom: 160, left: -40),
          SafeArea(
            child: Column(
              children: [
                const SizedBox(height: 32),
                Image.asset(
                  'assets/logo.png',
                  height: 140,
                  errorBuilder: (context, error, stackTrace) => const Icon(Icons.eco_outlined, color: AppColors.primary, size: 72),
                ),
                Expanded(
                  child: Center(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(28),
                        decoration: BoxDecoration(
                          color: AppColors.background,
                          borderRadius: BorderRadius.circular(28),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const SizedBox(
                              width: double.infinity,
                            child: Text(
                              'Iniciar Sesión',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: AppColors.textTitle,
                                fontSize: 24,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                            ),
                            const SizedBox(height: 6),
                            const Text(
                              'Ingresa tus credenciales para continuar al sistema',
                              textAlign: TextAlign.center,
                              style: TextStyle(color: AppColors.textGrey, fontSize: 13,),
                            ),
                            const SizedBox(height: 24),
                            const Text(
                              'USUARIO',
                              style: TextStyle(
                                color: AppColors.textGrey,
                                fontWeight: FontWeight.w700,
                                fontSize: 11.5,
                                letterSpacing: 0.5,
                              ),
                            ),
                            const SizedBox(height: 8),
                            TextField(
                              controller: usuarioController,
                              decoration: InputDecoration(
                                hintText: 'administrador',
                                prefixIcon: const Icon(Icons.person_outline, color: AppColors.textGrey),
                                filled: true,
                                fillColor: Colors.white,
                                contentPadding:
                                    const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide.none,
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: const BorderSide(color: AppColors.primary, width: 1.5),
                                ),
                              ),
                            ),
                            const SizedBox(height: 18),
                            const Text(
                              'CONTRASEÑA',
                              style: TextStyle(
                                color: AppColors.textGrey,
                                fontWeight: FontWeight.w700,
                                fontSize: 11.5,
                                letterSpacing: 0.5,
                              ),
                            ),
                            const SizedBox(height: 8),
                            TextField(
                              controller: contrasenaController,
                              obscureText: ocultarContrasena,
                              decoration: InputDecoration(
                                hintText: '123Maria',
                                prefixIcon: const Icon(Icons.lock_outline, color: AppColors.textGrey),
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    ocultarContrasena
                                        ? Icons.visibility_off_outlined
                                        : Icons.visibility_outlined,
                                    color: AppColors.textGrey,
                                  ),
                                  onPressed: () {
                                    setState(() => ocultarContrasena = !ocultarContrasena);
                                  },
                                ),
                                filled: true,
                                fillColor: Colors.white,
                                contentPadding:
                                    const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide.none,
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: const BorderSide(color: AppColors.primary, width: 1.5),
                                ),
                              ),
                            ),
                            const SizedBox(height: 14),
                            InkWell(
                              onTap: () {
                                setState(() => recordarSesion = !recordarSesion);
                              },
                              child: Row(
                                children: [
                                  Checkbox(
                                    value: recordarSesion,
                                    onChanged: (value) {
                                      setState(() => recordarSesion = value ?? false);
                                    },
                                    activeColor: AppColors.primary,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                  ),
                                  const Text(
                                    'Recordar sesión',
                                    style: TextStyle(color: AppColors.textTitle, fontSize: 14),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 12),
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: () {
                                final usuario = usuarioController.text.trim().toLowerCase();

                                if (usuario == 'administrador') {
                                  UserSession.rol = 'administrador';
                                } else {
                                  UserSession.rol = 'cajero';
                                }

                                Navigator.of(context).pushReplacementNamed(AppRoutes.home);
                              },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.primary,
                                  padding: const EdgeInsets.symmetric(vertical: 16),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(14),
                                  ),
                                ),
                                child: const Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Ingresar',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w700,
                                        fontSize: 15,
                                      ),
                                    ),
                                    SizedBox(width: 8),
                                    Icon(Icons.arrow_forward, color: Colors.white, size: 18),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(height: 14),
                            Align(
                              alignment: Alignment.centerRight,
                              child: TextButton(
                                onPressed: () {},
                                style: TextButton.styleFrom(padding: EdgeInsets.zero),
                                child: const Text(
                                  '¿Olvidaste tu contraseña?',
                                  style: TextStyle(
                                    color: AppColors.primary,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 13,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
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

  Widget burbuja(
    double tamano, {
    double? top,
    double? bottom,
    double? left,
    double? right,
  }) {
    return Positioned(
      top: top,
      bottom: bottom,
      left: left,
      right: right,
      child: Container(
        width: tamano,
        height: tamano,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: AppColors.primaryLight.withOpacity(0.35),
          border: Border.all(color: Colors.white.withOpacity(0.3)),
        ),
      ),
    );
  }
}