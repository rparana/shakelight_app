import 'package:torch_light/torch_light.dart';

abstract class FlashlightService {
  Future<bool> isFlashlightAvailable();
  Future<void> turnOn();
  Future<void> turnOff();
  Future<void> toggle(bool state);
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
  Future<void> turnOn() async {
    await TorchLight.enableTorch();
  }

  @override
  Future<void> turnOff() async {
    await TorchLight.disableTorch();
  }

  @override
  Future<void> toggle(bool state) async {
    if (state) {
      await turnOn();
    } else {
      await turnOff();
    }
  }
}
