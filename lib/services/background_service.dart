import 'dart:async';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_background_service_android/flutter_background_service_android.dart';
import 'shake_detection_service.dart';
import 'flashlight_service.dart';

class BackgroundMonitoringService {
  static Future<void> initialize() async {
    final service = FlutterBackgroundService();

    await service.configure(
      androidConfiguration: AndroidConfiguration(
        onStart: onStart,
        autoStart: false,
        isForegroundMode: true,
        notificationChannelId: 'shakelight_monitoring',
        initialNotificationTitle: 'ShakeLight Active',
        initialNotificationContent: 'Monitoring for shake gestures...',
      ),
      iosConfiguration: IosConfiguration(
        autoStart: false,
        onForeground: onStart,
        onBackground: onIosBackground,
      ),
    );
  }

  static Future<bool> onIosBackground(ServiceInstance service) async {
    return true;
  }
}

bool _isActive = false;

@pragma('vm:entry-point')
void onStart(ServiceInstance service) async {
  DartPluginRegistrant.ensureInitialized();

  final shakeService = ShakeDetectionServiceImpl();
  final flashlightService = FlashlightServiceImpl();

  if (service is AndroidServiceInstance) {
    service.on('setAsForeground').listen((event) {
      service.setAsForegroundService();
    });

    service.on('setAsBackground').listen((event) {
      service.setAsBackgroundService();
    });
  }

  service.on('stopService').listen((event) {
    service.stopSelf();
  });

  // Start monitoring
  shakeService.listen(() async {
    final available = await flashlightService.isFlashlightAvailable();
    if (available) {
      _isActive = !_isActive;
      await flashlightService.toggle(_isActive);
    }
  }, threshold: 15.0);
}
