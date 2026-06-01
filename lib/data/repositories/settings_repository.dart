import 'package:shared_preferences/shared_preferences.dart';
import '../models/app_settings.dart';

class SettingsRepository {
  SettingsRepository(this._prefs);
  static const String _keySensitivity = 'sensitivity';
  static const String _keyServiceEnabled = 'service_enabled';

  final SharedPreferences _prefs;

  AppSettings getSettings() {
    final sensitivity = _prefs.getDouble(_keySensitivity) ?? 50.0;
    final isServiceEnabled = _prefs.getBool(_keyServiceEnabled) ?? false;
    return AppSettings(
      sensitivity: sensitivity,
      isServiceEnabled: isServiceEnabled,
    );
  }

  Future<void> saveSettings(AppSettings settings) async {
    await _prefs.setDouble(_keySensitivity, settings.sensitivity);
    await _prefs.setBool(_keyServiceEnabled, settings.isServiceEnabled);
  }
}
