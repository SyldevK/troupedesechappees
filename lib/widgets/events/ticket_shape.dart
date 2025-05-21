import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import 'InvertedTicketClipper.dart';
import 'TicketBorderPainter.dart';

class TicketShape extends StatelessWidget {
  final String titre;
  final String description;
  final List<DateTime> dates;
  final String lieu;

  const TicketShape({
    super.key,
    required this.titre,
    required this.description,
    required this.dates,
    required this.lieu,
  });

  @override
  Widget build(BuildContext context) {
    final screenW = MediaQuery.of(context).size.width;
    final isMobile = !kIsWeb && screenW < 600;

    // --- VERSION MOBILE : même forme, contenu en colonne ---
    if (isMobile) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: CustomPaint(
          painter: TicketBorderPainter(),
          child: ClipPath(
            clipper: InvertedTicketClipper(),
            child: Container(
              color: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Titre
                  Text(
                    titre,
                    style: GoogleFonts.poppins(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF6C3A87),
                    ),
                  ),
                  const SizedBox(height: 12),

                  // Description
                  Text(
                    description,
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      color: const Color(0xFF6C3A87),
                    ),
                  ),
                  const SizedBox(height: 10),

                  // Dates
                  for (int i = 0; i < dates.length; i++) ...[
                    Padding(
                      padding: EdgeInsets.only(top: i == 0 ? 0 : 4),
                      child: Row(
                        children: [
                          if (i == 0)
                            const Icon(Icons.event,
                                color: Color(0xFF6C3A87), size: 16)
                          else
                            const SizedBox(width: 24),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              DateFormat('EEEE dd MMM yyyy à HH:mm', 'fr_FR')
                                  .format(dates[i]),
                              style: GoogleFonts.poppins(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: const Color(0xFF6C3A87),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                  const SizedBox(height: 8),

                  // Lieu
                  Row(
                    children: [
                      const Icon(Icons.location_on,
                          color: Color(0xFF6C3A87), size: 16),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          lieu,
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            color: const Color(0xFF6C3A87),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // Bouton centré
                  Center(
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFE5B5F3),
                        foregroundColor: Colors.white,
                        textStyle: GoogleFonts.poppins(
                            fontWeight: FontWeight.bold, fontSize: 16),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 32, vertical: 14),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                      ),
                      child: const Text('Réserver'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }

    // --- VERSION DESKTOP / TABLETTE (inchangée) ---
    return SizedBox(
      width: 650,
      height: 330,
      child: Stack(
        children: [
          // Icône ticket
          Positioned(
            top: 0,
            left: 0,
            bottom: 230,
            child: Transform.rotate(
              angle: -0.3,
              child: Image.asset(
                'assets/images/ticket_icon.png',
                width: 72,
                height: 80,
              ),
            ),
          ),

          // Bordure intérieure
          CustomPaint(
            painter: TicketBorderPainter(),
            size: const Size(650, 330),
          ),

          // Contenu du ticket
          ClipPath(
            clipper: InvertedTicketClipper(),
            child: Container(
              color: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 24),
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 505),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Titre
                      Text(
                        titre,
                        style: GoogleFonts.poppins(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFF6C3A87),
                        ),
                      ),
                      const SizedBox(height: 12),

                      // Description
                      Text(
                        description,
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          color: const Color(0xFF6C3A87),
                        ),
                      ),
                      const SizedBox(height: 10),

                      // Liste des dates
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          for (int i = 0; i < dates.length; i++)
                            Padding(
                              padding: EdgeInsets.only(top: i == 0 ? 0 : 4),
                              child: Row(
                                children: [
                                  if (i == 0)
                                    const Icon(Icons.event,
                                        color: Color(0xFF6C3A87), size: 16)
                                  else
                                    const SizedBox(width: 24),
                                  const SizedBox(width: 8),
                                  Flexible(
                                    child: Text(
                                      DateFormat(
                                          'EEEE dd MMM yyyy à HH:mm',
                                          'fr_FR')
                                          .format(dates[i]),
                                      style: GoogleFonts.poppins(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: const Color(0xFF6C3A87),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                        ],
                      ),

                      const SizedBox(height: 8),

                      // Lieu
                      Row(
                        children: [
                          const Icon(Icons.location_on,
                              color: Color(0xFF6C3A87), size: 16),
                          const SizedBox(width: 8),
                          Flexible(
                            child: Text(
                              lieu,
                              style: GoogleFonts.poppins(
                                fontSize: 14,
                                color: const Color(0xFF6C3A87),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      const Spacer(),

                      // Bouton réserver centré
                      Align(
                        alignment: Alignment.center,
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFE5B5F3),
                            foregroundColor: Colors.white,
                            textStyle: GoogleFonts.poppins(
                                fontWeight: FontWeight.bold, fontSize: 16),
                            padding: const EdgeInsets.symmetric(
                                vertical: 14, horizontal: 32),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                          ),
                          child: const Text('Réserver'),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
