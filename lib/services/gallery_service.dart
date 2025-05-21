// lib/services/gallery_service.dart

import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/GalleryItem.dart';
import 'dart:io' show Platform;
import 'package:flutter/foundation.dart' show kIsWeb;

class GalleryService {
  const GalleryService._(); // Constructeur privé pour empêcher l'instanciation

  static String get _baseApi {
    if (kIsWeb) return 'http://tie.test/api';
    if (Platform.isAndroid) return 'http://10.0.2.2:8000/api';
    return 'http://localhost:8000/api';
  }

  /// Récupère tous les médias (optionnel filtre par catégorie)
  static Future<List<GalleryItem>> fetchItems({GalleryCategory? filter}) async {
    final queryParams = <String, String>{'_format': 'json'};
    if (filter != null && filter != GalleryCategory.All) {
      queryParams['categorie.nom'] = filter.label;
    }
    final url = Uri.parse('$_baseApi/media').replace(queryParameters: queryParams);
    print('🟣 Appel API Galerie → \$url');

    final response = await http.get(url);
    print('🟢 Status Galerie : \${response.statusCode}');
    print('📦 Body Galerie : \${response.body}');

    if (response.statusCode != 200) {
      throw Exception('Erreur chargement galerie (\${response.statusCode})');
    }

    final decoded = jsonDecode(response.body) as Map<String, dynamic>;
    final rawList = decoded['member'] as List<dynamic>? ?? <dynamic>[];

    return rawList.map((e) => GalleryItem.fromJson(e as Map<String, dynamic>)).toList();
  }
}