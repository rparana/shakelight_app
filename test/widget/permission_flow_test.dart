import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shakelight_app/presentation/screens/home_screen.dart';
import 'package:shakelight_app/presentation/providers/permission_provider.dart';
import 'package:shakelight_app/services/permission_service.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:shakelight_app/presentation/providers/base_providers.dart';

@GenerateMocks([PermissionService, SharedPreferences])
import 'permission_flow_test.mocks.dart';

void main() {
  testWidgets('Permission Request Flow test', (WidgetTester tester) async {
    final mockService = MockPermissionService();
    final mockPrefs = MockSharedPreferences();
    
    when(mockPrefs.getDouble(any)).thenReturn(50.0);
    when(mockPrefs.getBool(any)).thenReturn(false);

    when(mockService.hasAllPermissions()).thenAnswer((_) async => false);
    when(mockService.requestCameraPermission()).thenAnswer((_) async => true);
    when(mockService.requestMotionPermission()).thenAnswer((_) async => true);
    when(mockService.requestBackgroundPermission()).thenAnswer((_) async => true);

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          sharedPreferencesProvider.overrideWithValue(mockPrefs),
          permissionServiceProvider.overrideWithValue(mockService),
        ],
        child: const MaterialApp(home: HomeScreen()),
      ),
    );

    // Initial frame
    await tester.pump();
    
    // Verify that requestAll was called (indirectly via status update if we pumpped enough)
    // In our implementation, initState calls requestAll which eventually updates state.
    
    await tester.pumpAndSettle();
    
    expect(find.byIcon(Icons.flashlight_off), findsOneWidget);
  });
}
