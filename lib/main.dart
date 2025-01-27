// import 'package:flutter/material.dart';
// // import 'classes/mediaprovider.dart';
// import 'package:permission_handler/permission_handler.dart';
// import '/mediastore.dart';
// import 'dart:io';

// void main() {
//   runApp(App());
// }

// // Permission handler (android 6+)
// Future<void> requestPermission() async {
//   var status = await Permission.storage.request();
//   if (status.isGranted) {
//     print("Permission accordée");
//     // Crash l'app
//   } else {
//     print("!! Permission refusée !!");
//   }
// }

// class App extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: ImageGallery(),
//     );
//   }
// }

// class ImageGallery extends StatefulWidget {
//   @override
//   ImageGalleryState createState() => ImageGalleryState();
// }

// class ImageGalleryState extends State<ImageGallery> {
//   List<String> images = [];

//   @override
//   void initState() {
//     super.initState();

//     loadImages();
//   }

//   Future<void> loadImages() async {
//     // Demande la permission et récupère les images
//     await requestPermission();

//     final imgList = await MediaStoreHelper.getAllImages();
//     setState(() {
//       images = imgList;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text("Galerie d'images")),
//       body: images.isEmpty
//           ? Center(child: CircularProgressIndicator())
//           : GridView.builder(
//               gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                 crossAxisCount: 3,
//                 crossAxisSpacing: 4,
//                 mainAxisSpacing: 4,
//               ),
//               itemCount: images.length,
//               itemBuilder: (context, index) {
//                 return Image.file(
//                   File(images[index]),
//                   fit: BoxFit.cover,
//                 );
//               },
//             ),
//     );
//   }
// }

// // import 'package:flutter/material.dart';

// // void main() {
// //   runApp(TestApp());
// // }

// // class TestApp extends StatelessWidget {
// //   @override
// //   Widget build(BuildContext context) {
// //     return MaterialApp(
// //       home: Scaffold(
// //         appBar: AppBar(
// //           title: Text('Test App'),
// //         ),
// //         body: Center(
// //           child: Text('Hello, this is a test app!'),
// //         ),
// //       ),
// //     );
// //   }
// // }

import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: PermissionTestScreen(),
    );
  }
}

class PermissionTestScreen extends StatefulWidget {
  @override
  PermissionTestScreenState createState() => PermissionTestScreenState();
}

class PermissionTestScreenState extends State<PermissionTestScreen> {
  String permissionStatus = "Vérification des permissions...";

  @override
  void initState() {
    super.initState();
    _checkPermission();
  }

  Future<void> _checkPermission() async {
    // Vérifie d'abord si la permission est déjà accordée
    var status = await Permission.storage.status;

    if (status.isGranted) {
      setState(() {
        permissionStatus = "Permission accordée";
      });
    } else {
      // Demande la permission
      status = await Permission.storage.request();
      if (status.isGranted) {
        setState(() {
          permissionStatus = "Permission accordée";
        });
      } else {
        setState(() {
          permissionStatus = "!! Permission refusée !!";
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Test de Permissions")),
      body: Center(
        child: Text(
          permissionStatus,
          style: TextStyle(fontSize: 18),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
