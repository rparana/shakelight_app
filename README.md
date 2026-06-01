# ShakeLight

A Flutter utility app that allows users to toggle the device flashlight by shaking the phone.

## Features

- **Shake to Toggle**: Control your flashlight with a simple shake gesture.
- **Background Monitoring**: Works even when the app is minimized or the screen is locked.
- **Adjustable Sensitivity**: Customize the G-force threshold to suit your needs.
- **Manual Control**: Primary button for direct flashlight toggling.
- **Material Design 3**: Modern, clean, and adaptive UI.
- **Native Integration**: Rigorous handling of permissions and hardware states.

## Technical Details

- **Framework**: Flutter (Dart)
- **State Management**: Riverpod
- **Architecture**: Modular Clean Architecture Lite
- **Local Storage**: SharedPreferences
- **Native Plugins**:
  - `torch_light`: Flashlight control
  - `sensors_plus`: Accelerometer data
  - `flutter_background_service`: Persistent background execution
  - `permission_handler`: System permissions

## Development

### Prerequisites

- Flutter SDK (latest stable)
- Physical Android or iOS device (Flashlight and Accelerometer do not work reliably on emulators)

### Setup

1.  Clone the repository.
2.  Run `flutter pub get`.
3.  Run `flutter run`.

### Testing

Run unit and widget tests:
```bash
flutter test
```

Maintain a minimum test coverage of 95%.

## License

MIT
