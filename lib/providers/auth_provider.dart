import 'package:flutter/material.dart';

class AuthProvider extends ChangeNotifier {

  String? username;

  bool isLoggedIn = false;

  void login(String name) {

    username = name;

    isLoggedIn = true;

    notifyListeners();
  }

  void logout() {

    username = null;

    isLoggedIn = false;

    notifyListeners();
  }
}