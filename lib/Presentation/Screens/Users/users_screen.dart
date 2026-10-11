import 'package:flutter/material.dart';
import 'package:flutter_buffet/Themes/app_colors.dart';
import 'package:flutter_buffet/Presentation/Widgets/app_top_bar.dart';
import 'package:flutter_buffet/Presentation/Widgets/app_drawer.dart';
import 'package:flutter_buffet/Presentation/Widgets/navigation_bar.dart';
import 'package:flutter_buffet/Presentation/Widgets/pagination_bar.dart';
import 'package:flutter_buffet/app_routes.dart';
import 'package:flutter_buffet/Presentation/Screens/Users/Widgets/user_card.dart';
import 'package:flutter_buffet/Presentation/Screens/Users/Widgets/status_filter_chips.dart';
import 'package:flutter_buffet/Presentation/Screens/Users/Widgets/role_filter_sheet.dart';
import 'package:flutter_buffet/Presentation/Screens/Users/Widgets/user_search_bar.dart';


final List<Map<String, dynamic>> usuarios = [
  {
    'nombre': 'Roberta Baltodano',
    'correo': 'roberta@buffet.com',
    'iniciales': 'RB',
    'rol': 'Administrador',
    'activo': true,
  },
  {
    'nombre': 'Dulce Velásquez',
    'correo': 'dulce@buffet.com',
    'iniciales': 'DV',
    'rol': 'Cajero',
    'activo': true,
  },
  {
    'nombre': 'Alexa Lara',
    'correo': 'alexa@buffet.com',
    'iniciales': 'AL',
    'rol': 'Cajero',
    'activo': true,
  },
  {
    'nombre': 'Daniela López',
    'correo': 'daniela@buffet.com',
    'iniciales': 'DL',
    'rol': 'Cajero',
    'activo': false,
  },
];

const List<String> rolesDisponibles = [
  'Administrador',
  'Cajero',
  
];

class UsersScreen extends StatefulWidget {
  const UsersScreen({super.key});

  @override
  State<UsersScreen> createState() => UsersScreenState();
}

class UsersScreenState extends State<UsersScreen> {
  String busqueda = '';
  String estadoSeleccionado = 'Todos';
  String? rolSeleccionado;
  final TextEditingController buscadorController = TextEditingController();
  List<Map<String, dynamic>> usuariosFiltrados = [];

  @override
  void initState() {
    super.initState();
    filtrarUsuarios();
  }

  @override
  void dispose() {
    buscadorController.dispose();
    super.dispose();
  }

  bool coincideNombre(Map<String, dynamic> usuario) {
    if (busqueda.isEmpty) return true;
    final texto = busqueda.toLowerCase();
    return (usuario['nombre'] as String).toLowerCase().contains(texto) ||
        (usuario['correo'] as String).toLowerCase().contains(texto);
  }

  bool coincideEstado(Map<String, dynamic> usuario) {
    if (estadoSeleccionado == 'Activos') return usuario['activo'] as bool;
    if (estadoSeleccionado == 'Inactivos') return !(usuario['activo'] as bool);
    return true;
  }

  bool coincideRol(Map<String, dynamic> usuario) {
    if (rolSeleccionado == null) return true;
    return usuario['rol'] == rolSeleccionado;
  }

  void filtrarUsuarios() {
    setState(() {
      usuariosFiltrados = usuarios
          .where((u) => coincideNombre(u) && coincideEstado(u) && coincideRol(u))
          .toList();
    });
  }

  Future<void> abrirFiltroRol() async {
    final resultado = await showRoleFilterSheet(
      context,
      roles: rolesDisponibles,
      rolSeleccionado: rolSeleccionado,
    );
    rolSeleccionado = resultado;
    filtrarUsuarios();
  }

  void eliminarUsuario(Map<String, dynamic> usuario) {
    setState(() {
      usuarios.remove(usuario);
      filtrarUsuarios();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      drawer: const AppDrawer(),
      appBar: const AppTopBar(title: 'Usuarios'),
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 14, 16, 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 12),
                  UserSearchBar(
                    hintText: 'Buscar usuario...',
                    controller: buscadorController,
                    onChanged: (valor) {
                      busqueda = valor;
                      filtrarUsuarios();
                    },
                    onFilterPressed: abrirFiltroRol,
                    onAddPressed: () {
                      Navigator.of(context).pushNamed(AppRoutes.newUsuario);
                    },
                  ),
                  const SizedBox(height: 14),
                  StatusFilterChips(
                    seleccionado: estadoSeleccionado,
                    onChanged: (valor) {
                      estadoSeleccionado = valor;
                      filtrarUsuarios();
                    },
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.fromLTRB(16, 4, 16, 16),
                itemCount: usuariosFiltrados.length,
                separatorBuilder: (context, index) => const SizedBox(height: 12),
                itemBuilder: (context, index) {
                  final usuario = usuariosFiltrados[index];

                  return UserCard(
                    nombre: usuario['nombre'] as String,
                    correo: usuario['correo'] as String,
                    iniciales: usuario['iniciales'] as String,
                    rol: usuario['rol'] as String,
                    activo: usuario['activo'] as bool,
                    onTap: () {},
                    onDelete: () => eliminarUsuario(usuario),
                  );
                },
              ),
            ),
            PaginationBar(
              currentPage: 1,
              totalPages: 1,
              infoText: 'Mostrando 1-${usuariosFiltrados.length} de ${usuariosFiltrados.length}',
            ),
          ],
        ),
      ),
      bottomNavigationBar: const AppNavigatorBar(currentIndex: null),
    );
  }
}