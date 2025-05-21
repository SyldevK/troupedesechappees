import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../services/api_service.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _emailController = TextEditingController();
  bool _sending = false;

  Future<void> forgotPassword() async {
    setState(() => _sending = true);
    try {
      final baseUrl = ApiService.getBaseUrl();
      final response = await http.post(
        Uri.parse('$baseUrl/api/forgot-password'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': _emailController.text}),
      );

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Si cet email existe, un lien a été envoyé.')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Erreur lors de la demande.')),
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
    final violetFonce = const Color(0xFF6C3A87);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Mot de passe oublié',
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
              const Text(
                'Entrez votre adresse e-mail pour recevoir un lien de réinitialisation.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 18,
                ),
              ),
              const SizedBox(height: 30),
              TextField(
                controller: _emailController,
                style: const TextStyle(
                  fontFamily: 'Poppins',
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
                decoration: InputDecoration(
                  labelText: 'Adresse e-mail',
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
                onPressed: _sending ? null : forgotPassword,
                style: ElevatedButton.styleFrom(
                  backgroundColor: violetFonce,
                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: _sending
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text(
                  'Envoyer le lien',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
