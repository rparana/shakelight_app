import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shakelight_app/presentation/screens/settings_screen.dart';
import 'package:shakelight_app/presentation/providers/base_providers.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shakelight_app/data/models/shake_direction.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';

@GenerateMocks([SharedPreferences])
import 'settings_ui_test.mocks.dart';

void main() {
  testWidgets('US2: Settings UI interaction test with new controls', (WidgetTester tester) async {
    final mockPrefs = MockSharedPreferences();
    
    when(mockPrefs.getDouble(any)).thenReturn(50.0);
    when(mockPrefs.getBool(any)).thenReturn(true);
    when(mockPrefs.getString(any)).thenReturn(ShakeDirection.horizontal.name);
    
    when(mockPrefs.setDouble(any, any)).thenAnswer((_) async => true);
    when(mockPrefs.setBool(any, any)).thenAnswer((_) async => true);
    when(mockPrefs.setString(any, any)).thenAnswer((_) async => true);

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
    expect(find.text('Haptic Feedback'), findsOneWidget);
    expect(find.text('Shake Direction'), findsOneWidget);
    expect(find.text('Horizontal'), findsOneWidget);

    // Toggle haptic
    await tester.tap(find.text('Haptic Feedback'));
    await tester.pump();
    verify(mockPrefs.setBool('haptic_enabled', false)).called(1);

    // Change direction
    await tester.tap(find.text('Horizontal'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Vertical').last);
    await tester.pumpAndSettle();
    verify(mockPrefs.setString('shake_direction', 'vertical')).called(1);
  });
}
