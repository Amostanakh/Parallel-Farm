// import 'package:flutter/material.dart';

// class ChevronLinearProgressIndicator extends LinearProgressIndicator {
//   final Color color1;
//   final Color color2;

//   const ChevronLinearProgressIndicator({
//     Key? key,
//     required double value,
//     Color valueColor = Colors.white,
//     Color backgroundColor = const Color(0xFFD7D7D7),
//     double minWidth = 48.0,
//     double maxWidth = 400.0,
//     double height = 10.0,
//     SemanticProgressIndicatorSemantics semantics = SemanticsProgressIndicatorSemantics(),
//     this.color1 = const Color(0xFF2196F3),
//     this.color2 = const Color(0xFF4CAF50),
//   }) : super(
//       key: key,
//       value: value,
//       valueColor: valueColor,
//       backgroundColor: backgroundColor,
//       minWidth: minWidth,
//       maxWidth: maxWidth,
//       height: height,
//       semantics: semantics,
//     );

//   @override
//   Widget build(BuildContext context) {
//     return DecoratedBox(
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(height / 2),
//         backgroundGradient: LinearGradient(
//           colors: [backgroundColor, backgroundColor],
//         ),
//       ),
//       child: Stack(
//         children: [
//           Container(
//             width: _indicatorWidth,
//             height: height,
//             child: CustomPaint(
//               painter: _CustomProgressPainter(
//                 _createChevronPaint(color1, color2),
//                 value,
//                 valueColor,
//               ),
//             ),
//           ),
//           // ... other progress indicator elements (optional)
//         ],
//       ),
//     );
//   }
// }

// class _CustomProgressPainter extends CustomPainter {
//   final Paint paint;
//   final double value;
//   final Color valueColor;

//   const _CustomProgressPainter(this.paint, this.value, this.valueColor);

//   @override
//   void paint(Canvas canvas, Size size) {
//     final width = size.width * value;
//     canvas.drawRect(Offset(0.0, 0.0), Size(width, size.height), paint);
//     // ... (optional) paint value indicator or other elements
//   }

//   @override
//   bool shouldRepaint(_CustomProgressPainter oldDelegate) =>
//       value != oldDelegate.value || paint != oldDelegate.paint;
// }
