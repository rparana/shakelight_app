import 'package:permission_handler/permission_handler.dart';

abstract class PermissionService {
  Future<bool> requestCameraPermission();
  Future<bool> requestMotionPermission();
  Future<bool> requestBackgroundPermission();
  Future<bool> requestNotificationPermission();
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
    if (await Permission.ignoreBatteryOptimizations.request().isGranted) {
      return true;
    }
    return false;
  }

  @override
  Future<bool> requestNotificationPermission() async {
    final status = await Permission.notification.request();
    return status.isGranted;
  }

  @override
  Future<bool> hasAllPermissions() async {
    final camera = await Permission.camera.status.isGranted;
    final sensors = await Permission.sensors.status.isGranted;
    final notifications = await Permission.notification.status.isGranted;
    return camera && sensors && notifications;
  }
}
