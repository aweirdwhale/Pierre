import 'package:permission_handler/permission_handler.dart';

class Permissionhandler {
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

  Future<void> requestPerm() async {
    bool isGranted = await isPermGranted();

    if (isGranted) {
      return;
    }

    print("[PERMISSION HANDLER] En attente d'authorisation.");
    await Permission.manageExternalStorage.request();
  }
}
