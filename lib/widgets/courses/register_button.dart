import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RegisterButton extends StatelessWidget {
  final VoidCallback onPressed;

  const RegisterButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 32),
      child: Align(
        alignment: Alignment.center,
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 300),
          child: ElevatedButton(
            onPressed: onPressed,
            style: ButtonStyle(
              backgroundColor: WidgetStateProperty.resolveWith<Color>((states) {
                if (states.contains(WidgetState.hovered)) {
                  return const Color(0xFF6C3A87);
                }
                return const Color(0xFFE5B5F3);
              }),
              foregroundColor: WidgetStateProperty.all<Color>(Colors.white),
              textStyle: WidgetStateProperty.all<TextStyle>(
                GoogleFonts.poppins(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
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
            child: const Text("S’inscrire à un atelier"),
          ),
        ),
      ),
    );
  }
}
