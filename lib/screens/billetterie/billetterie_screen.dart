import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../models/spectacle.dart';
import '../../models/selected_reservation_data.dart';
import '../../services/spectacle_service.dart';
import '../../widgets/app_footer.dart';
import '../../widgets/app_header.dart';
import 'billetterie_form.dart';

class BilletterieScreen extends StatefulWidget {
  const BilletterieScreen({super.key});

  @override
  State<BilletterieScreen> createState() => _BilletterieScreenState();
}

class _BilletterieScreenState extends State<BilletterieScreen> {
  SelectedReservationData? selectedData;

  final GlobalKey _formKey = GlobalKey();

  void onReservationSelected(int eventId, String titre, DateTime date, int eventDateId) {
    setState(() {
      selectedData = SelectedReservationData(
        eventId: eventId,
        titre: titre,
        date: date,
        eventDateId: eventDateId,
      );
    });
    Scrollable.ensureVisible(_formKey.currentContext!, duration: const Duration(milliseconds: 300));
  }

  @override
  Widget build(BuildContext context) {
    final violetFonce = const Color(0xFF6C3A87);

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const AppHeader(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Center(
                    child: Column(
                      children: [
                        Text("Réservez vos places pour", style: GoogleFonts.poppins(fontSize: 20, color: violetFonce)),
                        Text("le spectacle de fin d’année", style: GoogleFonts.poppins(fontSize: 24, color: violetFonce, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 8),
                        Text("Les rires, les larmes, les frissons...tout commence ici.",
                            textAlign: TextAlign.center,
                            style: GoogleFonts.poppins(fontSize: 14)),
                      ],
                    ),
                  ),
                  const SizedBox(height: 32),
                  FutureBuilder<Spectacle?>(
                    future: SpectacleService.fetchDernierSpectacle(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      if (!snapshot.hasData || snapshot.data == null) {
                        return Text("Aucun spectacle à venir.", style: GoogleFonts.poppins());
                      }
                      final spectacle = snapshot.data!;
                      final dateFormat = DateFormat("EEEE d MMMM yyyy à HH'h'mm", 'fr_FR');

                      return Column(
                        children: List.generate(spectacle.dates.length, (index) {
                          final eventDate = spectacle.dates[index];

                          return Padding(
                            padding: const EdgeInsets.only(bottom: 20),
                            child: LayoutBuilder(
                              builder: (context, constraints) {
                                final width = () {
                                  if (constraints.maxWidth < 600) return double.infinity;
                                  if (constraints.maxWidth < 1000) return 600.0;
                                  return 720.0;
                                }();
                                return Center(
                                  child: ConstrainedBox(
                                      constraints: BoxConstraints(maxWidth: width),
                                      child: EventCard(
                                        eventId: spectacle.id,
                                        titre: spectacle.titre,
                                        date: eventDate.dateTime,
                                        eventDateId: eventDate.id,
                                        formatted: dateFormat.format(eventDate.dateTime),
                                        onPressed: onReservationSelected,
                                    )
                                  ),
                                );
                              },
                            ),
                          );
                        }),
                      );
                    },
                  ),
                  const SizedBox(height: 40),
                  LayoutBuilder(
                    builder: (context, constraints) {
                      final width = () {
                        if (constraints.maxWidth < 600) return double.infinity;
                        if (constraints.maxWidth < 1000) return 600.0;
                        return 720.0;
                      }();
                      return Center(
                        child: ConstrainedBox(
                          constraints: BoxConstraints(maxWidth: width),
                          child: Container(
                            key: _formKey,
                            child: BilletterieForm(selected: selectedData),
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
            const AppFooter(),
          ],
        ),
      ),
    );
  }
}

class EventCard extends StatelessWidget {
  final int eventId;
  final String titre;
  final String formatted;
  final DateTime date;
  final int eventDateId;
  final void Function(int, String, DateTime, int) onPressed;

  const EventCard({
    super.key,
    required this.eventId,
    required this.titre,
    required this.formatted,
    required this.date,
    required this.eventDateId,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final violetFonce = const Color(0xFF6C3A87);

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.purple.shade100),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            offset: const Offset(0, 2),
            blurRadius: 6,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(titre, style: GoogleFonts.poppins(fontWeight: FontWeight.bold, color: violetFonce)),
          const SizedBox(height: 8),
          Text(formatted, style: GoogleFonts.poppins()),
          const SizedBox(height: 12),
          Align(
            alignment: Alignment.centerRight,
            child: ElevatedButton(
              onPressed: () => onPressed(eventId, titre, date, eventDateId),
              style: ElevatedButton.styleFrom(
                backgroundColor: violetFonce,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
              ),
              child: const Text("Réserver"),
            ),
          ),
        ],
      ),
    );
  }
}