import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_colors.dart';

class AppTheme {

  static ThemeData darkTheme = ThemeData(

    brightness: Brightness.dark,

    scaffoldBackgroundColor:
        AppColors.background,

    primaryColor:
        AppColors.primaryPurple,

    textTheme:
        GoogleFonts.poppinsTextTheme(
      ThemeData.dark().textTheme,
    ),

    colorScheme: const ColorScheme.dark(
      primary: AppColors.primaryPurple,
      secondary: AppColors.secondaryPurple,
    ),

    inputDecorationTheme:
        InputDecorationTheme(

      filled: true,

      fillColor: AppColors.cardColor,

      border: OutlineInputBorder(
        borderRadius:
            BorderRadius.all(
          Radius.circular(16),
        ),

        borderSide: BorderSide.none,
      ),

      hintStyle: TextStyle(
        color: Colors.white54,
      ),
    ),

    elevatedButtonTheme:
        ElevatedButtonThemeData(

      style: ElevatedButton.styleFrom(

        backgroundColor:
            AppColors.primaryPurple,

        shape: RoundedRectangleBorder(
          borderRadius:
              BorderRadius.circular(16),
        ),

        minimumSize:
            const Size(double.infinity, 55),
      ),
    ),
  );
}