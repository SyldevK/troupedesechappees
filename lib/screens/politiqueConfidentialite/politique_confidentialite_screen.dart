import 'package:flutter/material.dart';

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
      body: const SingleChildScrollView(
        padding: EdgeInsets.all(24),
        child: PolitiqueConfidentialiteContent(),
      ),
    );
  }
}

class PolitiqueConfidentialiteContent extends StatelessWidget {
  const PolitiqueConfidentialiteContent({super.key});

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
        Text("Préambule", style: titleStyle),
        const SizedBox(height: 8),
        Text(
          "La présente politique de confidentialité a pour but d’informer les utilisateurs du site de La Troupe des Échappées des modalités de collecte, de traitement et de protection de leurs données personnelles.",
          style: textStyle,
        ),

        const SizedBox(height: 24),
        Text("Responsable du traitement", style: titleStyle),
        const SizedBox(height: 8),
        Text(
          "La Troupe des Échappées\n7 Place du chêne vert\n35310 CINTRÉ\nEmail : latroupedesechappees@gmail.com",
          style: textStyle,
        ),

        const SizedBox(height: 24),
        Text("Données collectées", style: titleStyle),
        const SizedBox(height: 8),
        Text(
          "Nous collectons des données personnelles uniquement lorsque cela est nécessaire, notamment dans les cas suivants: \n"
              ". Formulaires d'inscription aux ateliers \n"
              ". Formulaires de réservation pour les spectacles \n"
              ". Formulaire de contact",

          style: textStyle,
        ),

        const SizedBox(height: 24),
        Text("Utilisation des données", style: titleStyle),
        const SizedBox(height: 8),
        Text(
          "Les données personnelles collectées sont exclusivement utilisées pour : \n"
          ". La gestion des inscriptions et réservations \n"
          ". La communication avec les adhérents ou les personnes intéressées \n"
          ". L'amélioration des services proposés par l'association",
          style: textStyle,
        ),

        const SizedBox(height: 24),
        Text("Partage des données", style: titleStyle),
        const SizedBox(height: 8),
        Text(
          "Les données ne sont jamais cédées ni revendues à des tiers. Elles peuvent être partagées uniquement avec : \n"
          ". Les membres habilités de l'association pour le bon fonctionnement des activités \n"
          ". Des prestataires techniques (ex. : hébergeur ou service de mailing) dans le respect du RGPD",
          style: textStyle,
        ),

        const SizedBox(height: 24),
        Text("Conservation", style: titleStyle),
        const SizedBox(height: 8),
        Text(
          "Les données sont conservées pendant une durée maximale de 3 ans à compter du dernier contact ou de la dernière participation à une activité.",
          style: textStyle,
        ),

        const SizedBox(height: 24),
        Text("Droits des utilisateurs", style: titleStyle),
        const SizedBox(height: 8),
        Text(
          "Conformément au Règlement Général sur la Protection des Données (RGPD), vous disposez des droits suivants : \n"
          ". Droit d'accès à vos données \n"
          ". Droit de rectification ou de suppression \n"
          ". Droit de portabilité \n"
          ". Droit de limitation ou d'opposition au traitement \n"
          "Vous pouvez exercer ces droits en nous contactant à l'adresse : latroupedesechappees@gmail.com",
          style: textStyle,
        ),

        const SizedBox(height: 24),
        Text("Cookies", style: titleStyle),
        const SizedBox(height: 8),
        Text(
          "Le site ne dépose actuellement aucun cookie à des fins de suivi, publicité ou statistiques."
          "Dans le cas où cela évoluerait, un système de gestion du consentement sera mis en place conformément au RGPD.",
          style: textStyle,
        ),

        const SizedBox(height: 24),
        Text("Dernière mise à jour : [à compléter]", style: textStyle),
      ],
    );
  }
}
