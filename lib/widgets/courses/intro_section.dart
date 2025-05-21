import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class IntroSection extends StatelessWidget {
  const IntroSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 32),

        // 🖼 Illustration
        Image.asset(
          'assets/images/masques.png',
          height: 150,
        ),

        const SizedBox(height: 24),

        // 🎭 Titre
        Text(
          "Nos cours",
          style: GoogleFonts.poppins(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Color(0xFF6C3A87),
          ),
        ),

        const SizedBox(height: 8),

        // ✨ Sous-titre
        Text(
          "Pour révéler chaque voix, chaque corps, chaque talent…",
          style: GoogleFonts.poppins(
            fontSize: 16,
            fontWeight: FontWeight.w400,
              color: Color(0xFF6C3A87)
          ),
          textAlign: TextAlign.center,
        ),

        const SizedBox(height: 32),
      ],
    );
  }
}
