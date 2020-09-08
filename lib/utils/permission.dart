import 'package:permission_handler/permission_handler.dart';

class AskPermission {
  static Future<bool> checkPermissions() async {
    Map<Permission, PermissionStatus> statuses = await [
      Permission.camera,
      Permission.storage,
    ].request();
    statuses.forEach((key, value) {
      if (value != PermissionStatus.granted) {
        return false;
      }
    });
    return true;
  }

  static Future<bool> checkStorage() async {
    return await Permission.storage.request() == PermissionStatus.granted;
  }

  static Future<bool> checkCamera() async {
    return await Permission.storage.request() == PermissionStatus.granted;
  }
}
