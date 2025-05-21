import 'package:http/http.dart' as http;
import 'dart:convert';

Future<void> sendInscriptionRequest({
  required String nom,
  required String prenom,
  required String email,
  required String groupe,
}) async {
  final url = Uri.parse('http://localhost:8000/api/inscription-atelier'); // Adapte si prod

  final response = await http.post(
    url,
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode({
      'nom': nom,
      'prenom': prenom,
      'email': email,
      'atelier': groupe,
    }),
  );

  if (response.statusCode != 200) {
    throw Exception('Erreur lors de l\'envoi : ${response.body}');
  }
}
