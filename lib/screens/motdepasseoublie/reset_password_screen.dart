import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../services/api_service.dart';

class ResetPasswordScreen extends StatefulWidget {
  final String token;

  const ResetPasswordScreen({super.key, required this.token});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final _passwordController = TextEditingController();
  bool _sending = false;

  String get token => widget.token; // ✅ On utilise le token passé par le constructeur

  Future<void> resetPassword() async {
    setState(() => _sending = true);

    try {
      final baseUrl = ApiService.baseApiUrl;
      final response = await http.post(
        Uri.parse('$baseUrl/reset-password'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'token': token,
          'password': _passwordController.text,
        }),
      );

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Mot de passe réinitialisé avec succès !')),
        );
        Navigator.pop(context);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Erreur lors de la réinitialisation.')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Erreur réseau')),
      );
    }

    setState(() => _sending = false);
  }

  @override
  Widget build(BuildContext context) {
    final violetFonce = const Color(0xFF7D0494);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Réinitialiser le mot de passe',
          style: TextStyle(fontFamily: 'Poppins'),
        ),
        backgroundColor: violetFonce,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                token.isEmpty
                    ? 'Lien invalide ou expiré.'
                    : 'Entrez votre nouveau mot de passe.',
                textAlign: TextAlign.center,
                style: const TextStyle(fontFamily: 'Poppins', fontSize: 18),
              ),
              const SizedBox(height: 30),
              if (token.isNotEmpty) ...[
                TextField(
                  controller: _passwordController,
                  obscureText: true,
                  style: const TextStyle(
                    fontFamily: 'Poppins',
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                  decoration: InputDecoration(
                    labelText: 'Nouveau mot de passe',
                    labelStyle: const TextStyle(
                      color: Colors.white,
                      fontFamily: 'Poppins',
                    ),
                    filled: true,
                    fillColor: violetFonce,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                ElevatedButton(
                  onPressed: _sending ? null : resetPassword,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: violetFonce,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 40,
                      vertical: 16,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: _sending
                      ? const CircularProgressIndicator(color: Colors.white)
                      : const Text(
                    'Réinitialiser le mot de passe',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
