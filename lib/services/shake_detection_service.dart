import 'dart:async';
import 'dart:math';
import 'package:sensors_plus/sensors_plus.dart';

abstract class ShakeDetectionService {
  StreamSubscription<AccelerometerEvent>? listen(
    void Function() onShake, {
    double threshold = 12.0,
  });
}

class ShakeDetectionServiceImpl implements ShakeDetectionService {
  @override
  StreamSubscription<AccelerometerEvent>? listen(
    void Function() onShake, {
    double threshold = 12.0,
  }) {
    DateTime lastShake = DateTime.now();
    
    return accelerometerEventStream().listen((AccelerometerEvent event) {
      final double gForce = sqrt(event.x * event.x + event.y * event.y + event.z * event.z);
      
      if (gForce > threshold) {
        final now = DateTime.now();
        if (now.difference(lastShake).inMilliseconds > 500) {
          lastShake = now;
          onShake();
        }
      }
    });
  }
}
