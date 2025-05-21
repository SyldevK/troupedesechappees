import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DroitImageDialog extends StatelessWidget {
  const DroitImageDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        "Autorisation du droit à l'image",
        style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
      ),
      content: SingleChildScrollView(
        child: Text(
          "En cochant cette case, j’autorise l’association La Troupe des Échappées à prendre des photos ou vidéos durant les ateliers ou spectacles, "
              "et à les utiliser à des fins de communication (site web, réseaux sociaux, affiches...).\n\n"
              "Cette autorisation est révocable à tout moment sur simple demande.",
          style: GoogleFonts.poppins(),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text("Fermer", style: GoogleFonts.poppins()),
        ),
      ],
    );
  }
}
