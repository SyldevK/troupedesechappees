import 'package:flutter/material.dart';

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
      body: const SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 24),
        child: MentionsLegalesContent(),
      ),
    );
  }
}

class MentionsLegalesContent extends StatelessWidget {
  const MentionsLegalesContent({super.key});

  @override
  Widget build(BuildContext context) {
    const Color violetFonce = Color(0xFF62267D);

    TextStyle titleStyle = const TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 18,
      color: violetFonce,
    );

    TextStyle textStyle = const TextStyle(
      fontSize: 14,
      height: 1.6,
      color: violetFonce,
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Éditeur du site", style: titleStyle),
        const SizedBox(height: 8),
        Text(
          "Nom de l'association : La Troupe des Échappées\n"
              "Adresse : 7 Place du chêne vert, Mairie de Cintré, 35310 CINTRÉ, France\n"
              "Adresse email : latroupedesechappees@gmail.com\n"
              "Responsable de la publication : Isabelle TOUFFET",
          style: textStyle,
        ),

        const SizedBox(height: 24),
        Text("Hébergeur du site", style: titleStyle),
        const SizedBox(height: 8),
        Text("Nom de l'hébergeur : [à compléter]\nAdresse : [à compléter]", style: textStyle),

        const SizedBox(height: 24),
        Text("Propriété intellectuelle", style: titleStyle),
        const SizedBox(height: 8),
        Text(
          "Tous les contenus présents sur ce site (textes, images, logo...) sont la propriété de La Troupe des Échappées, sauf mention contraire. "
              "Toute reproduction est interdite sans autorisation écrite préalable.",
          style: textStyle,
        ),

        const SizedBox(height: 24),
        Text("Protection des données personnelles", style: titleStyle),
        const SizedBox(height: 8),
        Text(
          "Ce site peut collecter des données personnelles via les formulaires (inscriptions, réservations). "
              "Conformément au RGPD, vous pouvez accéder, rectifier ou supprimer vos données en nous contactant.",
          style: textStyle,
        ),

        const SizedBox(height: 24),
        Text("Cookies", style: titleStyle),
        const SizedBox(height: 8),
        Text(
          "Ce site ne dépose actuellement aucun cookie à des fins de suivi ou statistiques. "
              "Si cela change, un bandeau d'information sera mis en place.",
          style: textStyle,
        ),

        const SizedBox(height: 24),
        Text("Dernière mise à jour : [Date à compléter]", style: textStyle),
      ],
    );
  }
}
