import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../models/spectacle.dart';
import '../../services/spectacle_service.dart';
import '../../theme/app_colors.dart';
import '../../widgets/app_footer.dart';
import '../../widgets/app_header.dart';
import '../../widgets/events/past_events_grid.dart';
import '../../widgets/events/ticket_shape.dart';

class EventScreen extends StatelessWidget {
  const EventScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: Align(
              alignment: Alignment.topCenter,
              child: ConstrainedBox(
                constraints: BoxConstraints(minWidth: constraints.maxWidth),
                child: Column(
                  children: [
                    const AppHeader(),
                    Stack(
                      children: [
                        Image.asset(
                          'assets/images/banniere-evenements.jpg',
                          height: 220,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                        Positioned.fill(
                          child: Container(
                            color: Colors.black.withOpacity(0.4),
                            alignment: Alignment.center,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Événements",
                                  style: GoogleFonts.poppins(
                                    fontSize: 32,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  "Spectacles, représentations, émotions…",
                                  style: GoogleFonts.poppins(
                                    fontSize: 16,
                                    fontStyle: FontStyle.italic,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 24),

                    // Ticket prochain spectacle
                    FutureBuilder<Spectacle?>(
                      future: SpectacleService.fetchDernierSpectacle(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return const Padding(
                            padding: EdgeInsets.symmetric(vertical: 32),
                            child: CircularProgressIndicator(),
                          );
                        } else if (snapshot.hasData && snapshot.data != null) {
                          final spectacle = snapshot.data!;
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 36),
                            child: TicketShape(
                              titre: spectacle.titre,
                              description: spectacle.description,
                              dates: spectacle.dates.map((e) => e.dateTime).toList(),
                              lieu: spectacle.lieu,
                            ),
                          );
                        } else {
                          return const Padding(
                            padding: EdgeInsets.symmetric(vertical: 36),
                            child: Text("Aucun événement prochainement."),
                          );
                        }
                      },
                    ),

                    // 🎭 Événements passés
                    FutureBuilder<List<Spectacle>>(
                      future: SpectacleService.fetchLastTwoSpectacles(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return const Padding(
                            padding: EdgeInsets.all(24),
                            child: CircularProgressIndicator(),
                          );
                        } else if (snapshot.hasError) {
                          return const Text("Erreur de chargement.");
                        } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 24),
                            child: PastEventsGrid(spectacles: snapshot.data!),
                          );
                        } else {
                          return const Text("Aucun événement passé à afficher.");
                        }
                      },
                    ),

                    const AppFooter(),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
