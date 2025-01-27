import 'package:flutter/services.dart';

class MediaStoreHelper {
  static const MethodChannel _channel = MethodChannel('media_store');

  static Future<List<String>> getAllImages() async {
    try {
      // Appelle la méthode native via MethodChannel
      final List<dynamic> images = await _channel.invokeMethod('getImages');
      return images.cast<String>();
    } catch (e) {
      print("Erreur lors de la récupération des images : $e");
      return [];
    }
  }
}
