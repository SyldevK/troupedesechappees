import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MentionsLegalesScreen extends StatelessWidget {
  const MentionsLegalesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF6C3A87),
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          "Mentions légales",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 900),
            child: const MentionsLegalesContent(),
          ),
        ),
      )

    );
  }
}

class MentionsLegalesContent extends StatelessWidget {
  const MentionsLegalesContent({super.key});

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
          "Éditeur du site",
          "Nom de l'association : La Troupe des Échappées\n"
              "Adresse : 7 Place du chêne vert, Mairie de Cintré, 35310 CINTRÉ, France\n"
              "Adresse email : latroupedesechappees@gmail.com\n"
              "Responsable de la publication : Isabelle TOUFFET",
          icon: Icons.info_outline,
        ),
        section(
          "Hébergeur du site",
          "Nom de l'hébergeur : [à compléter]\nAdresse : [à compléter]",
          icon: Icons.cloud_outlined,
        ),
        section(
          "Propriété intellectuelle",
          "Tous les contenus présents sur ce site (textes, images, logo...) sont la propriété de La Troupe des Échappées, sauf mention contraire. "
              "Toute reproduction est interdite sans autorisation écrite préalable.",
          icon: Icons.copyright_outlined,
        ),
        section(
          "Protection des données personnelles",
          "Ce site peut collecter des données personnelles via les formulaires (inscriptions, réservations). "
              "Conformément au RGPD, vous pouvez accéder, rectifier ou supprimer vos données en nous contactant.",
          icon: Icons.privacy_tip_outlined,
        ),
        section(
          "Cookies",
          "Ce site ne dépose actuellement aucun cookie à des fins de suivi ou statistiques. "
              "Si cela change, un bandeau d'information sera mis en place.",
          icon: Icons.cookie_outlined,
        ),
        section(
          "Dernière mise à jour",
          "[Date à compléter]",
          icon: Icons.update,
        ),
      ],
    );
  }
}
