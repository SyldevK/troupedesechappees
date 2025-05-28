import 'dart:io';
import 'package:flutter/foundation.dart';

String buildLocalImageUrl(String imagePath) {
  const domain = 'http://tie.test';

  if (kIsWeb) {
    return '$domain$imagePath';
  } else if (Platform.isAndroid) {
    return 'http://10.0.2.2$imagePath';
  } else {
    return '$domain$imagePath';
  }
}
