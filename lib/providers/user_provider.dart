import 'package:flutter/material.dart';

class UserProvider with ChangeNotifier {
  String _username = '';
  String _email = '';
  String _password = '';
  bool _isLoggedIn = false;

  String get username => _username;
  String get email => _email;
  String get password => _password;
  bool get isLoggedIn => _isLoggedIn;

  // Guarda los datos al registrarse o iniciar sesión
  void loginUser({
    required String username,
    required String email,
    required String password,
  }) {
    _username = username;
    _email = email;
    _password = password;
    _isLoggedIn = true;
    notifyListeners(); 
  }

  // Limpia la memoria al salir
  void logoutUser() {
    _username = '';
    _email = '';
    _password = '';
    _isLoggedIn = false;
    notifyListeners();
  }
}