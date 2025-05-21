import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../services/api_service.dart';

class InscriptionForm extends StatefulWidget {
  const InscriptionForm({super.key});

  @override
  State<InscriptionForm> createState() => _InscriptionFormState();

}

class _InscriptionFormState extends State<InscriptionForm> {
  final nomController = TextEditingController();
  final prenomController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  bool _isSending = false;
  bool _obscurePassword = true;

  @override
  void dispose() {
    nomController.dispose();
    prenomController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> _register() async {
    final nom = nomController.text.trim();
    final prenom = prenomController.text.trim();
    final email = emailController.text.trim();
    final password = passwordController.text;
    final confirmPassword = confirmPasswordController.text;

    if (password != confirmPassword) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Les mots de passe ne correspondent pas."),
        ),
      );
      return;
    }

    setState(() => _isSending = true);
    final platform = kIsWeb ? 'web' : 'mobile';
    try {
      final response = await http.post(
        Uri.parse('${ApiService.getBaseUrl()}/api/register'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'email': email,
          'password': password,
          'nom': nom,
          'prenom': prenom,
          'platform': platform,
        }),
      );

      if (response.statusCode == 201) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text("Inscription réussie !")));
        Navigator.pop(context);
      } else {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text("Erreur : ${response.body}")));
      }
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Erreur réseau.")));
    }

    setState(() => _isSending = false);
  }

  @override
  Widget build(BuildContext context) {
    final violetFonce = const Color(0xFF6C3A87);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          "Nom",
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.w600,
            color: violetFonce,
          ),
        ),
        const SizedBox(height: 6),
        TextField(
          controller: nomController,
          style: GoogleFonts.poppins(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
          decoration: InputDecoration(
            hintText: 'Dupont',
            hintStyle: GoogleFonts.poppins(color: Colors.white.withOpacity(0.5)),
            filled: true,
            fillColor: violetFonce,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide.none,
            ),
          ),
        ),
        const SizedBox(height: 16),
        Text(
          "Prénom",
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.w600,
            color: violetFonce,
          ),
        ),
        const SizedBox(height: 6),
        TextField(
          controller: prenomController,
          style: GoogleFonts.poppins(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
          decoration: InputDecoration(
            hintText: 'Alice',
            hintStyle: GoogleFonts.poppins(color: Colors.white.withOpacity(0.5)),
            filled: true,
            fillColor: violetFonce,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide.none,
            ),
          ),
        ),
        const SizedBox(height: 16),
        // Email
        Text(
          "Email",
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.w600,
            color: violetFonce,
          ),
        ),
        const SizedBox(height: 6),
        TextField(
          controller: emailController,
          style: GoogleFonts.poppins(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
          decoration: InputDecoration(
            hintText: 'exemple@email.com',
            hintStyle: GoogleFonts.poppins(color: Colors.white.withOpacity(0.5)),
            filled: true,
            fillColor: violetFonce,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide.none,
            ),
          ),
        ),
        const SizedBox(height: 16),

        // Mot de passe
        Text(
          "Mot de passe",
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.w600,
            color: violetFonce,
          ),
        ),
        const SizedBox(height: 6),
        TextField(
          controller: passwordController,
          obscureText: _obscurePassword,
          style: GoogleFonts.poppins(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
          decoration: InputDecoration(
            suffixIcon: IconButton(
              icon: Icon(
                _obscurePassword ? Icons.visibility_off : Icons.visibility,
                color: Colors.white,
              ),
              onPressed: () {
                setState(() {
                  _obscurePassword = !_obscurePassword;
                });
              },
            ),

            hintText: '••••••••••',
            hintStyle: GoogleFonts.poppins(color: Colors.white.withOpacity(0.5)),
            filled: true,
            fillColor: violetFonce,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide.none,
            ),
          ),
        ),
        const SizedBox(height: 16),

        // Confirmation
        Text(
          "Confirmation de mot de passe",
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.w600,
            color: violetFonce,
          ),
        ),
        const SizedBox(height: 6),
        TextField(
          controller: confirmPasswordController,
          obscureText: _obscurePassword,
          style: GoogleFonts.poppins(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
          decoration: InputDecoration(
            suffixIcon: IconButton(
              icon: Icon(
                _obscurePassword ? Icons.visibility_off : Icons.visibility,
                color: Colors.white,
              ),
              onPressed: () {
                setState(() {
                  _obscurePassword = !_obscurePassword;
                });
              },
            ),
            hintText: '••••••••••',
            hintStyle: GoogleFonts.poppins(color: Colors.white.withOpacity(0.5)),
            filled: true,
            fillColor: violetFonce,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide.none,
            ),
          ),
        ),
        const SizedBox(height: 20),

        Align(
          alignment: Alignment.center,
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 350),
            child: ElevatedButton(
              onPressed: _isSending ? null : _register,
              style: ButtonStyle(
                backgroundColor: WidgetStateProperty.resolveWith<Color>((
                  states,
                ) {
                  if (states.contains(WidgetState.hovered)) {
                    return violetFonce;
                  }
                  return const Color(0xFFE5B5F3);
                }),
                foregroundColor: WidgetStateProperty.all<Color>(Colors.white),
                textStyle: WidgetStateProperty.all<TextStyle>(
                  GoogleFonts.poppins(fontWeight: FontWeight.bold),
                ),
                padding: WidgetStateProperty.all<EdgeInsets>(
                  const EdgeInsets.symmetric(vertical: 16, horizontal: 30),
                ),
                shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              child:
                  _isSending
                      ? const CircularProgressIndicator(color: Colors.white)
                      : const Text("S'inscrire"),
            ),
          ),
        ),
      ],
    );
  }
}
