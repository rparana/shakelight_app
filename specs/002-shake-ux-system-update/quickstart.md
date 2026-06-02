# Quickstart

No special backend services are required. Ensure you have an Android or iOS device/emulator.

1. **Install dependencies:**
   ```bash
   flutter pub add vibration quick_settings
   flutter pub get
   ```

2. **Run the app:**
   ```bash
   flutter run
   ```

3. **Testing Quick Settings:**
   - On an Android emulator/device, pull down the notification shade, edit the Quick Settings, and add the ShakeLight tile.

4. **Testing Shake:**
   - Shaking the device (or simulating it via emulator virtual sensors) along the selected axis twice rapidly should trigger the flashlight and a vibration.
