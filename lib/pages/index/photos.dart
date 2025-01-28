import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pierre/pages/index/albums.dart';
import 'fullscreen.dart'; // Page pour afficher l'image en plein écran

void main() {
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
  static const platform = MethodChannel('com.example.pierre/media');
  List<String> mediaPaths = [];
  bool isLoading = true;
  int _currentIndex = 0; // Indice de l'onglet sélectionné

  @override
  void initState() {
    super.initState();
    loadMedia();
  }

  // Charge toutes les images depuis MediaStore via le channel natif
  Future<void> loadMedia() async {
    try {
      final List<dynamic> paths = await platform.invokeMethod('getMedia');
      setState(() {
        mediaPaths = paths.cast<String>();
        isLoading = false;
      });
    } on PlatformException catch (e) {
      print("Erreur lors de la récupération des médias : ${e.message}");
    }
  }

  // Fonction pour afficher les photos
  Widget _buildPhotosPage() {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          title: Text(
            '${mediaPaths.length} photos',
            style: TextStyle(fontSize: 20, color: Colors.blueGrey),
          ),
          centerTitle: true,
          floating: true, // Permet à l'AppBar de disparaître lors du défilement
          snap:
              true, // AppBar revient immédiatement quand on fait défiler vers le haut
          elevation: 0,
          backgroundColor: Colors.transparent,
        ),
        SliverGrid(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3, // Nombre de colonnes
            crossAxisSpacing: 4,
            mainAxisSpacing: 4,
          ),
          delegate: SliverChildBuilderDelegate(
            (context, index) {
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
                  fit: BoxFit.cover,
                  filterQuality: FilterQuality.none, // 10x plus rapide
                  cacheWidth: 300,
                ),
              );
            },
            childCount: mediaPaths.length,
          ),
        ),
      ],
    );
  }

  // Fonction pour afficher les albums (pour l'instant c'est un exemple)
  Widget _buildAlbumsPage() {
    return (Albums());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('(Pierre.)'),
      ),
      body: _currentIndex == 0 ? _buildPhotosPage() : _buildAlbumsPage(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index; // Change l'onglet sélectionné
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.photo_album),
            label: 'Photos',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.folder),
            label: 'Albums',
          ),
        ],
      ),
    );
  }
}
