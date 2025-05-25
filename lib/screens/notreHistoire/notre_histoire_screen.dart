import 'package:flutter/material.dart';
import 'package:troupedesechappees/widgets/app_footer.dart';

import '../../widgets/app_header.dart';

class NotreHistoireScreen extends StatelessWidget {
  const NotreHistoireScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const violetFonce = Color(0xFF62267D);

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          AppHeader(),
          Expanded(
            child: SingleChildScrollView(
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
                            "L'association a été fondée en 2001 par des passionnés du théâtre. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla pellentesque, nunc id rutrum pharetra, lorem enim sollicitudin nibh, sodales pulvinar nulla lectus in dolor.",
                        imagePath: 'assets/images/masques.png',
                        imageLeft: false,
                      ),
                      _ActeWidget(
                        titre: "ACTE II – Les premières scènes",
                        texte:
                            "Integer non nulla consectetur mauris feugiat euismod. Morbi cursus pellentesque mi, eu fermentum augue imperdiet sed. Praesent id ultrices lacus.",
                        imagePath: 'assets/images/carousel1.jpg',
                        imageLeft: true,
                      ),
                      _ActeWidget(
                        titre: "ACTE III – La croissance",
                        texte:
                            "Phasellus luctus, ex accumsan laoreet cursus, nibh velit malesuada nisl, et hendrerit magna massa nec libero. Sed imperdiet nunc in congue egestas.",
                        imagePath: 'assets/images/carousel8.jpg',
                        imageLeft: false,
                      ),
                      _ActeWidget(
                        titre: "ACTE IV – Aujourd'hui et demain",
                        texte:
                            "Suspendisse potenti. Donec vitae venenatis nisl, efficitur pulvinar magna. Donec semper lorem vel nisl tempor tincidunt.",
                        imagePath: 'assets/images/femmes.jpg',
                        imageLeft: true,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          AppFooter()
        ],
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

    final image = ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: Image.asset(
        imagePath,
        width: isMobile ? double.infinity : 160,
        height: isMobile ? 200 : 120,
        fit: BoxFit.cover,
      ),
    );

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
