import 'dart:io';
import 'package:flutter/material.dart';

class FullScreenImage extends StatefulWidget {
  final List<String> mediaPaths;
  final int initialIndex;

  FullScreenImage({required this.mediaPaths, required this.initialIndex});

  @override
  _FullScreenImageState createState() => _FullScreenImageState();
}

class _FullScreenImageState extends State<FullScreenImage> {
  late PageController _pageController;
  late TransformationController _transformationController;
  double _scaleFactor = 1.0;
  double _previousScale = 1.0;
  double _verticalDragStart = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: widget.initialIndex);
    _transformationController = TransformationController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    _transformationController.dispose();
    super.dispose();
  }

  // Gérer le zoom avec un pincement
  void _handleScaleUpdate(ScaleUpdateDetails details) {
    setState(() {
      _scaleFactor = _previousScale * details.scale;
      if (_scaleFactor < 1.0) {
        _scaleFactor = 1.0; // Min Zoom
      }
      _transformationController.value = Matrix4.identity()..scale(_scaleFactor);
    });
  }

  // Gérer le zoom initial lorsque l'échelle change
  void _handleScaleEnd(ScaleEndDetails details) {
    _previousScale = _scaleFactor; // Met à jour l'échelle précédente
  }

  // Gérer le drag vertical (swipe vers le bas pour sortir de la photo)
  void _handleVerticalDragStart(DragStartDetails details) {
    _verticalDragStart = details.globalPosition.dy;
  }

  void _handleVerticalDragUpdate(DragUpdateDetails details) {
    final delta = details.globalPosition.dy - _verticalDragStart;
    if (delta > 200) {
      Navigator.pop(
          context); // Si l'utilisateur glisse vers le bas suffisamment, on ferme l'écran
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: GestureDetector(
        onVerticalDragStart: _handleVerticalDragStart,
        onVerticalDragUpdate: _handleVerticalDragUpdate,
        child: PageView.builder(
          controller: _pageController,
          itemCount: widget.mediaPaths.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onScaleUpdate:
                  _handleScaleUpdate, // Gère le zoom avec le pincement
              onScaleEnd:
                  _handleScaleEnd, // Met à jour l'échelle finale après la fin du geste
              child: InteractiveViewer(
                transformationController: _transformationController,
                clipBehavior: Clip.none,
                panEnabled: false, // Désactive le pan manuel
                minScale: 1.0, // Zoom minimum
                maxScale: 4.0, // Zoom maximum
                child: Center(
                  child: Image.file(
                    File(widget.mediaPaths[index]),
                    fit: BoxFit.contain, // Conserve les proportions de l'image
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
