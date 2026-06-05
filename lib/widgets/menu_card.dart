import 'package:flutter/material.dart';

class MenuCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color backgroundColor;
  final VoidCallback onTap;

  const MenuCard({
    super.key,
    required this.title,
    required this.icon,
    required this.backgroundColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: backgroundColor, // Pinta el fondo del botón
          borderRadius: BorderRadius.circular(28), // Bordes redondeados como tu diseño
          boxShadow: [
            // Sombra sólida estilo 3D hacia abajo a la derecha
            BoxShadow(
              color: const Color(0xFF070412).withOpacity(0.7),
              offset: const Offset(5, 7),
              blurRadius: 0,
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 55, 
              color: Colors.white, // Iconos siempre blancos
            ),
            const SizedBox(height: 12),
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.white, // Texto siempre blanco
                fontSize: 18,
                fontWeight: FontWeight.w500,
                fontFamily: 'Poppins',
              ),
            ),
          ],
        ),
      ),
    );
  }
}