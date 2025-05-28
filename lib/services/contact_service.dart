import 'dart:convert';
import 'package:http/http.dart' as http;
import 'api_service.dart';

class ContactService {
  static Future<bool> envoyerMessage({
    required String nom,
    required String prenom,
    required String email,
    required String message,
  }) async {
    final url = Uri.parse('${ApiService.baseApiUrl}/api/contact');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'nom': nom,
        'prenom': prenom,
        'email': email,
        'message': message,
      }),
    );
    return response.statusCode == 200 || response.statusCode == 201;
  }
}
