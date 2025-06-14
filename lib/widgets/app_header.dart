import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import '../providers/auth_provider.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import '../providers/auth_provider.dart';

String getImagePath(String fileName) {
  return 'assets/images/$fileName';
}

void _safePushNamed(BuildContext context, String routeName) {
  if (ModalRoute.of(context)?.settings.name != routeName) {
    Navigator.pushNamed(context, routeName);
  }
}

class AppHeader extends StatelessWidget {
  final bool isHome;
  const AppHeader({super.key, this.isHome = false});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isMobile = width < 600;
    final isTablet = width >= 600 && width < 1200;

    if (isMobile) {
      return _MobileHeader(isHome: isHome);
    } else if (isTablet) {
      return _TabletHeader(isHome: isHome);
    } else {
      return _WebHeader(isHome: isHome);
    }
  }
}

// ----------------------------
// Mobile Header
// ----------------------------
class _MobileHeader extends StatelessWidget {
  final bool isHome;
  const _MobileHeader({this.isHome = false});

  @override
  Widget build(BuildContext context) {
    final canGoBack = Navigator.canPop(context) && !isHome;

    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: const Color(0xFF6C3A87),
      titleSpacing: 0,
      title: Row(
        children: [
          if (canGoBack)
            IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () => Navigator.pop(context),
            ),
          const SizedBox(width: 4),
          ClipRRect(
            borderRadius: BorderRadius.circular(100),
            child: Image.asset(
              getImagePath('logo_tie.png'),
              width: 48,
              height: 48,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 6),
          Expanded(
            child: Text(
              'La Troupe des Échappées',
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),
        ],
      ),
      actions: [
        Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.menu),
            color: Colors.white,
            onPressed: () {
              Scaffold.of(context).openEndDrawer();
            },
          ),
        ),
      ],
    );
  }
}

// ----------------------------
// Tablet Header
// ----------------------------
class _TabletHeader extends StatelessWidget {
  const _TabletHeader({required bool isHome});

  @override
  Widget build(BuildContext context) {
    final isLoggedIn = context.watch<AuthProvider>().isLoggedIn;
    final isAdmin = context.watch<AuthProvider>().isAdmin;
    final width = MediaQuery.of(context).size.width;

    double horizontalPadding = width > 1200 ? 32 : width > 800 ? 16 : 8;
    double verticalPadding = width > 900 ? 12 : 6;

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: horizontalPadding,
        vertical: verticalPadding,
      ),
      color: const Color(0xFF6C3A87),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(100),
            child: Image.asset(
              getImagePath('logo_tie.png'),
              width: 60,
              height: 60,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 8),
          const Text(
            'La Troupe des Échappées',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Spacer(),
          Row(
            children: [
              IconButton(
                tooltip: 'Accueil',
                icon: const Icon(Icons.home, color: Colors.white),
                onPressed: () => _safePushNamed(context, '/home'),
              ),
              IconButton(
                tooltip: 'Événements',
                icon: const Icon(Icons.event, color: Colors.white),
                onPressed: () => _safePushNamed(context, '/events'),
              ),
              IconButton(
                tooltip: 'Billetterie',
                icon: const Icon(Icons.theater_comedy, color: Colors.white),
                onPressed: () => _safePushNamed(context, '/billetterie'),
              ),
              IconButton(
                tooltip: 'Contact',
                icon: const Icon(Icons.mail_outline, color: Colors.white),
                onPressed: () => _safePushNamed(context, '/contact'),
              ),
              IconButton(
                tooltip: isLoggedIn ? 'Mon compte' : 'Connexion',
                icon: Icon(
                  isLoggedIn ? Icons.account_circle : Icons.login,
                  color: Colors.white,
                ),
                onPressed: () =>
                    _safePushNamed(context, isLoggedIn ? '/monCompte' : '/login'),
              ),
              if (isAdmin)
                IconButton(
                  tooltip: 'Administration',
                  icon: const Icon(Icons.admin_panel_settings, color: Colors.white),
                  onPressed: () async {
                    final Uri url = Uri.parse('http://tie.test/admin');
                    await launchUrl(url, mode: LaunchMode.externalApplication);
                  },
                ),
              IconButton(
                tooltip: 'Menu complet',
                icon: const Icon(Icons.menu, color: Colors.white),
                onPressed: () {
                  Scaffold.maybeOf(context)?.openEndDrawer();
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// ----------------------------
// Web Header
// ----------------------------
class _WebHeader extends StatelessWidget {
  const _WebHeader({required bool isHome});

  @override
  Widget build(BuildContext context) {
    final isLoggedIn = context.watch<AuthProvider>().isLoggedIn;
    final isAdmin = context.watch<AuthProvider>().isAdmin;
    final width = MediaQuery.of(context).size.width;

    double horizontalPadding = width > 1500
        ? 64
        : width > 1300
        ? 40
        : width > 1100
        ? 20
        : 8;
    double verticalPadding = width > 800 ? 20 : 10;

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: horizontalPadding,
        vertical: verticalPadding,
      ),
      color: const Color(0xFF6C3A87),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: Image.asset(
                  getImagePath('logo_tie.png'),
                  width: 80,
                  height: 80,
                  fit: BoxFit.cover,
                  filterQuality: FilterQuality.high,
                ),
              ),
              const SizedBox(width: 16),
              const Text(
                'La Troupe des Échappées',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Poppins',
                ),
              ),
            ],
          ),
          Row(
            children: const [
              _HeaderButton(label: 'Accueil'),
              _HeaderButton(label: 'Notre histoire'),
              _HeaderButton(label: 'Nos cours'),
              _HeaderButton(label: 'Événements'),
              _HeaderButton(label: 'Billetterie'),
              _HeaderButton(label: 'Galerie'),
              _HeaderButton(label: 'Contact'),
              _HeaderButton(label: 'Ateliers'),
            ],
          ),
          Row(
            children: [
              IconButton(
                tooltip: isLoggedIn ? 'Mon compte' : 'Connexion',
                onPressed: () {
                  _safePushNamed(context, isLoggedIn ? '/monCompte' : '/login');
                },
                icon: Icon(
                  isLoggedIn ? Icons.account_circle : Icons.login,
                  color: Colors.white,
                  size: 30,
                ),
              ),
              if (isLoggedIn)
                IconButton(
                  tooltip: 'Déconnexion',
                  icon: const Icon(Icons.logout, color: Colors.white, size: 28),
                  onPressed: () async {
                    await context.read<AuthProvider>().logout();
                    Navigator.pushReplacementNamed(context, '/login');
                  },
                ),
            ],
          ),
        ],
      ),
    );
  }
}

