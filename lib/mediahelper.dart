// // MediaHelper class gets every media file in an array

import 'dart:io';

class MediaHelper {
  bool isMedia(file) {
    if (file.path.endsWith('.jpeg') ||
        file.path.endsWith('.jpg') ||
        file.path.endsWith('.png') ||
        file.path.endsWith('.webp')) {
      return true;
    }
    return false;
  }

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
}

// class MediaHelper {
//   Future getAllMediaPaths(List mediaPaths) async {
//     // Get all media in the directory
//     var dir = Directory('/storage/emulated/0/');
//     // for each folder under dir (except Android) get all media files
//     for (var entity in dir.listSync()) {
//       if (entity is Directory && entity.path != '/storage/emulated/0/Android') {
//         for (var file in entity.listSync()) {
//           if (file.path.endsWith('.jpeg') ||
//               file.path.endsWith('.jpg') ||
//               file.path.endsWith('.png') ||
//               file.path.endsWith('.webp')) {
//             mediaPaths.add(file.path);
//           }
//         }
//       }
//     }
//   }
// }

// class MediaHelper {
//   Future<void> getAllMediaPaths(List<String> mediaPaths) async {
//     var dir = Directory('/storage/emulated/0/');
//     await _scanDirectory(dir, mediaPaths);
//   }

//   Future<void> _scanDirectory(
//       Directory directory, List<String> mediaPaths) async {
//     try {
//       // Liste tous les fichiers/dossiers dans le répertoire
//       await for (var entity
//           in directory.list(recursive: true, followLinks: false)) {
//         if (entity is File && _isImageFile(entity.path)) {
//           mediaPaths.add(entity.path);
//         }
//       }
//     } catch (e) {
//       print("Erreur en scannant ${directory.path}: $e");
//     }
//   }

//   bool _isImageFile(String path) {
//     return path.endsWith('.jpeg') ||
//         path.endsWith('.jpg') ||
//         path.endsWith('.png') ||
//         path.endsWith('.webp');
//   }
// }
