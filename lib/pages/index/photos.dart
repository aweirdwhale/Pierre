import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pierre/pages/index/fullscreen.dart';

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
  // Using mediastore to get images
  static const platform = MethodChannel('com.example.pierre/media');
  List<String> mediaPaths = [];
  bool isLoading = true;

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${mediaPaths.length} photos.'),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3, // Nombre de colonnes
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
                    fit: BoxFit.cover,
                    filterQuality: FilterQuality.none, // 10x faster
                    cacheWidth: 300,
                  ),
                );
              },
            ),
    );
  }
}
