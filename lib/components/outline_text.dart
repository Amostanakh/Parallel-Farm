import 'package:flutter/material.dart';
import 'package:parallel_farm/constants/constants.dart';

class OutlineText extends StatelessWidget {
  const OutlineText({required this.text,required this.color,
    super.key});
  final String text;
  final bool color;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        // Stroked text as border.
        Text(
          '$text',
          style: TextStyle(
            fontSize: 18,
            foreground: Paint()
              ..style = PaintingStyle.stroke
              ..strokeWidth = 1.7
              ..color = Colors.white.withOpacity(0.7),
          ),
        ),
        // Solid text as fill.
        Text(
          '$text',
          style: TextStyle(
            fontSize: 18,
            color:color?tetiaryColor: primaryColor,
          ),
        ),
      ],
    );
  }
}
