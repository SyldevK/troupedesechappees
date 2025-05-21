// lib/widgets/events/past_events_grid.dart

import 'dart:io';
import 'dart:math' as math;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../../models/spectacle.dart';
import '../../../theme/app_colors.dart';
import '../../utils/network_utils.dart';

class PastEventsGrid extends StatelessWidget {
  final List<Spectacle> spectacles;
  const PastEventsGrid({super.key, required this.spectacles});

  @override
  Widget build(BuildContext context) {
    final dateFormat = DateFormat('d MMMM yyyy', 'fr_FR');

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(height: 48),
        Text(
          "Événements passés",
          style: GoogleFonts.poppins(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: AppColors.violetFonce,
          ),
        ),
        const SizedBox(height: 24),

        // On recalcule le grid dans un LayoutBuilder
        LayoutBuilder(
          builder: (context, constraints) {
            final screenW = constraints.maxWidth;

            // 1) Largeur max de la zone de grid
            final gridMaxW = math.min(screenW, 1500.0);

            // 2) Paramètres de layout
            const tileMinW = 360.0;
            const hPadding = 16.0 * 2;
            const crossSpacing = 100.0;
            const mainSpacing = 24.0;

            // 3) Calcul du nombre de colonnes qui peuvent tenir
            //    en tenant compte des espacements
            final availW = gridMaxW - hPadding;
            var colCount =
                ((availW + crossSpacing) / (tileMinW + crossSpacing)).floor();
            colCount = colCount.clamp(1, 4);

            // 4) On ne veut pas plus de colonnes que d'items
            final crossAxisCount = math.min(colCount, spectacles.length);

            // 5) Calcul de la largeur effective du Grid
            final actualGridW =
                crossAxisCount * tileMinW +
                (crossAxisCount - 1) * crossSpacing +
                hPadding;

            return Center(
              child: SizedBox(
                width: actualGridW,
                child: GridView.builder(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: spectacles.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: crossAxisCount,
                    crossAxisSpacing: crossSpacing,
                    mainAxisSpacing: mainSpacing,
                    childAspectRatio: 0.7,
                  ),
                  itemBuilder: (context, index) {
                    return _buildEventCard(spectacles[index], dateFormat);
                  },
                ),
              ),
            );
          },
        ),

        const SizedBox(height: 48),
      ],
    );
  }
  Widget _buildEventCard(Spectacle spectacle, DateFormat dateFormat) {
    final String base =
        kIsWeb
            ? 'http://tie.test'
            : Platform.isAndroid
            ? 'http://10.0.2.2'
            : 'http://localhost';
    final String imageUrl = '$base/uploads/images/${spectacle.imageUrl}';

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.violetFonce.withOpacity(0.4)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 8,
            offset: const Offset(2, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(16),
              ),
              child: Image.network(
                imageUrl,
                fit: BoxFit.cover,
                width: double.infinity,
                errorBuilder: (_, __, ___) {
                  debugPrint('❌ Erreur image: $imageUrl');
                  return Container(
                    color: AppColors.violetClair.withOpacity(0.2),
                    child: const Center(child: Text("Image non trouvée")),
                  );
                },
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  spectacle.titre,
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    color: AppColors.violetFonce,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  dateFormat.format(spectacle.dates.first.dateTime),
                  style: GoogleFonts.poppins(
                    fontSize: 13,
                    color: Colors.black54,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
