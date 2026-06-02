import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shakelight_app/presentation/screens/home_screen.dart';
import 'package:shakelight_app/presentation/providers/flashlight_provider.dart';
import 'package:shakelight_app/presentation/providers/permission_provider.dart';
import 'package:shakelight_app/services/flashlight_service.dart';
import 'package:shakelight_app/services/permission_service.dart';
import 'package:shakelight_app/presentation/widgets/status_icon.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:shakelight_app/presentation/providers/base_providers.dart';

@GenerateMocks([FlashlightService, PermissionService, SharedPreferences])
import 'home_screen_ui_test.mocks.dart';

void main() {
  testWidgets('US2: Home Screen UI and Tappable Icon test', (WidgetTester tester) async {
    final mockFlashlightService = MockFlashlightService();
    final mockPermissionService = MockPermissionService();
    final mockPrefs = MockSharedPreferences();
    
    when(mockPrefs.getDouble(any)).thenReturn(50.0);
    when(mockPrefs.getBool(any)).thenReturn(false);
    when(mockPrefs.getString(any)).thenReturn(null);

    when(mockPermissionService.hasAllPermissions()).thenAnswer((_) async => true);
    when(mockPermissionService.requestCameraPermission()).thenAnswer((_) async => true);
    when(mockPermissionService.requestMotionPermission()).thenAnswer((_) async => true);
    when(mockPermissionService.requestBackgroundPermission()).thenAnswer((_) async => true);
    when(mockPermissionService.requestNotificationPermission()).thenAnswer((_) async => true);
    when(mockFlashlightService.isFlashlightAvailable()).thenAnswer((_) async => true);
    when(mockFlashlightService.toggle(any)).thenAnswer((_) async {});

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          sharedPreferencesProvider.overrideWithValue(mockPrefs),
          flashlightServiceProvider.overrideWithValue(mockFlashlightService),
          permissionServiceProvider.overrideWithValue(mockPermissionService),
        ],
        child: const MaterialApp(home: HomeScreen()),
      ),
    );

    await tester.pumpAndSettle();

    // Verify StatusIcon is present
    expect(find.byType(StatusIcon), findsOneWidget);
    expect(find.byIcon(Icons.flashlight_off), findsOneWidget);
    
    // Verify ManualToggleButton is GONE
    expect(find.text('Turn ON'), findsNothing);

    // Tap status icon to toggle
    await tester.tap(find.byType(StatusIcon));
    await tester.pump();

    // Verify state change (On)
    expect(find.byIcon(Icons.flashlight_on), findsOneWidget);
    
    verify(mockFlashlightService.toggle(true)).called(1);
  });
}
