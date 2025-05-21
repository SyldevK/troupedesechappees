import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:troupedesechappees/screens/inscription/inscription_screen.dart';
import '../../providers/auth_provider.dart';
import '../../services/auth_service.dart';
import '../motdepasseoublie/forgot_password_screen.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  bool _obscurePassword = true;
  bool _isLoading = false;

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void _showSnack(String message, {bool error = true}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: error ? Colors.red : Colors.green,
      ),
    );
  }

  Future<void> _handleLogin() async {
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      _showSnack('Veuillez remplir tous les champs');
      return;
    }

    setState(() => _isLoading = true);

    final token = await AuthService.login(email, password);

    if (token != null) {
      await Provider.of<AuthProvider>(context, listen: false).login(token);
      _showSnack('Connexion réussie', error: false);
      Navigator.pushReplacementNamed(context, '/home');
    } else {
      _showSnack('Échec de la connexion');
    }

    setState(() => _isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    final violetFonce = const Color(0xFF6C3A87);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Email
        Text("Email", style: GoogleFonts.poppins(fontWeight: FontWeight.w600, color: violetFonce)),
        const SizedBox(height: 6),
        TextField(
          controller: _emailController,
          style: GoogleFonts.poppins(color: Colors.white, fontWeight: FontWeight.bold),
          decoration: InputDecoration(
            hintText: 'exemple@email.com',
            hintStyle: GoogleFonts.poppins(color: Colors.white.withOpacity(0.5), fontWeight: FontWeight.w100),
            filled: true,
            fillColor: violetFonce,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide.none),
          ),
        ),

        const SizedBox(height: 12),

        // Mot de passe
        Text("Mot de passe", style: GoogleFonts.poppins(fontWeight: FontWeight.w600, color: violetFonce)),
        const SizedBox(height: 6),
        TextField(
          controller: _passwordController,
          obscureText: _obscurePassword,
          style: GoogleFonts.poppins(color: Colors.white, fontWeight: FontWeight.bold),
          decoration: InputDecoration(
            suffixIcon: IconButton(
              icon: Icon(_obscurePassword ? Icons.visibility_off : Icons.visibility, color: Colors.white),
              onPressed: () => setState(() => _obscurePassword = !_obscurePassword),
            ),
            hintText: '••••••••••',
            hintStyle: GoogleFonts.poppins(color: Colors.white.withOpacity(0.5), fontWeight: FontWeight.w100),
            filled: true,
            fillColor: violetFonce,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide.none),
          ),
        ),

        const SizedBox(height: 12),

        // Liens
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextButton(
              onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const InscriptionScreen())),
              child: Text("S’inscrire", style: GoogleFonts.poppins(color: violetFonce, fontWeight: FontWeight.w600)),
            ),
            TextButton(
              onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const ForgotPasswordScreen())),
              child: Text("Mot de passe oublié ?", style: GoogleFonts.poppins(color: violetFonce, fontWeight: FontWeight.w600)),
            ),
          ],
        ),

        const SizedBox(height: 16),

        // Bouton connexion
        Align(
          alignment: Alignment.center,
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 300),
            child: ElevatedButton(
              onPressed: _isLoading ? null : _handleLogin,
              style: ButtonStyle(
                backgroundColor: WidgetStateProperty.resolveWith<Color>(
                      (states) => states.contains(WidgetState.hovered) ? const Color(0xFF7D0494) : const Color(0xFFE5B5F3),
                ),
                foregroundColor: WidgetStateProperty.all<Color>(Colors.white),
                textStyle: WidgetStateProperty.all<TextStyle>(GoogleFonts.poppins(fontWeight: FontWeight.bold)),
                padding: WidgetStateProperty.all<EdgeInsets>(const EdgeInsets.symmetric(vertical: 18, horizontal: 24)),
                shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                ),
              ),
              child: _isLoading
                  ? const SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
              )
                  : const Text("Se connecter"),
            ),
          ),
        ),
      ],
    );
  }
}
