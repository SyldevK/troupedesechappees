// ==========================
// lib/main.dart
// ==========================
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:troupedesechappees/providers/auth_provider.dart';
import 'package:troupedesechappees/app.dart';
import 'package:flutter_web_plugins/url_strategy.dart';

void main() {
  setUrlStrategy(const HashUrlStrategy());

  runApp(
    ChangeNotifierProvider(
      create: (_) => AuthProvider(),
      child: const TroupeDesEchappeesApp(),
    ),
  );
}
