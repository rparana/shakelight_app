import 'package:flutter_test/flutter_test.dart';
import 'package:shakelight_app/data/repositories/settings_repository.dart';
import 'package:shakelight_app/data/models/app_settings.dart';
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

      final settings = repository.getSettings();
      expect(settings.sensitivity, 50.0);
      expect(settings.isServiceEnabled, false);
    });

    test('saveSettings persists data', () async {
      final settings = const AppSettings(sensitivity: 75.0, isServiceEnabled: true);
      
      when(mockPrefs.setDouble(any, any)).thenAnswer((_) async => true);
      when(mockPrefs.setBool(any, any)).thenAnswer((_) async => true);

      await repository.saveSettings(settings);

      verify(mockPrefs.setDouble('sensitivity', 75.0)).called(1);
      verify(mockPrefs.setBool('service_enabled', true)).called(1);
    });
  });
}