// ----------------------------
// HeaderButton
// ----------------------------
class _HeaderButton extends StatefulWidget {
  final String label;
  const _HeaderButton({required this.label});

  @override
  State<_HeaderButton> createState() => _HeaderButtonState();
}

class _HeaderButtonState extends State<_HeaderButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    double horizontalButtonPadding = width > 1700
        ? 40
        : width > 1300
        ? 28
        : width > 1000
        ? 16
        : width > 800
        ? 8
        : 4;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: horizontalButtonPadding),
      child: MouseRegion(
        onEnter: (_) => setState(() => _isHovered = true),
        onExit: (_) => setState(() => _isHovered = false),
        child: GestureDetector(
          onTap: () => _safePushNamed(context, _getRoute(widget.label)),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              AnimatedDefaultTextStyle(
                duration: const Duration(milliseconds: 200),
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  decoration:
                  _isHovered ? TextDecoration.underline : TextDecoration.none,
                  decorationColor: Colors.white,
                  decorationThickness: 2,
                ),
                child: Text(widget.label),
              ),
              const SizedBox(height: 4),
            ],
          ),
        ),
      ),
    );
  }

  String _getRoute(String label) {
    switch (label) {
      case 'Accueil':
        return '/home';
      case 'Notre histoire':
        return '/notreHistoire';
      case 'Nos cours':
        return '/courses';
      case 'Événements':
        return '/events';
      case 'Billetterie':
        return '/billetterie';
      case 'Galerie':
        return '/gallery';
      case 'Contact':
        return '/contact';
      case 'Ateliers':
        return '/ateliers';
      default:
        return '/';
    }
  }
}

// ----------------------------
// Drawer
// ----------------------------
class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final isLoggedIn = context.watch<AuthProvider>().isLoggedIn;

    return Drawer(
      backgroundColor: Colors.white,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(color: Color(0xFF6C3A87)),
            child: Text(
              'Menu',
              style: TextStyle(color: Colors.white, fontSize: 24),
            ),
          ),
          const _DrawerItem('Accueil', route: '/home'),
          const _DrawerItem('Notre histoire', route: '/notreHistoire'),
          const _DrawerItem('Nos cours', route: '/courses'),
          const _DrawerItem('Événements', route: '/events'),
          const _DrawerItem('Billetterie', route: '/billetterie'),
          const _DrawerItem('Galerie', route: '/gallery'),
          const _DrawerItem('Contact', route: '/contact'),
          const _DrawerItem('Ateliers', route: '/ateliers'),
          _DrawerItem(
            isLoggedIn ? 'Mon compte' : 'Connexion',
            icon: isLoggedIn ? Icons.account_circle : Icons.login,
            route: isLoggedIn ? '/monCompte' : '/login',
          ),
          if (isLoggedIn)
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('Se déconnecter'),
              onTap: () async {
                await context.read<AuthProvider>().logout();
                Navigator.pop(context);
                Navigator.pushReplacementNamed(context, '/login');
              },
            ),
        ],
      ),
    );
  }
}

class _DrawerItem extends StatelessWidget {
  final String label;
  final IconData? icon;
  final String route;

  const _DrawerItem(this.label, {this.icon, required this.route});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: icon != null ? Icon(icon) : null,
      title: Text(label),
      onTap: () {
        Navigator.pop(context);
        Navigator.pushNamed(context, route);
      },
    );
  }
}
