// lib/models/gallery_item.dart

/// Les catégories possibles pour les éléments de la galerie
enum GalleryCategory { All, Ateliers, Spectacles, Coulisse, Videos }

/// Extension pour obtenir le libellé affiché
extension GalleryCategoryExtension on GalleryCategory {
  String get label {
    switch (this) {
      case GalleryCategory.All:
        return 'Tous';
      case GalleryCategory.Ateliers:
        return 'Ateliers';
      case GalleryCategory.Spectacles:
        return 'Spectacles';
      case GalleryCategory.Coulisse:
        return 'En coulisse';
      case GalleryCategory.Videos:
        return 'Vidéos';
    }
  }

  /// Convertit une chaîne en GalleryCategory, ou All par défaut
  static GalleryCategory fromString(String value) {
    return GalleryCategory.values.firstWhere(
          (c) => c.label.toLowerCase() == value.toLowerCase(),
      orElse: () => GalleryCategory.All,
    );
  }
}

/// Modèle représentant un élément de la galerie
class GalleryItem {
  final int id;
  final String url;
  final String title;
  final String description;
  final GalleryCategory category;

  GalleryItem({
    required this.id,
    required this.url,
    required this.title,
    required this.description,
    required this.category,
  });

  /// Créé une instance depuis un JSON retourné par l'API
  factory GalleryItem.fromJson(Map<String, dynamic> json) {
    // Lecture du nom de catégorie dans l'objet "categorie"
    final catName = (json['categorie'] as Map<String, dynamic>)['nom'] as String;
    final category = GalleryCategoryExtension.fromString(catName);

    return GalleryItem(
      id: json['id'] as int,
      url: json['url'] as String,
      title: json['titre'] as String,
      description: json['description'] as String,
      category: category,
    );
  }

  /// Sérialisation en JSON (utile pour tests ou envoi)
  Map<String, dynamic> toJson() => {
    'id': id,
    'url': url,
    'titre': title,
    'description': description,
    'categorie': {'nom': category.label},
  };
}
