import 'dart:async';
import 'package:sensors_plus/sensors_plus.dart';
import '../data/models/shake_direction.dart';

abstract class ShakeDetectionService {
  StreamSubscription<AccelerometerEvent>? listen(
    void Function() onShake, {
    double threshold = 12.0,
    ShakeDirection direction = ShakeDirection.horizontal,
  });
}

class ShakeDetectionServiceImpl implements ShakeDetectionService {
  final Stream<AccelerometerEvent>? _stream;

  ShakeDetectionServiceImpl({Stream<AccelerometerEvent>? stream}) : _stream = stream;

  Stream<AccelerometerEvent> get _eventStream => _stream ?? accelerometerEventStream();

  @override
  StreamSubscription<AccelerometerEvent>? listen(
    void Function() onShake, {
    double threshold = 12.0,
    ShakeDirection direction = ShakeDirection.horizontal,
  }) {
    int peakCount = 0;
    DateTime? lastPeakTime;
    double lastPeakValue = 0;

    return _eventStream.listen((AccelerometerEvent event) {
      double value;
      if (direction == ShakeDirection.horizontal) {
        value = event.x;
      } else {
        // Vertical considers Y or Z
        value = event.y.abs() > event.z.abs() ? event.y : event.z;
      }

      if (value.abs() > threshold) {
        final now = DateTime.now();
        
        // Check if it's a consecutive shake in opposite direction
        if (lastPeakTime != null && now.difference(lastPeakTime!).inMilliseconds < 600) {
          // Check for sign change to ensure it's a "back and forth" movement
          if ((value > 0 && lastPeakValue < 0) || (value < 0 && lastPeakValue > 0)) {
            peakCount++;
            if (peakCount >= 1) { // 1 additional peak after the first one = 2 total
              onShake();
              peakCount = 0; // Reset after toggle
              lastPeakTime = null;
              return;
            }
          }
        } else {
          peakCount = 0; // Reset if too long since last peak
        }
        
        lastPeakTime = now;
        lastPeakValue = value;
      }
    });
  }
}
