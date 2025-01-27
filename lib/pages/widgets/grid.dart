import 'package:flutter/material.dart';

class Grid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: 100, // Photo array.length
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 5,
      ),
      itemBuilder: (BuildContext context, int index) {
        return Padding(padding: const EdgeInsets.all(2.0), child:
        // phtotoos
        );
      },
    );
  }
}
