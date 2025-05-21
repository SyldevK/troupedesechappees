import 'package:flutter/material.dart';
import '../../models/spectacle.dart';
import '../../services/spectacle_service.dart';

class NewsSection extends StatefulWidget {
  const NewsSection({super.key});

  @override
  State<NewsSection> createState() => _NewsSectionState();
}

class _NewsSectionState extends State<NewsSection> {
  final Future<Spectacle?> _future = SpectacleService.fetchDernierSpectacle();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(
            'Actualités',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Color(0xFF6C3A87),
            ),
          ),
          const SizedBox(height: 16),
          FutureBuilder<Spectacle?>(
            future: _future,
            builder: (context, snapshot) {
              if (snapshot.connectionState != ConnectionState.done) {
                return const Center(child: CircularProgressIndicator());
              }

              final spectacle = snapshot.data;
              if (spectacle == null || spectacle.dates.isEmpty) {
                return const Text('Aucune actualité pour le moment.');
              }

              final firstDate = spectacle.dates.first;


              return Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Prochain spectacle : "${spectacle.titre}"',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF62267D),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '${_formatDate(firstDate.dateTime)
                      } – ${spectacle.lieu}',
                      textAlign: TextAlign.center,
                      style: const TextStyle(color: Colors.black87),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      spectacle.description,
                      textAlign: TextAlign.center,
                      style: const TextStyle(color: Colors.black87),
                    ),
                    const SizedBox(height: 8),
                    TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/events');
                      },
                      child: const Text(
                        'Voir les détails',
                        style: TextStyle(color: Colors.purple),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year} à ${date.hour}h${date.minute.toString().padLeft(2, '0')}';
  }
}
