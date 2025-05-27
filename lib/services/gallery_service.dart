import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/GalleryItem.dart';
import 'dart:io' show Platform;
import 'package:flutter/foundation.dart' show kIsWeb;

class GalleryService {
  const GalleryService._();

  static String get _baseApi {
    if (kIsWeb) return 'https://b73e-2a01-cb08-8b47-9900-b0fe-f49e-21fd-4b3e.ngrok-free.app/api';
    if (Platform.isAndroid) return 'https://b73e-2a01-cb08-8b47-9900-b0fe-f49e-21fd-4b3e.ngrok-free.app/api';
    return 'http://localhost:8000/api';
  }
  static Future<List<GalleryItem>> fetchItems({GalleryCategory? filter}) async {
    final queryParams = <String, String>{'_format': 'json'};
    if (filter != null && filter != GalleryCategory.All) {
      queryParams['categorie.nom'] = filter.label;
    }
    final url = Uri.parse('$_baseApi/media').replace(queryParameters: queryParams);
    final response = await http.get(url);

    if (response.statusCode != 200) {
      throw Exception('Erreur chargement galerie (\${response.statusCode})');
    }

    final decoded = jsonDecode(response.body) as Map<String, dynamic>;
    final rawList = decoded['member'] as List<dynamic>? ?? <dynamic>[];

    return rawList.map((e) => GalleryItem.fromJson(e as Map<String, dynamic>)).toList();
  }
}