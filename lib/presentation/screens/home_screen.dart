import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/permission_provider.dart';
import '../providers/flashlight_provider.dart';
import '../providers/shake_monitoring_provider.dart';
import '../widgets/status_icon.dart';
import '../widgets/toggle_button.dart';

import 'settings_screen.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(hasPermissionsProvider.notifier).requestAll();
    });
  }

  @override
  Widget build(BuildContext context) {
    final hasPermissions = ref.watch(hasPermissionsProvider);
    final flashlightState = ref.watch(flashlightProvider);
    
    // Watch monitoring provider to ensure it stays active
    ref.watch(shakeMonitoringProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('ShakeLight'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const SettingsScreen()),
              );
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            StatusIcon(isActive: flashlightState.isActive),
            const SizedBox(height: 60),
            ManualToggleButton(
              isActive: flashlightState.isActive,
              onPressed: () => ref.read(flashlightProvider.notifier).toggle(),
            ),
            const SizedBox(height: 40),
            if (!hasPermissions)
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  'Permissions required for full functionality. Please grant Camera and Motion permissions.',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.red),
                ),
              ),
            if (flashlightState.error != null)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Text(
                  flashlightState.error!,
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.orange),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
