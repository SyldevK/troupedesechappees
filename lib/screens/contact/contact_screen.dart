import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../services/contact_service.dart';

class ContactScreen extends StatefulWidget {
  const ContactScreen({super.key});

  @override
  State<ContactScreen> createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen> {
  final nomController = TextEditingController();
  final prenomController = TextEditingController();
  final emailController = TextEditingController();
  final messageController = TextEditingController();

  final Color violetFonce = const Color(0xFF6C3A87);

  @override
  void dispose() {
    nomController.dispose();
    prenomController.dispose();
    emailController.dispose();
    messageController.dispose();
    super.dispose();
  }

  void _envoyerMessage() async {
    final nom = nomController.text.trim();
    final prenom = prenomController.text.trim();
    final email = emailController.text.trim();
    final message = messageController.text.trim();

    if (nom.isEmpty || prenom.isEmpty || email.isEmpty || message.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Merci de remplir tous les champs.")),
      );
      return;
    }

    bool success = await ContactService.envoyerMessage(
      nom: nom,
      prenom: prenom,
      email: email,
      message: message,
    );

    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Message envoyé avec succès !")),
      );
      nomController.clear();
      prenomController.clear();
      emailController.clear();
      messageController.clear();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Erreur lors de l’envoi du message.")),
      );
    }
  }

  Widget champTexte(String label, TextEditingController controller, {int maxLines = 1}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: GoogleFonts.poppins(fontWeight: FontWeight.w600, color: violetFonce)),
          const SizedBox(height: 6),
          TextFormField(
            controller: controller,
            maxLines: maxLines,
            style: GoogleFonts.poppins(color: Colors.black87, fontWeight: FontWeight.w500),
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              hintStyle: GoogleFonts.poppins(color: Colors.grey),
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: violetFonce.withOpacity(0.2)),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: violetFonce.withOpacity(0.2)),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isLargeScreen = MediaQuery.of(context).size.width > 600;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: violetFonce,
        title: Text("Contact", style: GoogleFonts.poppins(color: Colors.white)),
      ),
      body: Stack(
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              height: 300,
              width: double.infinity,
              color: const Color(0xFFF9ECFC),
            ),
          ),
          Column(
            children: [
              const SizedBox(height: 32),
              Text("Contactez -nous", style: GoogleFonts.poppins(fontSize: 24, fontWeight: FontWeight.bold, color: violetFonce)),
              const SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  "Une question? Une inscription? Un mot doux? Le rideau est ouvert.",
                  style: GoogleFonts.poppins(fontSize: 14, color: Colors.black87),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 30),
              Expanded(
                child: Center(
                  child: Container(
                    constraints: const BoxConstraints(maxWidth: 900),
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
                    child: isLargeScreen
                        ? Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(flex: 3, child: _buildFormCard()),
                        const SizedBox(width: 24),
                        Expanded(flex: 2, child: _buildContactCard()),
                      ],
                    )
                        : Column(
                      children: [
                        _buildFormCard(),
                        const SizedBox(height: 24),
                        _buildContactCard(),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFormCard() {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12), side: BorderSide(color: violetFonce.withOpacity(0.2))),
      elevation: 6,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            champTexte("Nom", nomController),
            champTexte("Prénom", prenomController),
            champTexte("Email", emailController),
            champTexte("Message", messageController, maxLines: 5),
            const SizedBox(height: 16),
            Align(
              alignment: Alignment.center,
              child: ElevatedButton(
                onPressed: _envoyerMessage,
                style: ElevatedButton.styleFrom(
                  backgroundColor: violetFonce,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                ),
                child: Text("Envoyez ma demande", style: GoogleFonts.poppins(fontWeight: FontWeight.bold)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContactCard() {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 6,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text("Coordonnées", style: GoogleFonts.poppins(fontWeight: FontWeight.bold, fontSize: 16, color: violetFonce)),
            const SizedBox(height: 10),
            Row(children: [const Icon(Icons.location_on, size: 16), const SizedBox(width: 8), const Expanded(child: Text("2 place du chêne vert\nMairie de cintré\n35310 CINTRÉ France"))]),
            const SizedBox(height: 8),
            Row(children: [const Icon(Icons.phone, size: 16), const SizedBox(width: 8), const Text("01 23 45 67 89")]),
            const SizedBox(height: 8),
            Row(children: [const Icon(Icons.email, size: 16), const SizedBox(width: 8), Flexible(child: const Text("latroupedesechappees@gmail.com"))]),
          ],
        ),
      ),
    );
  }
}
