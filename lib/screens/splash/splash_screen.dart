import 'package:flutter/material.dart';
import 'dart:async';
import 'package:lottie/lottie.dart';
import 'package:musicboxd/screens/auth/login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  
  @override
  void initState() {
    super.initState();

    // Temporizador de 5 segundos para ir al Login
    Timer(const Duration(seconds: 5), () {
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const LoginScreen()),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0E0B1F), // Fondo oscuro
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
           
            Lottie.asset(
              'assets/lottie/gato.json',
              width: 300,
              height: 300,
              repeat: true,
              animate: true,
            ),
            
            const SizedBox(height: 30),
            
            // Texto de carga
            const Text(
              "Cargando app...",
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 16,
                color: Colors.white54, 
                letterSpacing: 1.2,
              ),
            ),
            
            const SizedBox(height: 20),
            
  
            const SizedBox(
              width: 100,
              child: LinearProgressIndicator(
                backgroundColor: Color(0xFF211161),
                valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF6F42EC)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}