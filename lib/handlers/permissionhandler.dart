import 'package:permission_handler/permission_handler.dart';

class PermissionHandler {
  Future<PermissionStatus> getPermsStatus() async {
    PermissionStatus mediaAccess =
        await Permission.manageExternalStorage.status;

    return mediaAccess;
  }

  Future<bool> isPermGranted() async {
    PermissionStatus perm = await getPermsStatus();

    if (perm.isGranted) {
      print("[PERMISSION HANDLER] Permissions accordées.");
      return true;
    }

    print("[PERMISSION HANDLER] Permissions refusées.");
    return false;
  }

  Future<bool> requestPerm() async {
    bool isGranted = await isPermGranted();

    if (isGranted) {
      return true;
    }

    print("[PERMISSION HANDLER] En attente d'authorisation.");
    await Permission.manageExternalStorage.request();

    isGranted = await isPermGranted();
    return isGranted;
  }
}
