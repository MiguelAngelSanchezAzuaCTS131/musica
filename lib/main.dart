import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:musicboxd/providers/auth_provider.dart';
import 'package:musicboxd/providers/favorites_provider.dart';
import 'package:musicboxd/providers/review_provider.dart';
import 'package:musicboxd/providers/theme_provider.dart';
import 'package:musicboxd/providers/cajitas_provider.dart'; 

import 'package:musicboxd/screens/auth/login_screen.dart';
import 'package:musicboxd/screens/home/home_screen.dart';
import 'package:musicboxd/services/storage_service.dart';
import 'package:musicboxd/theme/app_theme.dart';
import 'package:musicboxd/screens/splash/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool? isLoggedIn;

  @override
  void initState() {
    super.initState();
    checkLogin();
  }

  Future<void> checkLogin() async {
    final status = await StorageService.getLoginStatus();
    if (!mounted) return;

    setState(() {
      isLoggedIn = status;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (isLoggedIn == null) {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: AppTheme.darkTheme,
        home: const Scaffold(
          body: Center(
            child: CircularProgressIndicator(
              color: AppTheme.primaryPurple,
            ),
          ),
        ),
      );
    }

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => FavoritesProvider()),
        ChangeNotifierProvider(create: (_) => ReviewProvider()),
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => CajitasProvider()), 
      ],
      child: MaterialApp( 
        debugShowCheckedModeBanner: false,
        title: 'MeloBoxd',
        theme: AppTheme.darkTheme, 
        home: const SplashScreen(),
      ),
    );
  }
}