import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../services/permission_service.dart';

final permissionServiceProvider = Provider<PermissionService>((ref) {
  return PermissionServiceImpl();
});

final hasPermissionsProvider = NotifierProvider<PermissionNotifier, bool>(() {
  return PermissionNotifier();
});

class PermissionNotifier extends Notifier<bool> {
  @override
  bool build() {
    checkPermissions();
    return false;
  }

  Future<void> checkPermissions() async {
    final service = ref.read(permissionServiceProvider);
    state = await service.hasAllPermissions();
  }

  Future<void> requestAll() async {
    final service = ref.read(permissionServiceProvider);
    final camera = await service.requestCameraPermission();
    final sensors = await service.requestMotionPermission();
    final background = await service.requestBackgroundPermission();
    final notifications = await service.requestNotificationPermission();

    state = camera && sensors && background && notifications;
  }
}
