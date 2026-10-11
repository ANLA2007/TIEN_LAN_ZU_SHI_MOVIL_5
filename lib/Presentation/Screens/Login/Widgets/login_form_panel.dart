import 'package:flutter/material.dart';
import 'package:flutter_buffet/Themes/app_colors.dart';
import 'package:flutter_buffet/Presentation/Screens/Login/Widgets/decorative_bubble.dart';

class LoginFormPanel extends StatefulWidget {
  final TextEditingController usuarioController;
  final TextEditingController contrasenaController;
  final VoidCallback onLoginPressed;

  const LoginFormPanel({
    super.key,
    required this.usuarioController,
    required this.contrasenaController,
    required this.onLoginPressed,
  });

  @override
  State<LoginFormPanel> createState() => _LoginFormPanelState();
}

class _LoginFormPanelState extends State<LoginFormPanel> {
  bool ocultarContrasena = true;
  bool recordarSesion = true;

  @override
  Widget build(BuildContext context) {
    return Container(
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
            style: TextStyle(color: AppColors.textGrey, fontSize: 13),
          ),
          const SizedBox(height: 24),
          LabeledTextField(
            label: 'USUARIO',
            hint: 'administrador',
            controller: widget.usuarioController,
            icon: Icons.person_outline,
          ),
          const SizedBox(height: 18),
          LabeledTextField(
            label: 'CONTRASEÑA',
            hint: '123Maria',
            controller: widget.contrasenaController,
            icon: Icons.lock_outline,
            obscureText: ocultarContrasena,
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
          PrimaryButton(onPressed: widget.onLoginPressed),
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
    );
  }
}