class UserSession {
  UserSession._();

  // Valor por defecto: cajero (el rol con menos permisos).
  static String rol = 'cajero';

  static bool get esAdministrador => rol == 'administrador';
  static bool get esCajero => rol == 'cajero';
}