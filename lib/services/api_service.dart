import 'package:flutter/foundation.dart' show kIsWeb;
import 'dart:io' show Platform;

class ApiService {
  static String getBaseUrl() {
    if (kIsWeb) {
      return 'http://tie.test';
    } else if (Platform.isAndroid) {
      return 'http://10.0.2.2';
    } else {
      return 'http://localhost';
    }
  }
}
