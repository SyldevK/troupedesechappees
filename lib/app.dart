import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'package:troupedesechappees/screens/home/home_screen.dart';
import 'package:troupedesechappees/screens/motdepasseoublie/reset_password_screen.dart';
import 'package:troupedesechappees/screens/verificationEmail/erreur_verification_screen.dart';
import 'package:troupedesechappees/screens/verificationEmail/verification_ok_screen.dart';

import 'package:troupedesechappees/providers/gallery_provider.dart';
import 'package:troupedesechappees/router/app_router.dart';

class TroupeDesEchappeesApp extends StatelessWidget {
  const TroupeDesEchappeesApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => GalleryProvider()),
      ],
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
        onGenerateRoute: AppRouter.generateRoute,
        home: const _InitialRedirector(),
      ),
    );
  }
}

class _InitialRedirector extends StatefulWidget {
  const _InitialRedirector();

  @override
  State<_InitialRedirector> createState() => _InitialRedirectorState();
}

class _InitialRedirectorState extends State<_InitialRedirector> {
  bool _loading = true;
  String? _initialPath;
  String? _initialToken;

  @override
  void initState() {
    super.initState();
    initializeDateFormatting('fr_FR', null).then((_) => _handleDeepLink());
  }

  void _handleDeepLink() {
    final fragment = Uri.base.fragment;
    print("🔍 Uri.base.fragment = $fragment");

    final uri = Uri.parse(fragment.startsWith('/') ? fragment : '/$fragment');

    _initialPath = uri.path;
    _initialToken = uri.queryParameters['token'];

    print("📌 _initialPath = $_initialPath");
    print("🔐 _initialToken = $_initialToken");

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_initialPath == '/reset-password' && _initialToken != null) {
        print("✅ Redirection vers ResetPasswordScreen");
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (_) => ResetPasswordScreen(token: _initialToken!),
          ),
        );
      } else if (_initialPath == '/verification-ok') {
        print("✅ Redirection vers VerificationOkScreen");
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (_) => const VerificationOkScreen(),
          ),
        );
      } else if (_initialPath == '/erreur-verification') {
        print("✅ Redirection vers ErreurVerificationScreen");
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (_) => const ErreurVerificationScreen(),
          ),
        );
      } else {
        print("⏩ Redirection vers HomeScreen");
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (_) => const HomeScreen(),
          ),
        );
      }

      setState(() => _loading = false);
    });
  }
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: CircularProgressIndicator()),
    );
  }
}
