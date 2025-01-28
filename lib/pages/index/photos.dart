import 'dart:io';
import 'package:flutter/material.dart';
import 'package:pierre/handlers/mediahandler.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  PaintingBinding.instance.imageCache.maximumSizeBytes =
      100 * 1024 * 1024; // 100 Mo de cache pour les images
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Photos(),
    );
  }
}

class Photos extends StatefulWidget {
  @override
  _PhotosState createState() => _PhotosState();
}

class _PhotosState extends State<Photos> {
  List<dynamic> getMedia() {
    MediaHandler mediaHelper = MediaHandler();
    List<dynamic> mediaPaths = [];
    var dir = Directory('/storage/emulated/0/DCIM/');
    mediaHelper.getAllMediaPaths(dir, mediaPaths);

    print("Nombre d'images : ${mediaPaths.length}");
    return mediaPaths;
  }

  @override
  Widget build(BuildContext context) {
    List<dynamic> mediaPaths = getMedia();

    return Scaffold(
      appBar: AppBar(
        title: Text('Photos : ${mediaPaths.length}'),
      ),
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3, // Ajuste le nombre de colonnes
          crossAxisSpacing: 4,
          mainAxisSpacing: 4,
        ),
        itemCount: mediaPaths.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => FullScreenImage(
                    mediaPaths: mediaPaths,
                    initialIndex: index,
                  ),
                ),
              );
            },
            child: Image.file(
              File(mediaPaths[index]),
              fit: BoxFit.cover, // Les images ne seront pas rognées
              filterQuality: FilterQuality.low, // Amélioration de la qualité
            ),
          );
        },
      ),
    );
  }
}

class FullScreenImage extends StatefulWidget {
  final List<dynamic> mediaPaths;
  final int initialIndex;

  FullScreenImage({required this.mediaPaths, required this.initialIndex});

  @override
  _FullScreenImageState createState() => _FullScreenImageState();
}

class _FullScreenImageState extends State<FullScreenImage> {
  late PageController _pageController;
  late int currentIndex;

  @override
  void initState() {
    super.initState();
    currentIndex = widget.initialIndex;
    _pageController = PageController(initialPage: currentIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black, // Fond noir
      appBar: AppBar(
        backgroundColor: Colors.black, // Fond noir pour la barre
        iconTheme: IconThemeData(color: Colors.white),
        elevation: 0,
      ),
      body: PageView.builder(
        controller: _pageController,
        itemCount: widget.mediaPaths.length,
        onPageChanged: (index) {
          setState(() {
            currentIndex = index;
          });
        },
        itemBuilder: (context, index) {
          return Card(
            color: Colors.black, // Fond noir pour la carte
            child: Image.file(
              File(widget.mediaPaths[index]),
              fit: BoxFit
                  .fitWidth, // Occupe toute la largeur tout en gardant les proportions
              filterQuality: FilterQuality.high, // Meilleure qualité
            ),
          );
        },
      ),
    );
  }
}
