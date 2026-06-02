import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/settings_provider.dart';
import '../widgets/sensitivity_slider.dart';
import '../widgets/service_switch.dart';
import '../../data/models/shake_direction.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(settingsProvider);
    final notifier = ref.read(settingsProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          ServiceSwitch(
            value: settings.isServiceEnabled,
            onChanged: (value) => notifier.toggleService(value),
          ),
          const SizedBox(height: 20),
          SwitchListTile(
            title: const Text('Haptic Feedback'),
            value: settings.isHapticEnabled,
            onChanged: (value) => notifier.toggleHaptic(value),
          ),
          const SizedBox(height: 20),
          ListTile(
            title: const Text('Shake Direction'),
            trailing: DropdownButton<ShakeDirection>(
              value: settings.shakeDirection,
              onChanged: (value) {
                if (value != null) {
                  notifier.updateShakeDirection(value);
                }
              },
              items: ShakeDirection.values.map((direction) {
                return DropdownMenuItem(
                  value: direction,
                  child: Text(direction.name[0].toUpperCase() +
                      direction.name.substring(1)),
                );
              }).toList(),
            ),
          ),
          const SizedBox(height: 40),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: SensitivitySlider(
              value: settings.sensitivity,
              onChanged: (value) => notifier.updateSensitivity(value),
            ),
          ),
        ],
      ),
    );
  }
}
