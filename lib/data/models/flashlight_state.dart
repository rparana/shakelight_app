class FlashlightState {
  const FlashlightState({
    required this.isActive,
    this.error,
  });

  factory FlashlightState.initial() {
    return const FlashlightState(isActive: false);
  }
  final bool isActive;
  final String? error;

  FlashlightState copyWith({
    bool? isActive,
    String? error,
  }) {
    return FlashlightState(
      isActive: isActive ?? this.isActive,
      error: error,
    );
  }

  @override
  String toString() => 'FlashlightState(isActive: $isActive, error: $error)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is FlashlightState &&
        other.isActive == isActive &&
        other.error == error;
  }

  @override
  int get hashCode => isActive.hashCode ^ error.hashCode;
}
