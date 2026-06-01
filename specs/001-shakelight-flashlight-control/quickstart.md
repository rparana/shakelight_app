# Quickstart: ShakeLight Flashlight Control

## Prerequisites

- Flutter SDK (latest stable)
- Physical Android or iOS device (Flashlight and Accelerometer do not work reliably on emulators)
- Git

## Setup

1. **Clone the repository**:
   ```bash
   git clone [repo-url]
   cd shakelight_app
   ```

2. **Install dependencies**:
   ```bash
   flutter pub get
   ```

3. **Configure Permissions**:
   - **Android**: Ensure `AndroidManifest.xml` includes `CAMERA`, `FOREGROUND_SERVICE`, and `POST_NOTIFICATIONS` (for Android 13+).
   - **iOS**: Ensure `Info.plist` includes `NSCameraUsageDescription`, `NSMotionUsageDescription`, and `UIBackgroundModes` (fetch/processing).

4. **Run the app**:
   ```bash
   flutter run
   ```

## Development

- **Run Tests**: `flutter test`
- **Linting**: `flutter analyze`
- **Background Service**: On Android, verify the persistent notification appears when "Enable Shake Detection" is on.
