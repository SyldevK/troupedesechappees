import 'package:flutter/material.dart';
import '../../widgets/app_header.dart';
import '../../widgets/app_footer.dart';
import 'inscription_atelier_form.dart';

class InscriptionAtelierScreen extends StatelessWidget {
  const InscriptionAtelierScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: const AppDrawer(),
      body: SingleChildScrollView(
        child: Column(
          children: const [
            const AppHeader(isHome: false),
            Padding(
              padding: EdgeInsets.all(24.0),
              child: InscriptionAtelierForm(),
            ),
            AppFooter(),
          ],
        ),
      ),
    );
  }
}
