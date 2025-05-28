import 'package:flutter/foundation.dart' show kIsWeb;
import 'dart:io' show Platform;

class ApiService {
  static String get baseApiUrl {
    if (kIsWeb) {
      return 'http://tie.test';
    } else if (Platform.isAndroid) {
      return 'https://7d66-2a01-cb08-8b47-9900-d93e-433b-320d-f6e4.ngrok-free.app';
    } else {
      return 'http://localhost:8000/api';
    }
  }

  // Base URL pour les assets/images (sans /api)
  static String get baseAssetsUrl {
    if (kIsWeb) {
      return 'http://tie.test';
    } else if (Platform.isAndroid) {
      return 'https://7d66-2a01-cb08-8b47-9900-d93e-433b-320d-f6e4.ngrok-free.app';
    } else {
      return 'http://localhost:8000';
    }
  }
}
