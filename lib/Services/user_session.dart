class UserSession {
  UserSession._();

  // Valor por defecto usuario con menos permisos
  static String rol = 'cajero';

  static bool get esAdministrador => rol == 'administrador';
  static bool get esCajero => rol == 'cajero';

  static const String claveAdministrador = 'admin123';
  static const String claveCajero = 'cajero123';
}