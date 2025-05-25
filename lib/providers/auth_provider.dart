import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AuthProvider extends ChangeNotifier {
  final _storage = const FlutterSecureStorage();
  bool _isLoggedIn = false;
  List<String> _roles = [];

  bool get isLoggedIn => _isLoggedIn;
  List<String> get roles => _roles;
  bool get isAdmin => _roles.contains('ROLE_ADMIN');

  AuthProvider() {
    checkLoginStatus();
  }

  Future<void> checkLoginStatus() async {
    final token = await _storage.read(key: 'jwt_token');
    if (token != null) {
      _isLoggedIn = true;
      await _fetchRoles(token); // charge les rôles à partir du backend
    } else {
      _isLoggedIn = false;
    }
    notifyListeners();
  }

  Future<String?> getToken() async {
    return await _storage.read(key: 'jwt_token');
  }

  Future<void> login(String token) async {
    await _storage.write(key: 'jwt_token', value: token);
    _isLoggedIn = true;
    await _fetchRoles(token);
    notifyListeners();
  }

  Future<void> logout() async {
    await _storage.delete(key: 'jwt_token');
    _isLoggedIn = false;
    _roles = [];
    notifyListeners();
  }

  Future<void> _fetchRoles(String token) async {
    try {
      final response = await http.get(
        Uri.parse('http://tie.test/api/me'),
        headers: {'Authorization': 'Bearer $token'},
      );
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final rawRoles = data['roles'] as List?;
        _roles = rawRoles?.cast<String>() ?? [];
      } else {
        _roles = [];
      }
    } catch (e) {
      _roles = [];
      print('Erreur lors du chargement des rôles: $e');
    }
  }
}
