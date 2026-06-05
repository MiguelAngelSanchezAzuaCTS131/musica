import 'package:shared_preferences/shared_preferences.dart';

class StorageService {
  
  // SAVE USER
  static Future<void> saveUser({
    required String username,
    required String email,
    required String password,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('username', username);
    await prefs.setString('email', email);
    await prefs.setString('password', password);
  }

  // GET USER EMAIL
  static Future<String?> getEmail() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('email');
  }

  // GET PASSWORD
  static Future<String?> getPassword() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('password');
  }

  // GET USERNAME
  static Future<String?> getUsername() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('username');
  }

  // SAVE LOGIN STATUS
  static Future<void> saveLoginStatus(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', value);
  }

  // GET LOGIN STATUS
  static Future<bool> getLoginStatus() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('isLoggedIn') ?? false;
  }

  // LOGOUT (Limpieza de seguridad)
  static Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
   
    await prefs.clear(); 
    await prefs.setBool('isLoggedIn', false);
  }
}