import 'package:flutter/material.dart';

import '../../models/sample_data.dart';
import '../../widgets/app_footer.dart';
import '../../widgets/app_header.dart';
import '../../widgets/courses/age_group_card.dart';
import '../../widgets/courses/intro_section.dart';
import '../../widgets/courses/objective_section.dart';
import '../../widgets/courses/register_button.dart';



class CoursesScreen extends StatelessWidget {
  const CoursesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const AppHeader(),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  const IntroSection(),

                  // 🎓 Cartes par tranche d'âge
                  Wrap(
                    alignment: WrapAlignment.center,
                    spacing: 16,
                    runSpacing: 16,
                    children: [
                      AgeGroupCard(
                        title: "Enfants",
                        subtitle: "de 6 à 10 ans",
                        imageAsset: 'assets/images/enfants.png',
                        courseList: enfantsCourses,
                      ),
                      AgeGroupCard(
                        title: "Ados",
                        subtitle: "de 11 à 17 ans",
                        imageAsset: 'assets/images/adolescents.png',
                        courseList: adosCourses,
                      ),
                      AgeGroupCard(
                        title: "Adultes",
                        subtitle: "à partir de 18 ans",
                        imageAsset: 'assets/images/adultes.png',
                        courseList: adultesCourses,
                      ),
                    ],
                  ),

                  const ObjectivesSection(),

                  RegisterButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/ateliers');
                    },
                  ),

                  const SizedBox(height: 80),
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
