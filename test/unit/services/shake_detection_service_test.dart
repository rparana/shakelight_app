import 'dart:async';
import 'package:flutter_test/flutter_test.dart';
import 'package:shakelight_app/services/shake_detection_service.dart';
import 'package:shakelight_app/data/models/shake_direction.dart';
import 'package:sensors_plus/sensors_plus.dart';

void main() {
  group('ShakeDetectionService', () {
    late ShakeDetectionServiceImpl service;
    late StreamController<AccelerometerEvent> controller;

    setUp(() {
      controller = StreamController<AccelerometerEvent>();
      service = ShakeDetectionServiceImpl(stream: controller.stream);
    });

    tearDown(() {
      controller.close();
    });

    test('T008/T009 [US1]: Toggles on 2 consecutive horizontal shakes (Horizontal mode)', () async {
      int shakeCount = 0;
      service.listen(
        () => shakeCount++,
        direction: ShakeDirection.horizontal,
        threshold: 10.0,
      );

      // First peak: Positive X
      controller.add(AccelerometerEvent(11.0, 0.0, 0.0, DateTime.now()));
      await Future.delayed(Duration.zero);
      expect(shakeCount, 0);

      // Second peak: Negative X (Consecutive)
      controller.add(AccelerometerEvent(-11.0, 0.0, 0.0, DateTime.now()));
      await Future.delayed(Duration.zero);
      expect(shakeCount, 1);
    });

    test('T008 [US1]: Does not toggle on vertical shakes in horizontal mode', () async {
      int shakeCount = 0;
      service.listen(
        () => shakeCount++,
        direction: ShakeDirection.horizontal,
        threshold: 10.0,
      );

      // First peak: Positive Y
      controller.add(AccelerometerEvent(0.0, 11.0, 0.0, DateTime.now()));
      await Future.delayed(Duration.zero);
      
      // Second peak: Negative Y
      controller.add(AccelerometerEvent(0.0, -11.0, 0.0, DateTime.now()));
      await Future.delayed(Duration.zero);
      
      expect(shakeCount, 0);
    });

    test('T008 [US1]: Toggles on 2 consecutive vertical shakes (Vertical mode)', () async {
      int shakeCount = 0;
      service.listen(
        () => shakeCount++,
        direction: ShakeDirection.vertical,
        threshold: 10.0,
      );

      // First peak: Positive Y
      controller.add(AccelerometerEvent(0.0, 11.0, 0.0, DateTime.now()));
      await Future.delayed(Duration.zero);
      
      // Second peak: Negative Y
      controller.add(AccelerometerEvent(0.0, -11.0, 0.0, DateTime.now()));
      await Future.delayed(Duration.zero);
      
      expect(shakeCount, 1);
    });

    test('T009 [US1]: Does not toggle if peaks are too far apart', () async {
      int shakeCount = 0;
      service.listen(
        () => shakeCount++,
        direction: ShakeDirection.horizontal,
        threshold: 10.0,
      );

      controller.add(AccelerometerEvent(11.0, 0.0, 0.0, DateTime.now()));
      await Future.delayed(Duration.zero);
      
      // Wait longer than the 600ms window
      await Future.delayed(const Duration(milliseconds: 700));
      
      controller.add(AccelerometerEvent(-11.0, 0.0, 0.0, DateTime.now()));
      await Future.delayed(Duration.zero);
      
      expect(shakeCount, 0);
    });

    test('T009 [US1]: Does not toggle if peaks have the same sign', () async {
      int shakeCount = 0;
      service.listen(
        () => shakeCount++,
        direction: ShakeDirection.horizontal,
        threshold: 10.0,
      );

      controller.add(AccelerometerEvent(11.0, 0.0, 0.0, DateTime.now()));
      await Future.delayed(Duration.zero);
      
      controller.add(AccelerometerEvent(12.0, 0.0, 0.0, DateTime.now()));
      await Future.delayed(Duration.zero);
      
      expect(shakeCount, 0);
    });
  });
}
