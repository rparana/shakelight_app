import 'package:flutter/material.dart';

class ManualToggleButton extends StatelessWidget {
  final bool isActive;
  final VoidCallback onPressed;

  const ManualToggleButton({
    super.key,
    required this.isActive,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(200, 60),
        backgroundColor: isActive ? Colors.red.shade100 : Colors.amber.shade100,
        foregroundColor: isActive ? Colors.red : Colors.amber.shade900,
      ),
      child: Text(
        isActive ? 'Turn OFF' : 'Turn ON',
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
    );
  }
}
