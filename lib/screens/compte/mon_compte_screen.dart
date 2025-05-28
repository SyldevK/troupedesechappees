import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../providers/auth_provider.dart';
import '../../services/auth_service.dart';
import '../../services/api_service.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../widgets/app_footer.dart';
import '../../widgets/app_header.dart';
import '../login/login_screen.dart';

class MonCompteScreen extends StatefulWidget {
  const MonCompteScreen({super.key});

  @override
  State<MonCompteScreen> createState() => _MonCompteScreenState();
}

class _MonCompteScreenState extends State<MonCompteScreen> {
  Map<String, dynamic>? user;
  List<Map<String, dynamic>> enrichedReservations = [];
  final Color violetFonce = const Color(0xFF6C3A87);

  @override
  void initState() {
    super.initState();
    _loadUserAndReservations();
  }

  Future<void> _loadUserAndReservations() async {
    final token = await AuthService.getToken();
    final profil = await AuthService.fetchUserProfile();

    if (profil != null) {
      final response = await http.get(
        Uri.parse('${ApiService.baseApiUrl}/api/reservations'),
        headers: {'Authorization': 'Bearer $token'},
      );

      if (response.statusCode == 200) {
        final raw = jsonDecode(response.body);
        print('👉 Réponse complète : $raw');

        final List reservations = raw['member'] ?? [];
        print('📦 Réservations trouvées : ${reservations.length}');

        // Tu peux aussi inspecter les objets si besoin :
        for (var r in reservations) {
          print('📝 Réservation : $r');
        }

        setState(() {
          user = profil;
          enrichedReservations = reservations.cast<Map<String, dynamic>>();
        });
      } else {
        print('❌ Échec API réservations : ${response.statusCode}');
      }
    } else {
      print('❗ Aucun profil utilisateur');
    }
  }

  void _logout() async {
    final confirm = await showDialog<bool>(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text("Se déconnecter"),
            content: const Text("Êtes-vous sûr de vouloir vous déconnecter ?"),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: const Text("Annuler"),
              ),
              ElevatedButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: const Text("Se déconnecter"),
              ),
            ],
          ),
    );

    if (confirm == true) {
      await AuthService.logout();
      if (mounted) {
        final authProvider = Provider.of<AuthProvider>(context, listen: false);
        await authProvider.logout();
        Navigator.of(context).pushReplacementNamed('/login');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final currentRoute = ModalRoute.of(context)?.settings.name ?? '';
    const publicRoutes = [
      '/reset-password',
      '/verification-ok',
      '/erreur-verification',
    ];
    if (!authProvider.isLoggedIn && !publicRoutes.contains(currentRoute)) {
      return const LoginScreen();
    }
    return Scaffold(
      endDrawer: const AppDrawer(),
      backgroundColor: Colors.white,
      body:
          user == null
              ? const Center(child: CircularProgressIndicator())
              : SingleChildScrollView(
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
                              Center(
                                child: Text(
                                  "Bienvenue ${user!['prenom']} ${user!['nom']}",
                                  style: GoogleFonts.poppins(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                    color: violetFonce,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              const SizedBox(height: 12),
                              Center(
                                child: Text(
                                  "Email : ${user!['email']}",
                                  style: GoogleFonts.poppins(
                                    color: Colors.black87,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              const SizedBox(height: 24),
                              Center(
                                child: Text(
                                  "Mes réservations",
                                  style: GoogleFonts.poppins(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600,
                                    color: violetFonce,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              const SizedBox(height: 10),

                              // Tes réservations sous forme de cartes
                              ...enrichedReservations.map((resa) {
                                final event = resa['event'];
                                final titre =
                                    event?['titre'] ?? 'Titre non disponible';

                                String dateHeureStr = '';
                                final eventDateField = resa['eventDate'];
                                if (eventDateField is Map &&
                                    eventDateField['dateTime'] != null) {
                                  dateHeureStr = eventDateField['dateTime'];
                                }

                                final dateReservationStr =
                                    resa['dateReservation'] ?? '';
                                final places = resa['nombrePlaces'] ?? 0;

                                DateTime? spectacleDate =
                                    dateHeureStr.isNotEmpty
                                        ? DateTime.tryParse(dateHeureStr)
                                        : null;
                                DateTime? reservationDate = DateTime.tryParse(
                                  dateReservationStr,
                                );

                                String dateSpectacle =
                                    spectacleDate != null
                                        ? DateFormat(
                                          "EEEE d MMMM yyyy à HH'h'mm",
                                          'fr_FR',
                                        ).format(spectacleDate)
                                        : 'Date non disponible';

                                String dateReservation =
                                    reservationDate != null
                                        ? DateFormat(
                                          'dd/MM/yyyy',
                                        ).format(reservationDate)
                                        : 'Réservation inconnue';

                                return Card(
                                  margin: const EdgeInsets.symmetric(
                                    vertical: 8,
                                    horizontal: 0,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  elevation: 3,
                                  child: Padding(
                                    padding: const EdgeInsets.all(16),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            const Icon(
                                              Icons.event,
                                              color: Colors.deepPurple,
                                            ),
                                            const SizedBox(width: 8),
                                            Expanded(
                                              child: Text(
                                                titre,
                                                style: GoogleFonts.poppins(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 8),
                                        Text(
                                          "Date du spectacle : $dateSpectacle",
                                          style: GoogleFonts.poppins(),
                                        ),
                                        Text(
                                          "Réservé le : $dateReservation",
                                          style: GoogleFonts.poppins(),
                                        ),
                                        Text(
                                          "Places : $places",
                                          style: GoogleFonts.poppins(),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              }).toList(),
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
