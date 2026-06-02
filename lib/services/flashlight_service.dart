import 'package:torch_light/torch_light.dart';
import 'package:vibration/vibration.dart';

abstract class FlashlightService {
  Future<bool> isFlashlightAvailable();
  Future<void> turnOn({bool withHaptic = false});
  Future<void> turnOff({bool withHaptic = false});
  Future<void> toggle(bool state, {bool withHaptic = false});
}

class FlashlightServiceImpl implements FlashlightService {
  @override
  Future<bool> isFlashlightAvailable() async {
    try {
      return await TorchLight.isTorchAvailable();
    } catch (_) {
      return false;
    }
  }

  @override
  Future<void> turnOn({bool withHaptic = false}) async {
    await TorchLight.enableTorch();
    if (withHaptic) {
      _vibrate();
    }
  }

  @override
  Future<void> turnOff({bool withHaptic = false}) async {
    await TorchLight.disableTorch();
    if (withHaptic) {
      _vibrate();
    }
  }

  @override
  Future<void> toggle(bool state, {bool withHaptic = false}) async {
    if (state) {
      await turnOn(withHaptic: withHaptic);
    } else {
      await turnOff(withHaptic: withHaptic);
    }
  }

  Future<void> _vibrate() async {
    if (await Vibration.hasVibrator() ?? false) {
      Vibration.vibrate(duration: 50);
    }
  }
}
