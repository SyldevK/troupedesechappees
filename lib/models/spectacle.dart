import 'event_date_model.dart';

class Spectacle {
  final int id;
  final String titre;
  final String description;
  final List<EventDateModel> dates; // ✅ modifié ici
  final String lieu;
  final String? imageUrl;

  Spectacle({
    required this.id,
    required this.titre,
    required this.description,
    required this.dates,
    required this.lieu,
    this.imageUrl,
  });

  factory Spectacle.fromJson(Map<String, dynamic> json) {
    return Spectacle(
      id: json['id'],
      titre: json['titre'] ?? '',
      description: json['description'] ?? '',
      lieu: json['lieu'] ?? '',
      imageUrl: json['imageUrl'],
      dates: (json['dates'] as List<dynamic>)
          .map((e) => EventDateModel.fromJson(e))
          .toList(),
    );
  }
}
