import 'package:permission_handler/permission_handler.dart';

class AskPermission {

  static Future<bool> checkStorage() async {
    var status = await Permission.storage.status;
    if (status.isGranted) return true;
    return await Permission.storage.request().isGranted;
  }

  static Future<bool> checkCamera() async {
    var status = await Permission.camera.status;
    if (status.isGranted) return true;
    return await Permission.storage.request().isGranted;
  }
}
