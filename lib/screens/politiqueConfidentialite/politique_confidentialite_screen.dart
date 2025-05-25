import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PolitiqueConfidentialiteScreen extends StatelessWidget {
  const PolitiqueConfidentialiteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Politique de confidentialité", style: TextStyle(color: Colors.white)),
        backgroundColor: const Color(0xFF6C3A87),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 900),
            child: const PolitiqueConfidentialiteContent(),
          ),
        ),
      )

    );
  }
}

class PolitiqueConfidentialiteContent extends StatelessWidget {
  const PolitiqueConfidentialiteContent({super.key});

  @override
  Widget build(BuildContext context) {
    const Color violetFonce = Color(0xFF62267D);

    TextStyle titleStyle = GoogleFonts.poppins(
      fontWeight: FontWeight.bold,
      fontSize: 18,
      color: violetFonce,
    );

    TextStyle textStyle = GoogleFonts.poppins(
      fontSize: 14,
      height: 1.7,
      color: violetFonce,
    );

    Widget section(String title, String content, {IconData? icon}) {
      return Card(
        margin: const EdgeInsets.only(bottom: 24),
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  if (icon != null)
                    Icon(icon, color: violetFonce, size: 20),
                  if (icon != null)
                    const SizedBox(width: 8),
                  Text(title, style: titleStyle),
                ],
              ),
              const SizedBox(height: 10),
              Text(content, style: textStyle),
            ],
          ),
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        section(
          "Préambule",
          "La présente politique de confidentialité a pour but d’informer les utilisateurs du site de La Troupe des Échappées des modalités de collecte, de traitement et de protection de leurs données personnelles.",
          icon: Icons.privacy_tip_outlined,
        ),
        section(
          "Responsable du traitement",
          "La Troupe des Échappées\n7 Place du chêne vert\n35310 CINTRÉ\nEmail : latroupedesechappees@gmail.com",
          icon: Icons.person_outline,
        ),
        section(
          "Données collectées",
          "Nous collectons des données personnelles uniquement lorsque cela est nécessaire, notamment dans les cas suivants:\n"
              "• Formulaires d'inscription aux ateliers\n"
              "• Formulaires de réservation pour les spectacles\n"
              "• Formulaire de contact",
          icon: Icons.assignment_outlined,
        ),
        section(
          "Utilisation des données",
          "Les données personnelles collectées sont exclusivement utilisées pour :\n"
              "• La gestion des inscriptions et réservations\n"
              "• La communication avec les adhérents ou les personnes intéressées\n"
              "• L'amélioration des services proposés par l'association",
          icon: Icons.settings_outlined,
        ),
        section(
          "Partage des données",
          "Les données ne sont jamais cédées ni revendues à des tiers. Elles peuvent être partagées uniquement avec :\n"
              "• Les membres habilités de l'association\n"
              "• Des prestataires techniques (hébergeur, email), dans le respect du RGPD",
          icon: Icons.share_outlined,
        ),
        section(
          "Conservation",
          "Les données sont conservées pendant une durée maximale de 3 ans à compter du dernier contact ou de la dernière activité.",
          icon: Icons.timelapse_outlined,
        ),
        section(
          "Droits des utilisateurs",
          "Conformément au RGPD, vous disposez des droits suivants :\n"
              "• Droit d'accès à vos données\n"
              "• Droit de rectification ou suppression\n"
              "• Droit de portabilité\n"
              "• Droit d'opposition ou limitation du traitement\n\n"
              "Vous pouvez exercer ces droits à : latroupedesechappees@gmail.com",
          icon: Icons.lock_open_outlined,
        ),
        section(
          "Cookies",
          "Le site ne dépose actuellement aucun cookie à des fins de suivi, publicité ou statistiques. Si cela change, un bandeau de consentement sera mis en place.",
          icon: Icons.cookie_outlined,
        ),
        section(
          "Dernière mise à jour",
          "[à compléter]",
          icon: Icons.update_outlined,
        ),
      ],
    );
  }
}
