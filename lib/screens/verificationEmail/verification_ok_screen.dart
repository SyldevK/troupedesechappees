import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class VerificationOkScreen extends StatelessWidget {
  const VerificationOkScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Vérification réussie"),
        backgroundColor: const Color(0xFF6C3A87),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.check_circle, size: 80, color: Colors.green),
              const SizedBox(height: 20),
              Text(
                "Votre compte a bien été vérifié !",
                style: GoogleFonts.poppins(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
