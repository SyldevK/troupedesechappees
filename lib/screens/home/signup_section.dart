import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SignupSection extends StatelessWidget {
  const SignupSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text('Prêt à monter sur scène ?', style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold, color: Color(0xFF6C3A87))),
        const SizedBox(height: 16),
        ElevatedButton(
          onPressed: ()
          {Navigator.pushNamed(context, '/ateliers');},
          style: ButtonStyle(
            backgroundColor: WidgetStateProperty.resolveWith<Color>((
                states,
                ) {
              if (states.contains(WidgetState.hovered)) {
                return const Color(0xFF7D0494);
              }
              return const Color(0xFFE5B5F3);
            }),
            foregroundColor: WidgetStateProperty.all<Color>(Colors.white),
            textStyle: WidgetStateProperty.all<TextStyle>(
              GoogleFonts.poppins(fontWeight: FontWeight.bold),
            ),
            padding: WidgetStateProperty.all<EdgeInsets>(
              const EdgeInsets.symmetric(vertical: 18, horizontal: 24),
            ),
            shape: WidgetStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          child: const Text(
            'S’inscrire à un atelier',
            style: TextStyle(color: Colors.white),
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}
