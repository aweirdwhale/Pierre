package com.example.pierre

import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

import android.provider.MediaStore
import android.database.Cursor
import android.net.Uri
import android.content.ContentResolver

import android.util.Log // Ajoute cet import

class MainActivity: FlutterActivity() {
    private val CHANNEL = "media_store"

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler { call, result ->
            if (call.method == "getImages") {
                try {
                    val images = getAllImagesFromMediaStore()
                    Log.d("MediaStore", "Images trouvées : ${images.size}")
                    result.success(images)
                } catch (e: Exception) {
                    Log.e("MediaStore", "Erreur lors de la récupération des images", e)
                    result.error("ERROR", "Erreur lors de la récupération des images", null)
                }
            } else {
                result.notImplemented()
            }
        }
    }

    private fun getAllImagesFromMediaStore(): List<String> {
        Log.d("MediaStore", "Début de la récupération des images...")
        val imagePaths = mutableListOf<String>()
        val projection = arrayOf(
            MediaStore.Images.Media.DATA // Récupère les chemins des images
        )

        val cursor: Cursor? = contentResolver.query(
            MediaStore.Images.Media.EXTERNAL_CONTENT_URI,
            projection,
            null,
            null,
            "${MediaStore.Images.Media.DATE_ADDED} DESC LIMIT 50" // limite à 50 images
        )

        cursor?.use {
            val columnIndexData = cursor.getColumnIndexOrThrow(MediaStore.Images.Media.DATA)
            while (cursor.moveToNext()) {
                val absolutePath = cursor.getString(columnIndexData)
                imagePaths.add(absolutePath)
            }
        }

        Log.d("MediaStore", "Images récupérées : ${imagePaths.size}")
        return imagePaths
    }
}
