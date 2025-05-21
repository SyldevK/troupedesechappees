import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:carousel_slider/carousel_slider.dart';

class CarouselSection extends StatelessWidget {
  const CarouselSection({super.key});

  String getImagePath(String fileName) => 'assets/images/$fileName';

  @override
  Widget build(BuildContext context) {
    final List<String> images = [
      'carousel1.jpg',
      'carousel2.jpg',
      'carousel3.jpg',
      'carousel4.jpg',
      'carousel5.jpg',
      'carousel6.jpg',
      'carousel7.jpg',
      'carousel8.jpg',
    ];

    return CarouselSlider(
      options: CarouselOptions(
        height: 400, // ↑ tu peux ajuster selon le design
        autoPlay: true,
        viewportFraction: 1.0,
        enlargeCenterPage: false,
      ),
      items:
          images.map((fileName) {
            return Stack(
              fit: StackFit.expand,
              children: [
                Image.asset(
                  getImagePath(fileName),
                  fit: BoxFit.cover, // ← la clé pour un rendu visuel équilibré
                ),
                Container(color: Colors.black.withOpacity(0.4)),
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text(
                        'Découvrez la magie du théâtre',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 12),
                      Text(
                        'Une association passionnée par le théâtre\npour enfants, adolescents et adultes.',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ],
            );
          }).toList(),
    );
  }
}
