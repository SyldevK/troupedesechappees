import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthService {
  static const _baseUrl = 'https://b73e-2a01-cb08-8b47-9900-b0fe-f49e-21fd-4b3e.ngrok-free.app/api';
  static const _storage = FlutterSecureStorage();

  static Future<String?> login(String email, String password) async {
    final url = Uri.parse('$_baseUrl/login');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email, 'password': password}),
    );

    if (response.statusCode == 200) {
      try {
        final data = jsonDecode(response.body);
        final token = data['token'];
        if (token != null) {
          await _storage.write(key: 'jwt_token', value: token);
          return token;
        }
      } catch (e) {
        print('Erreur JSON login: $e');
      }
    } else {
      print('Échec connexion (${response.statusCode}): ${response.body}');
    }
    return null;
  }

  static Future<String?> getToken() => _storage.read(key: 'jwt_token');

  static Future<void> logout() => _storage.delete(key: 'jwt_token');

  static Future<Map<String, dynamic>?> fetchUserProfile() async {
    final token = await getToken();
    if (token == null) return null;

    final url = Uri.parse('$_baseUrl/me');
    final response = await http.get(
      url,
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );

    // Vérifie que le content-type est bien JSON
    final contentType = response.headers['content-type'];
    if (response.statusCode == 200 && contentType != null && contentType.contains('application/json')) {
      try {
        return jsonDecode(response.body);
      } catch (e) {
        print('Erreur de décodage JSON: $e');
        return null;
      }
    } else {
      print('Réponse invalide (${response.statusCode}): ${response.body}');
      return null;
    }
  }
}
