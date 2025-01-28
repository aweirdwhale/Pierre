// Packages
import 'package:flutter/material.dart';
import 'package:pierre/pages/onboarding/splash.dart';

// App entry point
void main() {
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SplashScreen(), // ouvre sur l'écran de chargement
    );
  }
}
