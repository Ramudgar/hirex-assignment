import 'package:shared_preferences/shared_preferences.dart';

class Authcontroller {
// as we are using shared preferences to store the token in the device we need to make a method to set and get the token from the shared preferences

// this method will set the token in the shared preferences
  Future<bool> setAuthToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.setString(AuthStatus.authToken.toString(), token);
  }

  // this method will get the token from the shared preferences
  static Future<String?> getAuthToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(AuthStatus.authToken.toString());
  }

  // this method will remove the token from the shared preferences
  static Future<bool> removeAuthToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.remove(AuthStatus.authToken.toString());
  }

  // to store the role in the shared preferences
  Future<bool> setRole(String role) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.setString(AuthStatus.role.toString(), role);
  }

  // to get the role from the shared preferences
  static Future<String?> getRole() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(AuthStatus.role.toString());
  }

  // to store user email in the shared preferences
  Future<bool> setEmail(String email) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.setString(AuthStatus.email.toString(), email);
  }

  // to get the user email from the shared preferences
  static Future<String?> getEmail() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(AuthStatus.email.toString());
  }

  // to store password in the shared preferences
  Future<bool> setPassword(String password) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.setString(AuthStatus.password.toString(), password);
  }

  // to get the password from the shared preferences
  static Future<String?> getPassword() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(AuthStatus.password.toString());
  }
}

enum AuthStatus { authToken, role, email, password }
