import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


import '../../utils/app_colors.dart';
import '../../services/storage_service.dart';
import '../../theme/app_theme.dart';
import '../auth/login_screen.dart'; 

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  // Variables locales para retener los datos leídos del Storage
  String username = 'Cargando...';
  String email = 'Cargando...';
  String password = '';
  
  bool _isPasswordObscured = true;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

 
  Future<void> _loadUserData() async {
    final savedUsername = await StorageService.getUsername() ?? 'User';
    final savedEmail = await StorageService.getEmail() ?? 'sin_correo@meloboxd.com';
    final savedPassword = await StorageService.getPassword() ?? '';

    if (mounted) {
      setState(() {
        username = savedUsername;
        email = savedEmail;
        password = savedPassword;
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor, // Mismo fondo morado de tus pantallas
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          "Mi Perfil",
          style: TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator(color: AppTheme.lightPurple))
          : SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 10),
                  
                  // 👤 ICONO DE PERFIL DE USUARIO
                  Center(
                    child: Container(
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: AppTheme.lightPurple, // Color insignia de tu tema
                        shape: BoxShape.circle,
                      ),
                      child: CircleAvatar(
                        radius: 55,
                        backgroundColor: AppTheme.indigoColor, // Fondo oscuro armónico
                        child: Icon(
                          Icons.person_rounded,
                          size: 70,
                          color: Colors.white.withOpacity(0.9),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  
                  // TEXTOS DEL ENCABEZADO
                  Text(
                    username,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    "User de MeloBoxd",
                    style: TextStyle(
                      color: Colors.white54,
                      fontSize: 14,
                    ),
                  ),
                  
                  const SizedBox(height: 35),

                
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: AppTheme.indigoColor, // Fondo contenedor estético
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // CAMPO: USERNAME
                        _buildProfileField(
                          label: "Nombre de usuario",
                          value: username,
                          icon: Icons.alternate_email_rounded,
                        ),
                        const Divider(color: Colors.white12, height: 24),

                        // CAMPO: EMAIL
                        _buildProfileField(
                          label: "Correo electrónico",
                          value: email,
                          icon: Icons.email_outlined,
                        ),
                        const Divider(color: Colors.white12, height: 24),

                        // CAMPO: CONTRASEÑA (INTERACTIVA OCHO/PUNTOS)
                        const Text(
                          "Contraseña",
                          style: TextStyle(color: Colors.white54, fontSize: 13),
                        ),
                        const SizedBox(height: 6),
                        Row(
                          children: [
                            Icon(Icons.lock_outline_rounded, color: AppTheme.lightPurple, size: 20),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Text(
                                _isPasswordObscured 
                                    ? "••••••••••••" 
                                    : (password.isNotEmpty ? password : "No definida"),
                                style: TextStyle(
                                  color: Colors.white, 
                                  fontSize: 16,
                                  letterSpacing: _isPasswordObscured ? 2 : 0,
                                ),
                              ),
                            ),
                            IconButton(
                              icon: Icon(
                                _isPasswordObscured ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                                color: Colors.white54,
                                size: 20,
                              ),
                              onPressed: () {
                                setState(() {
                                  _isPasswordObscured = !_isPasswordObscured;
                                });
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 50),

                  SizedBox(
                    width: double.infinity,
                    height: 52,
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFD32F2F), // Rojo estilizado para salidas
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        elevation: 0,
                      ),
                      icon: const Icon(Icons.logout_rounded, color: Colors.white),
                      label: const Text(
                        "Cerrar Sesión",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      onPressed: () async {
                        // 1. Invalidamos el login en el storage local para que no auto-entre
                        await StorageService.saveLoginStatus(false);
                        
                        // 2. Destruimos la pila de navegación y volvemos al login
                        if (context.mounted) {
                          Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(builder: (context) => const LoginScreen()),
                            (Route<dynamic> route) => false,
                          );
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
    );
  }

  // Widget plantilla para construir las filas del formulario rápidamente
  Widget _buildProfileField({required String label, required String value, required IconData icon}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(color: Colors.white54, fontSize: 13),
        ),
        const SizedBox(height: 6),
        Row(
          children: [
            Icon(icon, color: AppTheme.lightPurple, size: 20),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                value,
                style: const TextStyle(color: Colors.white, fontSize: 16),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ],
    );
  }
}