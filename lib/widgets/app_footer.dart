import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import '../services/api_service.dart';

class AppFooter extends StatelessWidget {
  const AppFooter({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: const Color(0xFF6C3A87),
      padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 24),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final width = constraints.maxWidth;
          if (width < 600) {
            return const _FooterMobile();
          } else if (width < 1100) {
            return const _FooterTablet();
          } else {
            return const _FooterWeb();
          }
        },
      ),
    );
  }
}

class _FooterTablet extends StatelessWidget {
  const _FooterTablet();

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            _Adresse(textAlign: TextAlign.left),
            SizedBox(height: 24),
            _LiensUtiles(crossAxisAlignment: CrossAxisAlignment.start),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            _Contact(crossAxisAlignment: CrossAxisAlignment.start),
            SizedBox(height: 24),
            _Application(crossAxisAlignment: CrossAxisAlignment.start),
            SizedBox(height: 24),
            _InfosLegales(crossAxisAlignment: CrossAxisAlignment.start),
          ],
        ),
      ],
    );
  }
}

class _FooterWeb extends StatelessWidget {
  const _FooterWeb();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        _Adresse(textAlign: TextAlign.left),
        _Contact(crossAxisAlignment: CrossAxisAlignment.start),
        _Application(crossAxisAlignment: CrossAxisAlignment.start),
        _LiensUtiles(crossAxisAlignment: CrossAxisAlignment.start),
        _InfosLegales(crossAxisAlignment: CrossAxisAlignment.start),
      ],
    );
  }
}

class _FooterMobile extends StatelessWidget {
  const _FooterMobile();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: const [
        _Adresse(textAlign: TextAlign.center),
        SizedBox(height: 24),
        _Contact(),
        SizedBox(height: 24),
        _Application(),
        SizedBox(height: 24),
        _LiensUtiles(),
        SizedBox(height: 24),
        _InfosLegales(),
      ],
    );
  }
}

class _Adresse extends StatelessWidget {
  final TextAlign textAlign;
  const _Adresse({required this.textAlign});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment:
          textAlign == TextAlign.left
              ? CrossAxisAlignment.start
              : CrossAxisAlignment.center,
      children: [
        Text(
          "LA TROUPE DES ÉCHAPPÉES",
          textAlign: textAlign,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          "7 Place du chêne vert",
          textAlign: textAlign,
          style: const TextStyle(color: Colors.white),
        ),
        Text(
          "Mairie de Cintré",
          textAlign: textAlign,
          style: const TextStyle(color: Colors.white),
        ),
        Text(
          "35310 CINTRÉ France",
          textAlign: textAlign,
          style: const TextStyle(color: Colors.white),
        ),
      ],
    );
  }
}

class _Contact extends StatelessWidget {
  final CrossAxisAlignment crossAxisAlignment;
  const _Contact({this.crossAxisAlignment = CrossAxisAlignment.center});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: crossAxisAlignment,
      children: [
        const Text(
          "Contact",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontSize: 16,
          ),
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            InkWell(
              onTap: () async {
                final whatsappUrl = Uri.parse('https://wa.me/33612345678');
                if (await canLaunchUrl(whatsappUrl)) {
                  await launchUrl(
                    whatsappUrl,
                    mode: LaunchMode.externalApplication,
                  );
                }
              },
              child: const Icon(
                FontAwesomeIcons.whatsapp,
                color: Color(0xFF25D366),
              ),
            ),
            const SizedBox(width: 12),
            InkWell(
              onTap: () async {
                final emailUrl = Uri.parse(
                  'mailto:latroupedesechappees@gmail.com',
                );
                if (await canLaunchUrl(emailUrl)) {
                  await launchUrl(emailUrl);
                }
              },
              child: const Icon(Icons.email_outlined, color: Color(0xFFE5B5F3)),
            ),
          ],
        ),
      ],
    );
  }
}

class _Application extends StatefulWidget {
  final CrossAxisAlignment crossAxisAlignment;
  const _Application({this.crossAxisAlignment = CrossAxisAlignment.center});

