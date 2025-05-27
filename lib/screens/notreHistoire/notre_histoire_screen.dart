import 'package:flutter/material.dart';
import 'package:troupedesechappees/widgets/app_footer.dart';

import '../../widgets/app_header.dart';

class NotreHistoireScreen extends StatelessWidget {
  const NotreHistoireScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const violetFonce = Color(0xFF62267D);
    return Scaffold(
      endDrawer: const AppDrawer(),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const AppHeader(isHome: false),
            Padding(
              padding: const EdgeInsets.all(24),
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 1000),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Center(
                        child: Column(
                          children: [
                            Text(
                              "Notre histoire",
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: violetFonce,
                              ),
                            ),
                            SizedBox(height: 8),
                            Text(
                              "Le rideau se lève sur une aventure humaine, artistique et généreuse.",
                              style: TextStyle(
                                fontSize: 16,
                                color: violetFonce,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 32),
                      _ActeWidget(
                        titre: "ACTE I – La naissance",
                        texte:
                            "L'association a été fondée en 2001 par des passionnés du théâtre...",
                        imagePath: 'assets/images/masques.png',
                        imageLeft: false,
                      ),
                      _ActeWidget(
                        titre: "ACTE II – Les premières scènes",
                        texte:
                            "Integer non nulla consectetur mauris feugiat euismod...",
                        imagePath: 'assets/images/carousel1.jpg',
                        imageLeft: true,
                      ),
                      _ActeWidget(
                        titre: "ACTE III – La croissance",
                        texte:
                            "Phasellus luctus, ex accumsan laoreet cursus...",
                        imagePath: 'assets/images/carousel8.jpg',
                        imageLeft: false,
                      ),
                      _ActeWidget(
                        titre: "ACTE IV – Aujourd'hui et demain",
                        texte:
                            "Suspendisse potenti. Donec vitae venenatis nisl...",
                        imagePath: 'assets/images/femmes.jpg',
                        imageLeft: true,
                      ),
                      const SizedBox(height: 48),
                    ],
                  ),
                ),
              ),
            ),
            const AppFooter(),
          ],
        ),
      ),
    );
  }
}

class _ActeWidget extends StatelessWidget {
  final String titre;
  final String texte;
  final String imagePath;
  final bool imageLeft;

  const _ActeWidget({
    required this.titre,
    required this.texte,
    required this.imagePath,
    this.imageLeft = false,
  });

  @override
  Widget build(BuildContext context) {
    const violetFonce = Color(0xFF62267D);
    final isMobile = MediaQuery.of(context).size.width < 600;

    final imageWidget = ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: Image.asset(
        imagePath,
        width:
            isMobile && titre.contains("ACTE I")
                ? 220
                : (isMobile ? double.infinity : 160),
        height:
            isMobile && titre.contains("ACTE I") ? 150 : (isMobile ? 200 : 120),
        fit: BoxFit.cover,
      ),
    );

    final image =
        isMobile && titre.contains("ACTE I")
            ? Center(child: imageWidget)
            : imageWidget;

    final texteWidget = Padding(
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 0 : 16,
        vertical: isMobile ? 12 : 0,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            titre,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
              color: violetFonce,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            texte,
            style: const TextStyle(
              fontSize: 14,
              color: violetFonce,
              height: 1.5,
            ),
          ),
        ],
      ),
    );

    return Padding(
      padding: const EdgeInsets.only(bottom: 32),
      child:
          isMobile
              ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [image, texteWidget],
              )
              : Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children:
                    imageLeft
                        ? [image, Expanded(child: texteWidget)]
                        : [Expanded(child: texteWidget), image],
              ),
    );
  }
}
