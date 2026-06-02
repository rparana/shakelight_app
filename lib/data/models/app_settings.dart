import 'shake_direction.dart';

class AppSettings {
  const AppSettings({
    required this.sensitivity,
    required this.isServiceEnabled,
    required this.isHapticEnabled,
    required this.shakeDirection,
  });

  factory AppSettings.defaultSettings() {
    return const AppSettings(
      sensitivity: 50.0,
      isServiceEnabled: true,
      isHapticEnabled: true,
      shakeDirection: ShakeDirection.horizontal,
    );
  }

  final double sensitivity;
  final bool isServiceEnabled;
  final bool isHapticEnabled;
  final ShakeDirection shakeDirection;

  AppSettings copyWith({
    double? sensitivity,
    bool? isServiceEnabled,
    bool? isHapticEnabled,
    ShakeDirection? shakeDirection,
  }) {
    return AppSettings(
      sensitivity: sensitivity ?? this.sensitivity,
      isServiceEnabled: isServiceEnabled ?? this.isServiceEnabled,
      isHapticEnabled: isHapticEnabled ?? this.isHapticEnabled,
      shakeDirection: shakeDirection ?? this.shakeDirection,
    );
  }

  @override
  String toString() =>
      'AppSettings(sensitivity: $sensitivity, isServiceEnabled: $isServiceEnabled, isHapticEnabled: $isHapticEnabled, shakeDirection: $shakeDirection)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is AppSettings &&
        other.sensitivity == sensitivity &&
        other.isServiceEnabled == isServiceEnabled &&
        other.isHapticEnabled == isHapticEnabled &&
        other.shakeDirection == shakeDirection;
  }

  @override
  int get hashCode =>
      sensitivity.hashCode ^
      isServiceEnabled.hashCode ^
      isHapticEnabled.hashCode ^
      shakeDirection.hashCode;
}
