import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DashedRectPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = const Color(0xffD5D8E2)
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke;

    double dashWidth = 5.w;
    double dashSpace = 5.w;

    // Top border
    double startX = 0;
    while (startX < size.width) {
      canvas.drawLine(Offset(startX, 0), Offset(startX + dashWidth, 0), paint);
      startX += dashWidth + dashSpace;
    }

    // Right border
    double startY = 0;
    while (startY < size.height) {
      canvas.drawLine(Offset(size.width, startY), Offset(size.width, startY + dashWidth), paint);
      startY += dashWidth + dashSpace;
    }

    // Bottom border
    startX = size.width;
    while (startX > 0) {
      canvas.drawLine(Offset(startX, size.height), Offset(startX - dashWidth, size.height), paint);
      startX -= dashWidth + dashSpace;
    }

    // Left border
    startY = size.height;
    while (startY > 0) {
      canvas.drawLine(Offset(0, startY), Offset(0, startY - dashWidth), paint);
      startY -= dashWidth + dashSpace;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
