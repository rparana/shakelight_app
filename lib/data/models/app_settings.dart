class AppSettings {
  const AppSettings({
    required this.sensitivity,
    required this.isServiceEnabled,
  });

  factory AppSettings.defaultSettings() {
    return const AppSettings(
      sensitivity: 50.0,
      isServiceEnabled: false,
    );
  }
  final double sensitivity;
  final bool isServiceEnabled;

  AppSettings copyWith({
    double? sensitivity,
    bool? isServiceEnabled,
  }) {
    return AppSettings(
      sensitivity: sensitivity ?? this.sensitivity,
      isServiceEnabled: isServiceEnabled ?? this.isServiceEnabled,
    );
  }

  @override
  String toString() => 'AppSettings(sensitivity: $sensitivity, isServiceEnabled: $isServiceEnabled)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is AppSettings &&
        other.sensitivity == sensitivity &&
        other.isServiceEnabled == isServiceEnabled;
  }

  @override
  int get hashCode => sensitivity.hashCode ^ isServiceEnabled.hashCode;
}
