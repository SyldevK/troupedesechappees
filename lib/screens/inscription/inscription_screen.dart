import 'package:flutter/material.dart';
import 'inscription_form.dart';

class InscriptionScreen extends StatelessWidget {
  const InscriptionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F5FB),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: AssetImage('assets/images/logo_tie.png'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(height: 32),
              const Text(
                "S'inscrire",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF6C3A87),
                ),
              ),
              const SizedBox(height: 32),
              ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 1000),
                child: InscriptionForm(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
