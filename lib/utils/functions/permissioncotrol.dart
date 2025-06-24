import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:permission_handler/permission_handler.dart';

Future<bool> isPermissionStorageGranted() async {
  if (Platform.isAndroid) {
    final androidInfo = await DeviceInfoPlugin().androidInfo;

    if (androidInfo.version.sdkInt >= 33) {
      // For Android 13 (API 33) and above: request photo access permission
      var status = await Permission.photos.request();
      return status.isGranted;
    } else {
      // For Android versions below 13: request storage access permission
      var status = await Permission.storage.request();
      return status.isGranted;
    }
  } else if (Platform.isIOS) {
    // For iOS: request photo access permission
    var status = await Permission.photos.request();
    return status.isGranted;
  }

  // For other platforms: deny by default
  return false;
}

Future<bool> isPermissionCameraGranted() async {
  if (Platform.isAndroid) {
    final androidInfo = await DeviceInfoPlugin().androidInfo;

    if (androidInfo.version.sdkInt >= 33) {
      // For Android 13 (API 33) and above: request photo access permission
      var status = await Permission.camera.request();
      return status.isGranted;
    } else {
      // For Android versions below 13: request storage access permission
      var status = await Permission.camera.request();
      return status.isGranted;
    }
  } else if (Platform.isIOS) {
    // For iOS: request photo access permission
    var status = await Permission.camera.request();
    return status.isGranted;
  }

  // For other platforms: deny by default
  return false;
}
