import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/spectacle.dart';
import 'dart:io' show Platform;
import 'package:flutter/foundation.dart' show kIsWeb;



class SpectacleService {
  // Base URL dynamique selon la plateforme
  static String get _baseUrl {
    if (kIsWeb) {
      return 'http://tie.test/api';
    } else if (Platform.isAndroid) {
      return 'http:// 192.168.1.41:8000/api';
    } else {
      return 'http://localhost:8000/api';
    }
  }

  // spectacle à venir
  static Future<Spectacle?> fetchDernierSpectacle() async {
    final url = Uri.parse('$_baseUrl/events?isVisible=true');
    print('🟣 Appel API vers $url');

    final response = await http.get(url);
    print('🟢 Status: ${response.statusCode}');
    print('📦 Body: ${response.body}');

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      final List<dynamic> data = json['member'] ?? [];

      final spectacles = data.map((e) => Spectacle.fromJson(e)).toList();

      // Filtrer ceux à venir et trier par date
      final now = DateTime.now();
      spectacles.removeWhere((s) =>
      s.dates.isEmpty || s.dates.first.dateTime.isBefore(now));
      spectacles.sort((a, b) =>
          a.dates.first.dateTime.compareTo(b.dates.first.dateTime));
      return spectacles.isNotEmpty ? spectacles.first : null;
    }

    return null;
  }

  //  Deux derniers spectacles passés
  static Future<List<Spectacle>> fetchLastTwoSpectacles() async {
    final url = Uri.parse('$_baseUrl/events?isVisible=true');
    print('🟣 Appel API vers $url');

    final response = await http.get(url);
    print('🟢 Status: ${response.statusCode}');
    print('📦 Body: ${response.body}');

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      final List<dynamic> data = json['member'] ?? [];

      final spectacles = data.map((e) => Spectacle.fromJson(e)).toList();

      // Filtrer les passés et trier par date décroissante
      final now = DateTime.now();
      spectacles.removeWhere((s) =>
      s.dates.isEmpty || s.dates.last.dateTime.isAfter(now));
      spectacles.sort((a, b) =>
          b.dates.last.dateTime.compareTo(a.dates.last.dateTime));
      return spectacles.take(2).toList();
    }

    return [];
  }
}
