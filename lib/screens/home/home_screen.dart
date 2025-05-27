import 'package:flutter/material.dart';
import 'package:troupedesechappees/widgets/app_header.dart';
import 'package:troupedesechappees/widgets/app_footer.dart';
import 'package:troupedesechappees/screens/home/carousel_section.dart';
import 'package:troupedesechappees/screens/home/activities_section.dart';
import 'package:troupedesechappees/screens/home/news_section.dart';
import 'package:troupedesechappees/screens/home/signup_section.dart';

class HomeScreen extends StatelessWidget {
  static const String routeName = '/home';
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: const AppDrawer(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: const [
            AppHeader(isHome: true),
            CarouselSection(),
            SizedBox(height: 32),
            ActivitiesSection(),
            SizedBox(height: 32),
            NewsSection(),
            SizedBox(height: 32),
            SignupSection(),
            AppFooter(),
          ],
        ),
      ),
    );
  }
}

