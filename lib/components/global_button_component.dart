import 'package:flutter/material.dart';
import 'package:parallel_farm/constants/constants.dart';



class GlobalButton extends StatelessWidget {
  final VoidCallback onPressed;
  final Widget child;
  final Color color;
  final double borderRadius;
  final double width;
  final double height;

  const GlobalButton(
      {super.key,
      required this.onPressed,
      this.height = 50,
      this.width = 150,
      required this.child,
      this.color = accentColor,
      this.borderRadius = 15});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      minWidth: width,
      height: height,
      color: color,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      onPressed: onPressed,
      child: child,
    );
  }
}
