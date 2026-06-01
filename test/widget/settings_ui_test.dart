import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shakelight_app/presentation/screens/settings_screen.dart';
import 'package:shakelight_app/presentation/providers/base_providers.dart';
import 'package:shakelight_app/data/repositories/settings_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';

@GenerateMocks([SharedPreferences])
import 'settings_ui_test.mocks.dart';

void main() {
  testWidgets('Settings UI interaction test', (WidgetTester tester) async {
    final mockPrefs = MockSharedPreferences();
    
    when(mockPrefs.getDouble(any)).thenReturn(50.0);
    when(mockPrefs.getBool(any)).thenReturn(false);
    when(mockPrefs.setDouble(any, any)).thenAnswer((_) async => true);
    when(mockPrefs.setBool(any, any)).thenAnswer((_) async => true);

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          sharedPreferencesProvider.overrideWithValue(mockPrefs),
        ],
        child: const MaterialApp(home: SettingsScreen()),
      ),
    );

    await tester.pumpAndSettle();

    // Verify initial values
    expect(find.text('Enable Shake Detection'), findsOneWidget);
    expect(find.byType(Slider), findsOneWidget);

    // Toggle service
    await tester.tap(find.byType(Switch));
    await tester.pump();

    verify(mockPrefs.setBool('service_enabled', true)).called(1);
  });
}
