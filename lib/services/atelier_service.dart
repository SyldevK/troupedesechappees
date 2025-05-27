import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'dart:convert';
import 'api_service.dart';
import 'auth_service.dart';

final storage = FlutterSecureStorage();

Future<void> sendInscriptionRequest({
  required String nom,
  required String prenom,
  required String email,
  required String atelier,
  required String date_naissance,
}) async {
  final url = Uri.parse('${ApiService.baseApiUrl}/inscription-atelier');

  final token = await AuthService.getToken();
  if (token == null) {
    throw Exception('Aucun token JWT trouvé. Veuillez vous reconnecter.');
  }

  final response = await http.post(
    url,
    headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    },
    body: jsonEncode({
      'nom': nom,
      'prenom': prenom,
      'email': email,
      'date_naissance': date_naissance,
      'atelier': atelier,
    }),
  );

  if (response.statusCode != 200) {
    throw Exception('Erreur lors de l\'envoi : ${response.body}');
  }
}
