// lib/screens/inscription_atelier/inscription_atelier_form.dart

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../services/atelier_service.dart';
import '../../widgets/ateliers/droit_image_dialog.dart';

class InscriptionAtelierForm extends StatefulWidget {
  const InscriptionAtelierForm({super.key});

  @override
  State<InscriptionAtelierForm> createState() => _InscriptionAtelierFormState();
}

class _InscriptionAtelierFormState extends State<InscriptionAtelierForm> {
  final _formKey = GlobalKey<FormState>();

  final nomController = TextEditingController();
  final prenomController = TextEditingController();
  final emailController = TextEditingController();
  final telController = TextEditingController();
  final dateNaissanceController = TextEditingController();
  final horairesSouhaitesController = TextEditingController();

  String? groupeAge;
  bool accepteConditions = false;
  bool accepteDroitImage = false;

  final Color violetFonce = const Color(0xFF6C3A87);

  @override
  void dispose() {
    nomController.dispose();
    prenomController.dispose();
    emailController.dispose();
    telController.dispose();
    dateNaissanceController.dispose();
    horairesSouhaitesController.dispose();
    super.dispose();
  }

  void _envoyerDemande() async {
    if (_formKey.currentState!.validate() && accepteConditions) {
      try {
        await sendInscriptionRequest(
          nom: nomController.text.trim(),
          prenom: prenomController.text.trim(),
          email: emailController.text.trim(),
          groupe: groupeAge ?? 'Non précisé',
        );

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Demande envoyée avec succès !")),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Erreur : ${e.toString()}")),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Veuillez remplir tous les champs obligatoires.")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 700),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 32),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Icon(Icons.theater_comedy, size: 48, color: Color(0xFF6C3A87)),
                  const SizedBox(height: 12),
                  Text("Inscrivez-vous à nos ateliers",
                      style: GoogleFonts.poppins(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: violetFonce)),
                  const SizedBox(height: 4),
                  Text("Impro, jeu, émotions et rires... prêt(e)s à monter sur scène?",
                      style: GoogleFonts.poppins(fontSize: 14, color: violetFonce), textAlign: TextAlign.center),
                ],
              ),
              const SizedBox(height: 24),

              Row(
                children: [
                  Expanded(child: champTexte("Nom", nomController)),
                  const SizedBox(width: 16),
                  Expanded(child: champTexte("Prénom", prenomController)),
                ],
              ),
              champTexte("Email", emailController, type: TextInputType.emailAddress),
              champTexte("Date de naissance", dateNaissanceController, hint: 'JJ/MM/AAAA'),
              champTexte("Téléphone", telController, type: TextInputType.phone),
              const SizedBox(height: 16),

              Text("Groupe d'âge", style: GoogleFonts.poppins(fontWeight: FontWeight.w600, color: violetFonce)),
              const SizedBox(height: 6),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  groupAgeOption("Enfant"),
                  groupAgeOption("Adolescent"),
                  groupAgeOption("Adulte"),
                ],
              ),
              const SizedBox(height: 16),
              champTexte("Horaires souhaités", horairesSouhaitesController, hint: "Lundi 18h, Mercredi après-midi..."),
              const SizedBox(height: 16),

              CheckboxListTile(
                value: accepteConditions,
                onChanged: (val) => setState(() => accepteConditions = val ?? false),
                title: Text("J'accepte que mes données soient utilisées pour l'inscription à un atelier.", style: GoogleFonts.poppins(fontSize: 14)),
                controlAffinity: ListTileControlAffinity.leading,
                contentPadding: EdgeInsets.zero,
              ),

              CheckboxListTile(
                value: accepteDroitImage,
                onChanged: (val) {
                  setState(() => accepteDroitImage = val ?? false);
                  if (val == true) {
                    showDialog(
                      context: context,
                      builder: (context) => const DroitImageDialog(),
                    );
                  }
                },
                title: Text("J'accepte le droit à l'image (photos, vidéos durant les ateliers)", style: GoogleFonts.poppins(fontSize: 14)),
                controlAffinity: ListTileControlAffinity.leading,
                contentPadding: EdgeInsets.zero,
              ),

              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _envoyerDemande,
                style: ElevatedButton.styleFrom(
                  backgroundColor: violetFonce,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                ),
                child: Text("Envoyer ma demande", style: GoogleFonts.poppins(fontWeight: FontWeight.bold)),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget champTexte(String label, TextEditingController controller, {TextInputType? type, String? hint}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: GoogleFonts.poppins(fontWeight: FontWeight.w600, color: violetFonce)),
          const SizedBox(height: 6),
          TextFormField(
            controller: controller,
            keyboardType: type,
            validator: (value) => value == null || value.isEmpty ? 'Champ obligatoire' : null,
            style: GoogleFonts.poppins(color: Colors.white, fontWeight: FontWeight.bold),
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: GoogleFonts.poppins(color: Colors.white),
              filled: true,
              fillColor: violetFonce,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide.none,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget groupAgeOption(String label) {
    return Row(
      children: [
        Radio<String>(
          value: label,
          groupValue: groupeAge,
          onChanged: (value) => setState(() => groupeAge = value),
          activeColor: violetFonce,
        ),
        Text(label, style: GoogleFonts.poppins()),
      ],
    );
  }
}