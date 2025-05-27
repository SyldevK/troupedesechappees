import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../services/api_service.dart';
import '../../services/auth_service.dart';
import '../../models/selected_reservation_data.dart';

class BilletterieForm extends StatefulWidget {
  final SelectedReservationData? selected;
  const BilletterieForm({super.key, this.selected});

  @override
  State<BilletterieForm> createState() => _BilletterieFormState();
}

class _BilletterieFormState extends State<BilletterieForm> {
  final nomController = TextEditingController();
  final prenomController = TextEditingController();
  final emailController = TextEditingController();
  final telController = TextEditingController();
  int nbPlaces = 1;

  Map<String, dynamic>? user;
  final Color violetFonce = const Color(0xFF6C3A87);

  @override
  void initState() {
    super.initState();
    _loadUserProfile();
  }

  Future<void> _loadUserProfile() async {
    final profile = await AuthService.fetchUserProfile();
    if (profile != null) {
      setState(() {
        user = profile;
        nomController.text = profile['nom'] ?? '';
        prenomController.text = profile['prenom'] ?? '';
        emailController.text = profile['email'] ?? '';
      });
    }
  }

  @override
  void dispose() {
    nomController.dispose();
    prenomController.dispose();
    emailController.dispose();
    telController.dispose();
    super.dispose();
  }

  void _confirmerReservation() {
    final tel = telController.text.trim();
    final date = widget.selected?.date;
    final titre = widget.selected?.titre;

    if (tel.isEmpty || date == null || titre == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Merci de remplir tous les champs et sélectionner une date.")),
      );
      return;
    }

    final formattedDate = DateFormat("EEEE d MMMM yyyy à HH'h'mm", 'fr_FR').format(date);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Confirmer votre réservation"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Spectacle : $titre"),
            Text("Date : $formattedDate"),
            Text("Nom : ${nomController.text}"),
            Text("Prénom : ${prenomController.text}"),
            Text("Email : ${emailController.text}"),
            Text("Téléphone : $tel"),
            Text("Nombre de places : $nbPlaces"),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text("Annuler"),
          ),
          ElevatedButton(
            onPressed: () async {
              Navigator.of(context).pop();
              await _envoyerReservation();
            },
            child: const Text("Confirmer"),
          ),
        ],
      ),
    );
  }

  Future<void> _envoyerReservation() async {
    final apiUrl = Uri.parse('${ApiService.baseApiUrl}/reservations');
    final token = await AuthService.getToken();
    final user = await AuthService.fetchUserProfile();

    final userId = user?['@id'] ?? '/api/users/${user?['id']}';

    final body = jsonEncode({
      "nombrePlaces": nbPlaces,
      "dateReservation": DateTime.now().toIso8601String(),
      "event": "/api/events/${widget.selected!.eventId}",
      "eventDate": "/api/event_dates/${widget.selected!.eventDateId}",
      "user": userId,
    });

    try {
      final response = await http.post(
        apiUrl,
        headers: {
          'Content-Type': 'application/ld+json',
          'Authorization': 'Bearer $token',
        },
        body: body,
      );

      if (response.statusCode == 201) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Réservation envoyée avec succès !")),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Erreur : ${response.body}")),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Erreur réseau.")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
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
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Expanded(child: champTexte("Nom", nomController, readOnly: true)),
              const SizedBox(width: 16),
              Expanded(child: champTexte("Prénom", prenomController, readOnly: true)),
            ],
          ),
          champTexte("Email", emailController, type: TextInputType.emailAddress, readOnly: true),
          champTexte("Téléphone", telController, type: TextInputType.phone),
          const SizedBox(height: 16),

          Row(
            children: [
              Expanded(
                child: Text("Nombre de places", style: GoogleFonts.poppins(fontWeight: FontWeight.w600, color: violetFonce)),
              ),
              const SizedBox(width: 8),
              IconButton(
                icon: const Icon(Icons.remove_circle_outline),
                onPressed: () => setState(() => nbPlaces = (nbPlaces > 1) ? nbPlaces - 1 : 1),
              ),
              Text("$nbPlaces", style: GoogleFonts.poppins(fontWeight: FontWeight.bold)),
              IconButton(
                icon: const Icon(Icons.add_circle_outline),
                onPressed: () => setState(() => nbPlaces++),
              ),
            ],
          ),

          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: _confirmerReservation,
            style: ElevatedButton.styleFrom(
              backgroundColor: violetFonce,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 14),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            ),
            child: Text("Valider ma réservation", style: GoogleFonts.poppins(fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }

  Widget champTexte(String label, TextEditingController controller, {TextInputType? type, bool readOnly = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: GoogleFonts.poppins(fontWeight: FontWeight.w600, color: violetFonce)),
          const SizedBox(height: 6),
          TextFormField(
            controller: controller,
            keyboardType: type,
            readOnly: readOnly,
            style: GoogleFonts.poppins(color: Colors.white, fontWeight: FontWeight.bold),
            decoration: InputDecoration(
              filled: true,
              fillColor: violetFonce,
              hintStyle: GoogleFonts.poppins(color: Colors.white70),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide.none,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
