import 'package:shared_preferences/shared_preferences.dart';
import '../models/app_settings.dart';
import '../models/shake_direction.dart';

class SettingsRepository {
  SettingsRepository(this._prefs);
  static const String _keySensitivity = 'sensitivity';
  static const String _keyServiceEnabled = 'service_enabled';
  static const String _keyHapticEnabled = 'haptic_enabled';
  static const String _keyShakeDirection = 'shake_direction';

  final SharedPreferences _prefs;

  AppSettings getSettings() {
    final sensitivity = _prefs.getDouble(_keySensitivity) ?? 50.0;
    // Default isServiceEnabled to true as per specs
    final isServiceEnabled = _prefs.getBool(_keyServiceEnabled) ?? true;
    final isHapticEnabled = _prefs.getBool(_keyHapticEnabled) ?? true;
    final shakeDirectionName =
        _prefs.getString(_keyShakeDirection) ?? ShakeDirection.horizontal.name;

    final shakeDirection = ShakeDirection.values.firstWhere(
      (e) => e.name == shakeDirectionName,
      orElse: () => ShakeDirection.horizontal,
    );

    return AppSettings(
      sensitivity: sensitivity,
      isServiceEnabled: isServiceEnabled,
      isHapticEnabled: isHapticEnabled,
      shakeDirection: shakeDirection,
    );
  }

  Future<void> saveSettings(AppSettings settings) async {
    await _prefs.setDouble(_keySensitivity, settings.sensitivity);
    await _prefs.setBool(_keyServiceEnabled, settings.isServiceEnabled);
    await _prefs.setBool(_keyHapticEnabled, settings.isHapticEnabled);
    await _prefs.setString(_keyShakeDirection, settings.shakeDirection.name);
  }
}
