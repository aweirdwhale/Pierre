// // MediaHelper class gets every media file in an array

import 'dart:io';

class MediaHandler {
  bool isMedia(file) {
    if (file.path.endsWith('.jpeg') ||
        file.path.endsWith('.jpg') ||
        file.path.endsWith('.png') ||
        file.path.endsWith('.webp')) {
      return true;
    }
    return false;
  }

  // Getting media from gallery
  Future<void> getAllMediaPaths(dir, List<dynamic> mediaPaths) async {
    // for each folder in dir, print its name and append path
    for (var folder in dir.listSync()) {
      if (folder is Directory && folder.path != '/storage/emulated/0/Android') {
        // print(folder); // pour etre sur
        for (var file in folder.listSync()) {
          if (isMedia(file)) {
            mediaPaths.add(file.path);
          }
        }
        // mediaPaths.add(folder);
        getAllMediaPaths(folder, mediaPaths);
      }
    }
  }

  // TODO : Downloading media from Google Photos
  //
}

// Use Example
/*
List<dynamic> getMedia() {
  //call mediaHelper to get all media files
  MediaHandler mediaHelper = MediaHandler();

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
*/
