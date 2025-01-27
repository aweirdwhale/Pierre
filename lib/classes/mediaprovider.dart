import 'dart:io';

class MediaPathsProvider {
  Future getAllMediaPaths(List mediaPaths) async {
    // Get all media in the directory
    var dir = Directory('/storage/emulated/0/');
    // for each folder under dir (except Android) get all media files
    for (var entity in dir.listSync()) {
      if (entity is Directory && entity.path != '/storage/emulated/0/Android') {
        for (var file in entity.listSync()) {
          mediaPaths.add("mashallah");
        }
      }
      return 1;
    }
  }
}
