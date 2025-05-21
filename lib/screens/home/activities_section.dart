import 'package:flutter/material.dart';

class ActivitiesSection extends StatelessWidget {
  const ActivitiesSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text('Nos Activités', style: TextStyle(fontSize: 24, color: Color(0xFF6C3A87),fontWeight: FontWeight.bold)),
        const SizedBox(height: 20),
        Wrap(
          spacing: 16,
          runSpacing: 16,
          alignment: WrapAlignment.center,
          children: const [
            _ActivityCard(titre: 'Enfants', texte: 'Ateliers ludiques pour développer imagination et expression.'),
            _ActivityCard(titre: 'Ados', texte: 'Explorer des scènes, improviser, préparer des spectacles.'),
            _ActivityCard(titre: 'Adultes', texte: 'Travail d’interprétation, mise en scène et projets collectifs.'),
          ],
        ),
      ],
    );
  }
}

class _ActivityCard extends StatelessWidget {
  final String titre;
  final String texte;

  const _ActivityCard({required this.titre, required this.texte});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Container(
        width: 300,
        height: 150,
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              titre,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: Color(0xFF6C3A87),
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
            Text(
              texte,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}


