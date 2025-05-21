import 'dart:io';
import 'package:flutter/foundation.dart';

String buildLocalImageUrl(String imagePath) {
  const domain = 'http://tie.test';

  if (kIsWeb) {
    return '$domain$imagePath';
  } else if (Platform.isAndroid) {
    return 'http://10.0.2.2:8000$imagePath'; // Android accède à Laragon via 10.0.2.2
  } else {
    return '$domain$imagePath'; // iOS, macOS, Windows
  }
}
