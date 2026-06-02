import 'package:quick_settings/quick_settings.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../presentation/providers/settings_provider.dart';

class QuickSettingsService {
  static void setup(ProviderContainer container) {
    QuickSettings.setup(
      onTileClicked: (tile) async {
        final notifier = container.read(settingsProvider.notifier);
        final currentSettings = container.read(settingsProvider);

        final newState = !currentSettings.isServiceEnabled;
        await notifier.toggleService(newState);

        tile.update(
          state: newState ? TileState.active : TileState.inactive,
          label: newState ? "Shake ON" : "Shake OFF",
        );
      },
      onTileAdded: (tile) {
        final settings = container.read(settingsProvider);
        tile.update(
          state: settings.isServiceEnabled
              ? TileState.active
              : TileState.inactive,
          label: settings.isServiceEnabled ? "Shake ON" : "Shake OFF",
        );
      },
    );
  }

  /// Updates the tile state based on the current app settings.
  /// This can be called when settings change within the app.
  static void updateTile(bool isServiceEnabled) {
    QuickSettings.updateTile(
      state: isServiceEnabled ? TileState.active : TileState.inactive,
      label: isServiceEnabled ? "Shake ON" : "Shake OFF",
    );
  }
}
