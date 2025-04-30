import 'package:flutter/material.dart';

class DashedLinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final bluePaint = Paint()
      ..color = Colors.orange
      ..strokeWidth = 5
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final redPaint = Paint()
      ..color = Colors.orange
      ..strokeWidth = 5
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    double blueLength = size.width * 0.9;
    double gap = 10;
    double redStart = blueLength + gap;

    canvas.drawLine(Offset(0, 0), Offset(blueLength, 0), bluePaint);
    canvas.drawLine(Offset(redStart, 0), Offset(size.width, 0), redPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}