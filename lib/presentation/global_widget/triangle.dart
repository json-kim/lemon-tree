import 'package:flutter/material.dart';

class ReverseTriangle extends CustomPainter {
  Color color;
  double width;

  ReverseTriangle({required this.color, required this.width});
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = width
      ..style = PaintingStyle.fill;

    final path = Path();
    path.lineTo(size.width, 0);
    path.lineTo(size.width * 1 / 2, size.height);
    path.lineTo(0, 0);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
