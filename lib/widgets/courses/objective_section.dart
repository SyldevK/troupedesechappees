import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ObjectivesSection extends StatelessWidget {
  const ObjectivesSection({super.key});

  final List<Map<String, dynamic>> objectives = const [
    {'icon': Icons.mic, 'text': 'Prendre la parole\nen public'},
    {'icon': Icons.theater_comedy, 'text': 'Explorer ses\némotions'},
    {'icon': Icons.groups, 'text': 'Travailler en groupe'},
    {'icon': Icons.emoji_emotions, 'text': 'S’épanouir par le jeu'},
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 54),
        Text(
          "Objectifs pédagogiques",
          style: GoogleFonts.poppins(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: const Color(0xFF6C3A87),
          ),
        ),
        const SizedBox(height: 32),
        LayoutBuilder(
          builder: (context, constraints) {
            final isMobile = constraints.maxWidth < 600;

            final List<Widget> children = objectives.map((obj) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 12.0),
                child: SizedBox(
                  width: isMobile ? double.infinity : 120,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: const Color(0xFF6C3A87),
                            width: 1,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.3),
                              blurRadius: 10,
                              offset: const Offset(3, 6),
                            ),
                          ],
                        ),
                        child: Icon(
                          obj['icon'],
                          size: 50,
                          color: const Color(0xFF6C3A87),
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        obj['text'],
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          color: const Color(0xFF6C3A87),
                          height: 1.3,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              );
            }).toList();

            return isMobile
                ? Column(children: children)
                : Wrap(
              spacing: 32,
              runSpacing: 24,
              alignment: WrapAlignment.center,
              children: children,
            );
          },
        ),
        const SizedBox(height: 30),
      ],
    );
  }
}