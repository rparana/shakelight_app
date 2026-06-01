import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../services/shake_detection_service.dart';
import 'flashlight_provider.dart';
import 'permission_provider.dart';
import 'settings_provider.dart';

final shakeDetectionServiceProvider = Provider<ShakeDetectionService>((ref) {
  return ShakeDetectionServiceImpl();
});

final shakeMonitoringProvider = Provider<ShakeMonitoringNotifier>((ref) {
  final notifier = ShakeMonitoringNotifier(ref);
  
  // Auto-start/stop based on settings and permissions
  ref.listen(settingsProvider, (previous, next) {
    if (next.isServiceEnabled) {
      notifier.start();
    } else {
      notifier.stop();
    }
  });

  ref.listen(hasPermissionsProvider, (previous, next) {
    final settings = ref.read(settingsProvider);
    if (next && settings.isServiceEnabled) {
      notifier.start();
    }
  });

  return notifier;
});

class ShakeMonitoringNotifier {
  final Ref _ref;
  StreamSubscription? _subscription;

  ShakeMonitoringNotifier(this._ref);

  void start() {
    if (_subscription != null) stop();
    
    final service = _ref.read(shakeDetectionServiceProvider);
    final hasPermissions = _ref.read(hasPermissionsProvider);
    final settings = _ref.read(settingsProvider);
    
    if (!hasPermissions) return;
    if (!settings.isServiceEnabled) return;

    // Map 0-100 sensitivity to 25.0-10.0 G-force threshold
    final double threshold = 25.0 - (settings.sensitivity / 100.0 * 15.0);

    _subscription = service.listen(() {
      _ref.read(flashlightProvider.notifier).toggle();
    }, threshold: threshold);
  }

  void stop() {
    _subscription?.cancel();
    _subscription = null;
  }
}
