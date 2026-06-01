import 'package:flutter/material.dart';

class ServiceSwitch extends StatelessWidget {
  final bool value;
  final ValueChanged<bool> onChanged;

  const ServiceSwitch({
    super.key,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return SwitchListTile(
      title: const Text(
        'Enable Shake Detection',
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
      subtitle: const Text('Toggles flashlight when phone is shaken'),
      value: value,
      onChanged: onChanged,
    );
  }
}
