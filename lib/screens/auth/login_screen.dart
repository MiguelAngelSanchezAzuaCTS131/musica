import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; 

import '../../utils/app_colors.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_textfield.dart';
import '../../providers/auth_provider.dart'; 
import 'register_screen.dart';
import '../../services/storage_service.dart';
import '../home/home_screen.dart';
import '../../theme/app_theme.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      body: SafeArea(
        child: Center( 
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            child: Form(
              key: formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min, 
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center( // Centramos el título y logo para que se vea más pro
                    child: Column(
                      children: [
                        Text(
                          'MELOBOXD',
                          style: TextStyle(
                            fontFamily: 'Brasika',
                            fontSize: 48, // Bajado a 48 para evitar desbordamientos en pantallas chicas
                            color: AppTheme.lightPurple,
                          ),
                        ),
                        Image.asset(
                          'assets/images/meloboxd_logo.png',
                          height: 420, // Ajustado para que quepa perfecto con el teclado abierto
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Login',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const Text(
                    '¡Bienvenido de vuelta!',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white70,
                    ),
                  ),
                  const SizedBox(height: 20),
                  CustomTextField(
                    hintText: 'Email',
                    controller: emailController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Ingresa tu email';
                      }
                      if (!value.contains('@')) {
                        return 'Tu email debe tener @';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  CustomTextField(
                    hintText: 'Contraseña',
                    controller: passwordController,
                    obscureText: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Ingresa tu contraseña';
                      }
                      if (value.length < 6) {
                        return 'Tu contraseña debe tener mínimo 6 caracteres';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 30),
                  CustomButton(
                    text: 'Login',
                    onPressed: () async {
                      if (formKey.currentState!.validate()) {
                        final savedEmail = await StorageService.getEmail();
                        final savedPassword = await StorageService.getPassword();
                        final savedUsername = await StorageService.getUsername() ?? 'Melómano';

                        if (emailController.text.trim() == savedEmail &&
                            passwordController.text == savedPassword) {
                          
                         
                          await StorageService.saveLoginStatus(true);

                          if (mounted) {
                            final authProvider = Provider.of<AuthProvider>(context, listen: false);
                            
                            // Llamamos a tu método login pasándole los datos locales para que queden en memoria
                            authProvider.login(savedUsername);
           
                          }

                          if (!mounted) return;
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const HomeScreen(),
                            ),
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Correo o contraseña incorrectos'),
                            ),
                          );
                        }
                      }
                    },
                  ),
                  const SizedBox(height: 20),
                  Center(
                    child: TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const RegisterScreen(),
                          ),
                        );
                      },
                      child: const Text(
                        'Crea una cuenta',
                        style: TextStyle(
                          color: AppColors.secondaryPurple,
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
    );
  }
}