import 'package:flutter/cupertino.dart';

class TicketBorderPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Color(0xFF6C3A87)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    final radius = 20.0;
    final path = Path();

    path.moveTo(radius, 0);
    path.lineTo(size.width - radius, 0);
    path.arcToPoint(Offset(size.width, radius),
        radius: Radius.circular(radius), clockwise: false);
    path.lineTo(size.width, size.height - radius);
    path.arcToPoint(Offset(size.width - radius, size.height),
        radius: Radius.circular(radius), clockwise: false);
    path.lineTo(radius, size.height);
    path.arcToPoint(Offset(0, size.height - radius),
        radius: Radius.circular(radius), clockwise: false);
    path.lineTo(0, radius);
    path.arcToPoint(Offset(radius, 0),
        radius: Radius.circular(radius), clockwise: false);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