  @override
  State<_Application> createState() => _ApplicationState();
}

class _ApplicationState extends State<_Application> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: widget.crossAxisAlignment,
      children: [
        const Text(
          "Application",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontSize: 16,
          ),
        ),
        const SizedBox(height: 12),

        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.android, color: Color(0xFFE5B5F3), size: 24),
            const SizedBox(width: 8),
            MouseRegion(
              onEnter: (_) => setState(() => _isHovered = true),
              onExit: (_) => setState(() => _isHovered = false),
              child: Text(
                "Télécharger",
                style: TextStyle(
                  color: _isHovered ? const Color(0xFFE5B5F3) : Colors.white,
                  fontSize: 14,
                  decorationColor:
                      _isHovered ? const Color(0xFFE5B5F3) : Colors.white,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _LiensUtiles extends StatelessWidget {
  final CrossAxisAlignment crossAxisAlignment;
  const _LiensUtiles({this.crossAxisAlignment = CrossAxisAlignment.center});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: crossAxisAlignment,
      children: const [
        Text(
          "Liens utiles",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontSize: 16,
          ),
        ),
        SizedBox(height: 8),
        FooterLinkList(
          labels: [
            "S’inscrire",
            "Nos cours",
            "Nos spectacles",
            "Télécharger le planning PDF",
          ],
        ),
      ],
    );
  }
}

class _InfosLegales extends StatelessWidget {
  final CrossAxisAlignment crossAxisAlignment;
  const _InfosLegales({this.crossAxisAlignment = CrossAxisAlignment.center});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: crossAxisAlignment,
      children: const [
        Text(
          "Infos légales",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontSize: 16,
          ),
        ),
        SizedBox(height: 8),
        FooterLinkList(
          labels: ["Mentions légales", "Politique de confidentialité"],
        ),
      ],
    );
  }
}

class FooterLinkList extends StatefulWidget {
  final List<String> labels;
  const FooterLinkList({required this.labels, super.key});

  @override
  State<FooterLinkList> createState() => _FooterLinkListState();
}

class _FooterLinkListState extends State<FooterLinkList> {
  String hoveredLabel = '';

  @override
  Widget build(BuildContext context) {
    return Column(
      children:
          widget.labels.map((label) {
            final isPdf = label.contains("planning PDF");
            return Container(
              margin: EdgeInsets.zero,
              child: Center(
                child: SizedBox(
                  width: 220,
                  child: InkWell(
                    onTap: () {
                      switch (label) {
                        case "Mentions légales":
                          Navigator.pushNamed(context, '/mentions-legales');
                          break;
                        case "Politique de confidentialité":
                          Navigator.pushNamed(
                            context,
                            '/politique-confidentialite',
                          );
                          break;
                        case "S’inscrire":
                          Navigator.pushNamed(context, '/inscription');
                          break;
                        case "Nos cours":
                          Navigator.pushNamed(context, '/courses');
                          break;
                        case "Nos spectacles":
                          Navigator.pushNamed(context, '/events');
                          break;
                        case "Télécharger le planning PDF":
                          final pdfUrl = Uri.parse('${ApiService.baseAssetsUrl}/pdf/planning.pdf');
                          launchUrl(
                            pdfUrl,
                            mode: LaunchMode.externalApplication,
                          );
                          break;
                        default:
                          break;
                      }
                    },
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Icon(
                          Icons.arrow_right,
                          size: 18,
                          color: Color(0xFFEADDF4),
                        ),
                        const SizedBox(width: 6),
                        Expanded(
                          child: MouseRegion(
                            onEnter:
                                (_) => setState(() => hoveredLabel = label),
                            onExit: (_) => setState(() => hoveredLabel = ''),
                            child: Text(
                              label,
                              style: TextStyle(
                                color:
                                    hoveredLabel == label
                                        ? Color(0xFFE5B5F3)
                                        : Colors.white,
                                fontSize: 14,
                                decorationColor:
                                    hoveredLabel == label
                                        ? Color(0xFFE5B5F3)
                                        : Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          }).toList(),
    );
  }
}
