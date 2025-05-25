import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import '../providers/auth_provider.dart';

String getImagePath(String fileName) {
  return 'assets/images/$fileName';
}

class AppHeader extends StatelessWidget {
  const AppHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isMobile = width < 600;
    final isTablet = width >= 600 && width < 1300;

    if (isMobile) {
      return const _MobileHeader();
    } else if (isTablet) {
      return const _TabletHeader();
    } else {
      return const _WebHeader();
    }
  }
}

// ----------------------------
// Mobile Header
// ----------------------------
class _MobileHeader extends StatelessWidget {
  const _MobileHeader();

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: const Color(0xFF6C3A87),
      title: Row(
        children: [
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
          const Text('Troupe des Échappées'),
        ],
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () {
            Scaffold.maybeOf(context)?.openEndDrawer();
          },
        ),
      ],
    );
  }
}

// ----------------------------
// Tablet Header
// ----------------------------
class _TabletHeader extends StatelessWidget {
  const _TabletHeader();

  @override
  Widget build(BuildContext context) {
    final isLoggedIn = context.watch<AuthProvider>().isLoggedIn;
    final isAdmin = context.watch<AuthProvider>().isAdmin;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      color: const Color(0xFF6C3A87),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(100),
            child: Image.asset(
              getImagePath('logo_tie.png'),
              width: 90,
              height: 90,
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
                onPressed: () => Navigator.pushNamed(context, '/home'),
              ),
              IconButton(
                tooltip: 'Événements',
                icon: const Icon(Icons.event, color: Colors.white),
                onPressed: () => Navigator.pushNamed(context, '/events'),
              ),
              IconButton(
                tooltip: 'Billetterie',
                icon: const Icon(Icons.theater_comedy, color: Colors.white),
                onPressed: () => Navigator.pushNamed(context, '/billetterie'),
              ),
              IconButton(
                tooltip: 'Contact',
                icon: const Icon(Icons.mail_outline, color: Colors.white),
                onPressed: () => Navigator.pushNamed(context, '/contact'),
              ),
              IconButton(
                tooltip: isLoggedIn ? 'Mon compte' : 'Connexion',
                icon: Icon(
                  isLoggedIn ? Icons.account_circle : Icons.login,
                  color: Colors.white,
                ),
                onPressed:
                    () => Navigator.pushNamed(
                      context,
                      isLoggedIn ? '/monCompte' : '/login',
                    ),
              ),
              // 👇 Bouton admin visible uniquement pour admin
              if (isAdmin)
                IconButton(
                  tooltip: 'Administration',
                  icon: const Icon(
                    Icons.admin_panel_settings,
                    color: Colors.white,
                  ),
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
  const _WebHeader();

  @override
  Widget build(BuildContext context) {
    final isLoggedIn = context.watch<AuthProvider>().isLoggedIn;
    final isAdmin = context.watch<AuthProvider>().isAdmin;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 48, vertical: 20),
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
                ),
              ),
            ],
          ),
          Row(
            children: [
              const _HeaderButton(label: 'Accueil'),
              const _HeaderButton(label: 'Notre histoire'),
              const _HeaderButton(label: 'Nos cours'),
              const _HeaderButton(label: 'Événements'),
              const _HeaderButton(label: 'Billetterie'),
              const _HeaderButton(label: 'Galerie'),
              const _HeaderButton(label: 'Contact'),
              const _HeaderButton(label: 'Ateliers'),
              if (isAdmin)
                IconButton(
                  tooltip: 'Administration',
                  icon: const Icon(
                    Icons.admin_panel_settings,
                    color: Colors.white,
                  ),
                  onPressed: () async {
                    final Uri url = Uri.parse('http://tie.test/admin');
                    await launchUrl(url, mode: LaunchMode.externalApplication);
                  },
                ),
            ],
          ),
          Row(
            children: [
              IconButton(
                tooltip: isLoggedIn ? 'Mon compte' : 'Connexion',
                onPressed: () {
                  Navigator.pushNamed(
                    context,
                    isLoggedIn ? '/monCompte' : '/login',
                  );
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
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: MouseRegion(
        onEnter: (_) => setState(() => _isHovered = true),
        onExit: (_) => setState(() => _isHovered = false),
        child: GestureDetector(
          onTap: () => Navigator.pushNamed(context, _getRoute(widget.label)),
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
                      _isHovered
                          ? TextDecoration.underline
                          : TextDecoration.none,
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
