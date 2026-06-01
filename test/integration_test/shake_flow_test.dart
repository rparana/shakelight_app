import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shakelight_app/presentation/screens/home_screen.dart';
import 'package:shakelight_app/presentation/providers/flashlight_provider.dart';
import 'package:shakelight_app/presentation/providers/permission_provider.dart';
import 'package:shakelight_app/presentation/providers/shake_monitoring_provider.dart';
import 'package:shakelight_app/services/flashlight_service.dart';
import 'package:shakelight_app/services/permission_service.dart';
import 'package:shakelight_app/services/shake_detection_service.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shakelight_app/presentation/providers/base_providers.dart';

@GenerateMocks([FlashlightService, PermissionService, ShakeDetectionService, SharedPreferences])
import 'shake_flow_test.mocks.dart';

void main() {
  testWidgets('Shake to Toggle flow test', (WidgetTester tester) async {
    final mockFlashlightService = MockFlashlightService();
    final mockPermissionService = MockPermissionService();
    final mockShakeService = MockShakeDetectionService();
    final mockPrefs = MockSharedPreferences();
    
    when(mockPrefs.getDouble(any)).thenReturn(50.0);
    when(mockPrefs.getBool(any)).thenReturn(true);
    
    when(mockPermissionService.hasAllPermissions()).thenAnswer((_) async => true);
    when(mockPermissionService.requestCameraPermission()).thenAnswer((_) async => true);
    when(mockPermissionService.requestMotionPermission()).thenAnswer((_) async => true);
    when(mockPermissionService.requestBackgroundPermission()).thenAnswer((_) async => true);
    
    when(mockFlashlightService.isFlashlightAvailable()).thenAnswer((_) async => true);
    when(mockFlashlightService.toggle(any)).thenAnswer((_) async {});

    void Function()? shakeCallback;
    when(mockShakeService.listen(any, threshold: anyNamed('threshold'))).thenAnswer((invocation) {
      shakeCallback = invocation.positionalArguments[0] as void Function();
      return null;
    });

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          sharedPreferencesProvider.overrideWithValue(mockPrefs),
          flashlightServiceProvider.overrideWithValue(mockFlashlightService),
          permissionServiceProvider.overrideWithValue(mockPermissionService),
          shakeDetectionServiceProvider.overrideWithValue(mockShakeService),
        ],
        child: const MaterialApp(home: HomeScreen()),
      ),
    );

    await tester.pumpAndSettle();

    expect(shakeCallback, isNotNull);

    // Trigger shake
    shakeCallback!();
    await tester.pumpAndSettle();

    // Verify state change (On)
    expect(find.byIcon(Icons.flashlight_on), findsOneWidget);
    verify(mockFlashlightService.toggle(true)).called(1);
  });
}
