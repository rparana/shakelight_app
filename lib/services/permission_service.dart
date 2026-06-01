import 'package:permission_handler/permission_handler.dart';

abstract class PermissionService {
  Future<bool> requestCameraPermission();
  Future<bool> requestMotionPermission();
  Future<bool> requestBackgroundPermission();
  Future<bool> hasAllPermissions();
}

class PermissionServiceImpl implements PermissionService {
  @override
  Future<bool> requestCameraPermission() async {
    final status = await Permission.camera.request();
    return status.isGranted;
  }

  @override
  Future<bool> requestMotionPermission() async {
    final status = await Permission.sensors.request();
    return status.isGranted;
  }

  @override
  Future<bool> requestBackgroundPermission() async {
    // Note: Background permissions on Android/iOS are complex and handled by specific plugins.
    // permission_handler can check some, but flutter_background_service might handle its own.
    // For now, we'll check ignoreBatteryOptimizations on Android as a proxy for background capability.
    if (await Permission.ignoreBatteryOptimizations.request().isGranted) {
      return true;
    }
    return false;
  }

  @override
  Future<bool> hasAllPermissions() async {
    final camera = await Permission.camera.status.isGranted;
    final sensors = await Permission.sensors.status.isGranted;
    return camera && sensors;
  }
}
