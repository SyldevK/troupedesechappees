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

    final violet = const Color(0xFF6C3A87);

    final textStyle = GoogleFonts.poppins(color: violet);

    final Widget contenu = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          titre,
          style: GoogleFonts.poppins(
            fontSize: 22,
            fontWeight: FontWeight.w800,
            color: violet,
          ),
        ),
        const SizedBox(height: 12),
        Text(
          description,
          style: textStyle.copyWith(fontSize: 14),
        ),
        const SizedBox(height: 12),
        Divider(color: violet.withOpacity(0.2), thickness: 1),
        const SizedBox(height: 10),
        for (int i = 0; i < dates.length; i++)
          Padding(
            padding: EdgeInsets.only(top: i == 0 ? 0 : 4),
            child: Row(
              children: [
                if (i == 0)
                  Icon(Icons.event, color: violet, size: 18)
                else
                  const SizedBox(width: 24),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    DateFormat('EEEE dd MMM yyyy à HH:mm', 'fr_FR').format(dates[i]),
                    style: textStyle.copyWith(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
        const SizedBox(height: 10),
        Row(
          children: [
            Icon(Icons.location_on, color: violet, size: 18),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                lieu,
                style: textStyle.copyWith(fontSize: 14),
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        Center(
          child: ElevatedButton(
            onPressed: () {
              Navigator.of(context).pushNamed('/billetterie');
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: violet,
              foregroundColor: Colors.white,
              textStyle: GoogleFonts.poppins(fontWeight: FontWeight.bold),
              padding: const EdgeInsets.symmetric(horizontal: 36, vertical: 14),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              elevation: 4,
              shadowColor: violet.withOpacity(0.3),
            ),
            child: const Text('Réserver'),
          ),
        ),
      ],
    );

    if (isMobile) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: CustomPaint(
          painter: TicketBorderPainter(),
          child: ClipPath(
            clipper: InvertedTicketClipper(),
            child: Container(
              color: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
              child: contenu,
            ),
          ),
        ),
      );
    }

    // Desktop/tablette
    return SizedBox(
      width: 650,
      height: 300,
      child: Stack(
        children: [
          CustomPaint(
            painter: TicketBorderPainter(),
            size: const Size(650, 300),
          ),
          ClipPath(
            clipper: InvertedTicketClipper(),
            child: Container(
              color: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 32),
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 520),
                  child: contenu,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
