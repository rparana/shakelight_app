import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'core/theme.dart';
import 'presentation/providers/base_providers.dart';
import 'presentation/screens/home_screen.dart';
import 'services/background_service.dart';
import 'services/quick_settings_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();

  await BackgroundMonitoringService.initialize();

  final container = ProviderContainer(
    overrides: [
      sharedPreferencesProvider.overrideWithValue(prefs),
    ],
  );

  QuickSettingsService.setup(container);

  runApp(
    UncontrolledProviderScope(
      container: container,
      child: const ShakeLightApp(),
    ),
  );
}

class ShakeLightApp extends StatelessWidget {
  const ShakeLightApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ShakeLight',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      home: const HomeScreen(),
    );
  }
}
