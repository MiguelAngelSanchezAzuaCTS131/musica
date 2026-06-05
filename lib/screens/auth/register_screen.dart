import 'package:flutter/material.dart';

import '../../utils/app_colors.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_textfield.dart';
import '../../services/storage_service.dart';
import '../../theme/app_theme.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    usernameController.dispose();
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
                  Center(
                    child: Column(
                      children: [
                        Text(
                          'MELOBOXD',
                          style: TextStyle(
                            fontFamily: 'Brasika',
                            fontSize: 48,
                            color: AppTheme.lightPurple,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Image.asset(
                          'assets/images/meloboxd_logo.png',
                          height: 395,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Regístrate',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const Text(
                    'Crea tu cuenta para empezar',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white70,
                    ),
                  ),
                  const SizedBox(height: 25),
                  CustomTextField(
                    hintText: 'Username',
                    controller: usernameController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Ingresa tu username';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 15),
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
                  const SizedBox(height: 15),
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
                    text: 'Registrarse',
                    onPressed: () async {
                      if (formKey.currentState!.validate()) {
                        // Asegúrate de que tu StorageService acepte 'username'
                        await StorageService.saveUser(
                          username: usernameController.text.trim(),
                          email: emailController.text.trim(),
                          password: passwordController.text,
                        );

                        if (!mounted) return;
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Cuenta creada correctamente'),
                          ),
                        );

                        Navigator.pop(context);
                      }
                    },
                  ),
                  const SizedBox(height: 15),
                  Center(
                    child: TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text(
                        '¿Ya tienes una cuenta?',
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