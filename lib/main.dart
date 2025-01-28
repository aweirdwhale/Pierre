import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:io';
// ext classes
import 'mediahelper.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Photos(),
    );
  }
}

class Photos extends StatefulWidget {
  @override
  PhotoState createState() => PhotoState();
}

class PhotoState extends State<Photos> {
  @override
  void initState() {
    super.initState();
    // ask for perms
    askPermission();
  }

  Future<bool> askPermission() async {
    PermissionStatus mediaAccess =
        await Permission.manageExternalStorage.status;
    if (mediaAccess.isGranted) {
      print("Permissions {manageExternalStorage} accordées");
      return true;
    } else {
      print("Permissions {manageExternalStorage} refusées ");

      askPermission();

      return false;
    }
  }

  List<dynamic> getMedia() {
    //call mediaHelper to get all media files
    MediaHelper mediaHelper = MediaHelper();

    // Liste vide
    List<dynamic> mediaPaths = [];

    // root directory
    var dir = Directory('/storage/emulated/0/');
    mediaHelper.getAllMediaPaths(dir, mediaPaths);

    //print le nb d'images
    print("Nombre d'images :");
    print(mediaPaths.length);
    return mediaPaths;
  }

  @override
  Widget build(BuildContext context) {
    List<dynamic> images = getMedia();

    return Scaffold(
      appBar: AppBar(
        title: Text('Pierre'),
      ),
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 4,
          mainAxisSpacing: 4,
        ),
        itemCount: images.length,
        itemBuilder: (context, index) {
          return Image.file(
            File(images[index]),
            fit: BoxFit.cover,
          );
        },
      ),
    );
  }
}
