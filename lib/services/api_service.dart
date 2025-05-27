import 'package:flutter/foundation.dart' show kIsWeb;
import 'dart:io' show Platform;

class ApiService {
  // Base URL pour les appels API (avec /api)
  static String get baseApiUrl {
    if (kIsWeb) {
      return 'https://b73e-2a01-cb08-8b47-9900-b0fe-f49e-21fd-4b3e.ngrok-free.app/api';
    } else if (Platform.isAndroid) {
      return 'https://b73e-2a01-cb08-8b47-9900-b0fe-f49e-21fd-4b3e.ngrok-free.app/api';
    } else {
      return 'http://localhost:8000/api';
    }
  }

  // Base URL pour les assets/images (sans /api)
  static String get baseAssetsUrl {
    if (kIsWeb) {
      return 'https://b73e-2a01-cb08-8b47-9900-b0fe-f49e-21fd-4b3e.ngrok-free.app';
    } else if (Platform.isAndroid) {
      return 'https://b73e-2a01-cb08-8b47-9900-b0fe-f49e-21fd-4b3e.ngrok-free.app';
    } else {
      return 'http://localhost:8000';
    }
  }
}
