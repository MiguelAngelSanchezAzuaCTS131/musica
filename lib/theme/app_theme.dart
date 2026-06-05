import 'package:flutter/material.dart';

class AppTheme {
  static const Color backgroundColor = Color(0xFF0D0E20);
  static const Color primaryPurple   = Color(0xFF7546E8);
  static const Color lightPurple     = Color(0xFFC8B3F6);
  static const Color indigoColor     = Color(0xFF2D1C7F);
  static const Color mutedIndigo     = Color(0xFF64589F);

  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: backgroundColor,
    fontFamily: 'Poppins',

 
    colorScheme: const ColorScheme.dark(
      primary: primaryPurple,
      secondary: lightPurple,
      surface: indigoColor, // Usaremos este para las tarjetas (Cards)
      background: backgroundColor,
    ),


    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.transparent,
      elevation: 0,
      centerTitle: true,
      iconTheme: IconThemeData(color: Colors.white),
      titleTextStyle: TextStyle(
        fontFamily: 'Poppins',
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
    ),

   
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButtonThemeFrom(
        backgroundColor: primaryPurple,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(vertical: 14),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
        ),
        textStyle: const TextStyle(
          fontFamily: 'Poppins',
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
      ),
    ),

    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: indigoColor, // Fondo de los buscadores y comentarios
      hintStyle: const TextStyle(color: mutedIndigo, fontSize: 14),
      prefixIconColor: lightPurple,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: BorderSide.none,
      ),
    ),

    checkboxTheme: CheckboxThemeData(
      fillColor: MaterialStateProperty.resolveWith<Color?>((states) {
        if (states.contains(MaterialState.selected)) return primaryPurple;
        return mutedIndigo;
      }),
      checkColor: MaterialStateProperty.all(Colors.white),
    ),

    cardTheme: CardThemeData(
      color: indigoColor.withOpacity(0.5), // Un tono traslúcido elegante
      elevation: 0,
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
    ),
  );

  static ButtonStyle ElevatedButtonThemeFrom({
    required Color backgroundColor,
    required Color foregroundColor,
    required EdgeInsetsGeometry padding,
    required OutlinedBorder shape,
    required TextStyle textStyle,
  }) {
    return ElevatedButton.styleFrom(
      backgroundColor: backgroundColor,
      foregroundColor: foregroundColor,
      padding: padding,
      shape: shape,
      textStyle: textStyle,
    );
  }
}