import 'package:flutter/material.dart';

class FloatingActionButtonExtended extends StatelessWidget {
  const FloatingActionButtonExtended({
    super.key,
    required this.onPressed,
    required this.label,
    this.labelColor,
    this.backgroundColor,
  });

  final VoidCallback onPressed;
  final String label;
  final Color? labelColor;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      backgroundColor: backgroundColor,
      onPressed: onPressed,
      label: Text(
        label,
        style: TextStyle(
          fontWeight: FontWeight.w600,
          color: labelColor,
        ),
      ),
    );
  }
}
