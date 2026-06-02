import 'package:flutter_test/flutter_test.dart';
import 'package:shakelight_app/data/repositories/settings_repository.dart';
import 'package:shakelight_app/data/models/app_settings.dart';
import 'package:shakelight_app/data/models/shake_direction.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';

@GenerateMocks([SharedPreferences])
import 'settings_repository_test.mocks.dart';

void main() {
  group('SettingsRepository', () {
    late MockSharedPreferences mockPrefs;
    late SettingsRepository repository;

    setUp(() {
      mockPrefs = MockSharedPreferences();
      repository = SettingsRepository(mockPrefs);
    });

    test('getSettings returns default values when no data exists', () {
      when(mockPrefs.getDouble('sensitivity')).thenReturn(null);
      when(mockPrefs.getBool('service_enabled')).thenReturn(null);
      when(mockPrefs.getBool('haptic_enabled')).thenReturn(null);
      when(mockPrefs.getString('shake_direction')).thenReturn(null);

      final settings = repository.getSettings();
      expect(settings.sensitivity, 50.0);
      expect(settings.isServiceEnabled, true);
      expect(settings.isHapticEnabled, true);
      expect(settings.shakeDirection, ShakeDirection.horizontal);
    });

    test('getSettings returns saved values', () {
      when(mockPrefs.getDouble('sensitivity')).thenReturn(80.0);
      when(mockPrefs.getBool('service_enabled')).thenReturn(false);
      when(mockPrefs.getBool('haptic_enabled')).thenReturn(false);
      when(mockPrefs.getString('shake_direction')).thenReturn('vertical');

      final settings = repository.getSettings();
      expect(settings.sensitivity, 80.0);
      expect(settings.isServiceEnabled, false);
      expect(settings.isHapticEnabled, false);
      expect(settings.shakeDirection, ShakeDirection.vertical);
    });

    test('saveSettings persists data', () async {
      const settings = AppSettings(
        sensitivity: 75.0,
        isServiceEnabled: true,
        isHapticEnabled: false,
        shakeDirection: ShakeDirection.vertical,
      );

      when(mockPrefs.setDouble(any, any)).thenAnswer((_) async => true);
      when(mockPrefs.setBool(any, any)).thenAnswer((_) async => true);
      when(mockPrefs.setString(any, any)).thenAnswer((_) async => true);

      await repository.saveSettings(settings);

      verify(mockPrefs.setDouble('sensitivity', 75.0)).called(1);
      verify(mockPrefs.setBool('service_enabled', true)).called(1);
      verify(mockPrefs.setBool('haptic_enabled', false)).called(1);
      verify(mockPrefs.setString('shake_direction', 'vertical')).called(1);
    });
  });
}
