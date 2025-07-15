import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:permission_handler/permission_handler.dart';

//Control use Gallery permision
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

//Control use Camera permision
Future<bool> isPermissionCameraGranted() async {
  if (Platform.isAndroid) {
    final androidInfo = await DeviceInfoPlugin().androidInfo;

    if (androidInfo.version.sdkInt >= 33) {
      // For Android 13 (API 33) and above: request camera access permission
      var status = await Permission.camera.request();
      return status.isGranted;
    } else {
      // For Android versions below 13: request camera access permission
      var status = await Permission.camera.request();
      return status.isGranted;
    }
  } else if (Platform.isIOS) {
    // For iOS: request camera access permission
    var status = await Permission.camera.request();
    return status.isGranted;
  }

  // For other platforms: deny by default
  return false;
}

//Control use Location permision
Future<bool> isPermissionLocationGranted() async {
  if (Platform.isAndroid) {
    final androidInfo = await DeviceInfoPlugin().androidInfo;
    if (androidInfo.version.sdkInt >= 33) {
      // For Android 13 (API 33) and above: request location access permission
      var status = await Permission.location.request();
      return status.isGranted;
    } else {
      // For Android versions below 13: request location access permission
      var status = await Permission.location.request();
      return status.isGranted;
    }
  } else if (Platform.isIOS) {
    // For iOS: request location access permission
    var status = await Permission.location.request();
    return status.isGranted;
  }

  // For other platforms: deny by default
  return false;
}
