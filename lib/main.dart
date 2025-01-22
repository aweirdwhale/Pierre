import 'package:flutter/material.dart';
import 'package:pierre/pages/photos.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pierre (Dev .1)',
      theme: ThemeData(
        // Theme :
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
        useMaterial3: true,
      ),
      home: Photos(),
    );
  }
}
