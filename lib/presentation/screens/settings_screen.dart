import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/settings_provider.dart';
import '../widgets/sensitivity_slider.dart';
import '../widgets/service_switch.dart';

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
