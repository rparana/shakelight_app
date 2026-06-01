import 'package:flutter/material.dart';

class StatusIcon extends StatelessWidget {
  final bool isActive;

  const StatusIcon({
    super.key,
    required this.isActive,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
      width: 200,
      height: 200,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isActive 
          ? Colors.amber.withOpacity(0.2) 
          : Colors.grey.withOpacity(0.1),
        boxShadow: isActive ? [
          BoxShadow(
            color: Colors.amber.withOpacity(0.5),
            blurRadius: 30,
            spreadRadius: 10,
          )
        ] : [],
      ),
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        child: Icon(
          isActive ? Icons.flashlight_on : Icons.flashlight_off,
          key: ValueKey(isActive),
          size: 100,
          color: isActive ? Colors.amber : Colors.grey,
        ),
      ),
    );
  }
}
