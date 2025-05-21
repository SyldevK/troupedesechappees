import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ErreurVerificationScreen extends StatelessWidget {
  const ErreurVerificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Erreur de vérification"),
        backgroundColor: const Color(0xFF6C3A87),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.error_outline, size: 80, color: Colors.red),
              const SizedBox(height: 20),
              Text(
                "Le lien de vérification est invalide ou expiré.",
                style: GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              TextButton(
                onPressed: () {
                  Navigator.pushReplacementNamed(context, '/login');
                },
                child: Text(
                  "Retour à la connexion",
                  style: GoogleFonts.poppins(
                    color: const Color(0xFF6C3A87),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
