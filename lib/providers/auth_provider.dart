import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthProvider extends ChangeNotifier {
  final _storage = const FlutterSecureStorage();
  bool _isLoggedIn = false;

  bool get isLoggedIn => _isLoggedIn;

  AuthProvider() {
    checkLoginStatus();
  }

  Future<void> checkLoginStatus() async {
    final token = await _storage.read(key: 'jwt_token');
    _isLoggedIn = token != null;
    notifyListeners();
  }

  Future<String?> getToken() async {
    return await _storage.read(key: 'jwt_token');
  }

  Future<void> login(String token) async {
    await _storage.write(key: 'jwt_token', value: token);
    _isLoggedIn = true;
    notifyListeners();
  }

  Future<void> logout() async {
    await _storage.delete(key: 'jwt_token');
    _isLoggedIn = false;
    notifyListeners();
  }
}
