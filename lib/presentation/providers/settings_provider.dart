import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/models/app_settings.dart';
import 'base_providers.dart';

final settingsProvider = NotifierProvider<SettingsNotifier, AppSettings>(() {
  return SettingsNotifier();
});

class SettingsNotifier extends Notifier<AppSettings> {
  @override
  AppSettings build() {
    final repository = ref.read(settingsRepositoryProvider);
    return repository.getSettings();
  }

  Future<void> updateSensitivity(double value) async {
    final newState = state.copyWith(sensitivity: value);
    state = newState;
    await ref.read(settingsRepositoryProvider).saveSettings(newState);
  }

  Future<void> toggleService(bool value) async {
    final newState = state.copyWith(isServiceEnabled: value);
    state = newState;
    await ref.read(settingsRepositoryProvider).saveSettings(newState);
  }
}
