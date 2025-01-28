package com.example.pierre

import android.os.Build
import android.provider.MediaStore
import androidx.annotation.NonNull
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity: FlutterActivity() {
    private val CHANNEL = "com.example.pierre/media"

    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler { call, result ->
            if (call.method == "getMedia") {
                val mediaPaths = getMediaPaths()
                result.success(mediaPaths)
            } else {
                result.notImplemented()
            }
        }
    }

    private fun getMediaPaths(): List<String> {
        val mediaPaths = mutableListOf<String>()

        val projection = arrayOf(
            MediaStore.Images.Media.DATA // Le chemin des fichiers images
        )
        val selection = null
        val selectionArgs = null
        val sortOrder = "${MediaStore.Images.Media.DATE_ADDED} DESC" // Trier par date

        val uri = MediaStore.Images.Media.EXTERNAL_CONTENT_URI
        val resolver = applicationContext.contentResolver
        val cursor = resolver.query(uri, projection, selection, selectionArgs, sortOrder)

        cursor?.use {
            val dataIndex = cursor.getColumnIndexOrThrow(MediaStore.Images.Media.DATA)
            while (cursor.moveToNext()) {
                val path = cursor.getString(dataIndex)
                mediaPaths.add(path)
            }
        }
        return mediaPaths
    }
}
