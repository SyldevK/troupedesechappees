// fichier : lib/router/app_router.dart
import 'package:flutter/material.dart';
import 'package:troupedesechappees/screens/ateliers/inscription_atelier_screen.dart';
import 'package:troupedesechappees/screens/billetterie/billetterie_screen.dart';
import 'package:troupedesechappees/screens/changerMotdePasse/ChangerMotDePasseScreen.dart';
import 'package:troupedesechappees/screens/courses/course_screen.dart';
import 'package:troupedesechappees/screens/events/event_screen.dart';
import 'package:troupedesechappees/screens/gallery/gallery_page.dart';
import 'package:troupedesechappees/screens/inscription/inscription_screen.dart';
import 'package:troupedesechappees/screens/login/login_screen.dart';
import 'package:troupedesechappees/screens/mentionsLegales/mentions_legales_screen.dart';
import 'package:troupedesechappees/screens/politiqueConfidentialite/politique_confidentialite_screen.dart';
import '../screens/compte/mon_compte_screen.dart';
import '../screens/contact/contact_screen.dart';
import '../screens/home/home_screen.dart';
import '../screens/notreHistoire/notre_histoire_screen.dart';



class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
      case '/home':
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      case '/notreHistoire':
        return MaterialPageRoute(builder: (_) => const NotreHistoireScreen());
      case '/courses':
        return MaterialPageRoute(builder: (_) => const CoursesScreen());
      case '/events':
        return MaterialPageRoute(builder: (_) => const EventScreen());
      case '/billetterie':
        return MaterialPageRoute(builder: (_) => const BilletterieScreen());
      case '/gallery':
        return MaterialPageRoute(builder: (_) => const GalleryPage());
      case '/contact':
        return MaterialPageRoute(builder: (_) => const ContactScreen());
      case '/ateliers':
        return MaterialPageRoute(builder: (_) => const InscriptionAtelierScreen());
      case '/monCompte':
        return MaterialPageRoute(builder: (_) => const MonCompteScreen());
      case '/mentions-legales':
        return MaterialPageRoute(builder: (_) => const MentionsLegalesScreen());
      case '/politique-confidentialite':
        return MaterialPageRoute(builder: (_) => const PolitiqueConfidentialiteScreen());
      case '/inscription':
        return MaterialPageRoute(builder: (_) => const InscriptionScreen());
      case '/login':
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      case '/changerMotDePasse':
        return MaterialPageRoute(builder: (_) => const ChangerMotDePasseScreen());
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(child: Text('Page non trouvée : ${settings.name}')),
          ),
        );
    }
  }
}
