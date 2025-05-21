import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../services/auth_service.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../services/api_service.dart';

class ChangerMotDePasseScreen extends StatefulWidget {
  const ChangerMotDePasseScreen({super.key});

  @override
  State<ChangerMotDePasseScreen> createState() => _ChangerMotDePasseScreenState();
}

class _ChangerMotDePasseScreenState extends State<ChangerMotDePasseScreen> {
  final _formKey = GlobalKey<FormState>();
  final _ancienController = TextEditingController();
  final _nouveauController = TextEditingController();
  final _confirmeController = TextEditingController();
  bool _isLoading = false;
  final Color violetFonce = const Color(0xFF6C3A87);

  Future<void> _changerMotDePasse() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);
    final token = await AuthService.getToken();

    final response = await http.post(
      Uri.parse('${ApiService.getBaseUrl()}/api/change-password'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode({
        'ancien': _ancienController.text,
        'nouveau': _nouveauController.text,
      }),
    );

    setState(() => _isLoading = false);

    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Mot de passe modifié avec succès')));
      Navigator.pop(context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Erreur : mot de passe non modifié')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: violetFonce,
        title: const Text('Changer le mot de passe'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _ancienController,
                decoration: const InputDecoration(labelText: 'Ancien mot de passe'),
                obscureText: true,
                validator: (val) => val == null || val.isEmpty ? 'Requis' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _nouveauController,
                decoration: const InputDecoration(labelText: 'Nouveau mot de passe'),
                obscureText: true,
                validator: (val) => val != null && val.length >= 6 ? null : '6 caractères minimum',
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _confirmeController,
                decoration: const InputDecoration(labelText: 'Confirmez le nouveau mot de passe'),
                obscureText: true,
                validator: (val) =>
                val == _nouveauController.text ? null : 'Les mots de passe ne correspondent pas',
              ),
              const SizedBox(height: 32),
              _isLoading
                  ? const CircularProgressIndicator()
                  : ElevatedButton(
                onPressed: _changerMotDePasse,
                child: const Text('Valider'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
