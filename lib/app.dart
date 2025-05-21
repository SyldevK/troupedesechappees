// lib/app.dart

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:app_links/app_links.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'package:troupedesechappees/screens/home/home_screen.dart';
import 'package:troupedesechappees/screens/motdepasseoublie/reset_password_screen.dart';
import 'package:troupedesechappees/screens/verificationEmail/erreur_verification_screen.dart';
import 'package:troupedesechappees/screens/verificationEmail/verification_ok_screen.dart';

import 'package:troupedesechappees/providers/gallery_provider.dart';
import 'package:troupedesechappees/router/app_router.dart';

class TroupeDesEchappeesApp extends StatefulWidget {
  const TroupeDesEchappeesApp({super.key});

  @override
  State<TroupeDesEchappeesApp> createState() => _TroupeDesEchappeesAppState();
}

class _TroupeDesEchappeesAppState extends State<TroupeDesEchappeesApp> {
  StreamSubscription? _sub;
  String? _initialToken;
  bool _loading = true;
  late final AppLinks _appLinks;

  @override
  void initState() {
    super.initState();
    initializeDateFormatting('fr_FR', null).then((_) => _handleIncomingLinks());
  }

  Future<void> _handleIncomingLinks() async {
    _appLinks = AppLinks();
    try {
      final uri = await _appLinks.getInitialLink();
      final token = uri?.queryParameters['token'];
      if (token?.isNotEmpty == true) setState(() => _initialToken = token);

      _sub = _appLinks.uriLinkStream.listen(
            (Uri? uri) {
          final t = uri?.queryParameters['token'];
          if (t?.isNotEmpty == true) setState(() => _initialToken = t);
        },
        onError: (err, _) => debugPrint('Erreur deep link : \$err'),
      );
    } catch (e) {
      debugPrint('Erreur deep link: \$e');
    } finally {
      setState(() => _loading = false);
    }
  }

  @override
  void dispose() {
    _sub?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => GalleryProvider())],
      child: MaterialApp(
        title: 'La Troupe des Échappées',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          fontFamily: 'Poppins',
          primaryColor: const Color(0xFF62267D),
          colorScheme: ColorScheme.fromSwatch().copyWith(
            primary: const Color(0xFF62267D),
            secondary: const Color(0xFFD6B8E3),
          ),
          inputDecorationTheme: InputDecorationTheme(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Color(0xFF62267D)),
            ),
          ),
          textTheme: const TextTheme(
            bodyLarge: TextStyle(color: Colors.black87),
            labelLarge: TextStyle(color: Color(0xFF62267D)),
          ),
        ),
        initialRoute: '/home',
        onGenerateRoute: AppRouter.generateRoute,
        home: _buildInitialScreen(),
      ),
    );
  }

  Widget _buildInitialScreen() {
    if (_loading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    final fragment = Uri.base.fragment;
    final uri = Uri.parse('http://fake\$fragment');
    final path = uri.path;
    final token = uri.queryParameters['token'];

    if (path == '/reset-password' && token != null) {
      return ResetPasswordScreen(token: token);
    } else if (path == '/verification-ok') {
      return const VerificationOkScreen();
    } else if (path == '/erreur-verification') {
      return const ErreurVerificationScreen();
    } else if (_initialToken != null) {
      return ResetPasswordScreen(token: _initialToken!);
    }

    return const HomeScreen();
  }
}
