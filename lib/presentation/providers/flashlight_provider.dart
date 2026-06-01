import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/models/flashlight_state.dart';
import '../../services/flashlight_service.dart';
import '../../core/error_handler.dart';

final flashlightServiceProvider = Provider<FlashlightService>((ref) {
  return FlashlightServiceImpl();
});

final flashlightProvider = NotifierProvider<FlashlightNotifier, FlashlightState>(() {
  return FlashlightNotifier();
});

class FlashlightNotifier extends Notifier<FlashlightState> {
  @override
  FlashlightState build() {
    return FlashlightState.initial();
  }

  Future<void> toggle() async {
    final service = ref.read(flashlightServiceProvider);
    final newState = !state.isActive;
    
    try {
      await service.toggle(newState);
      state = state.copyWith(isActive: newState, error: null);
    } catch (e) {
      state = state.copyWith(error: AppErrorHandler.getMessage(e));
    }
  }

  Future<void> turnOff() async {
    if (!state.isActive) return;
    
    final service = ref.read(flashlightServiceProvider);
    try {
      await service.turnOff();
      state = state.copyWith(isActive: false, error: null);
    } catch (e) {
      state = state.copyWith(error: AppErrorHandler.getMessage(e));
    }
  }
}
