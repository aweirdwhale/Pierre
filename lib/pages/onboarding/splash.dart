/*
Splash screen : check if onboarding screens should be displayed or not
*/
import 'package:flutter/material.dart';
import 'package:pierre/pages/onboarding/onboarding.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Future<void> checkOnboarding() async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      bool hasSeenOnboarding = prefs.getBool('hasSeenOnboarding') ?? false;

      if (hasSeenOnboarding) {
        // Redirige vers la page principale
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => Placeholder()),
        );
      } else {
        // Redirige vers l'onboarding
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => OnboardingScreen()),
        );
      }
    }

    // Appelle la vérification après un court délai
    checkOnboarding();

    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(), // Écran de chargement temporaire
      ),
    );
  }
}
