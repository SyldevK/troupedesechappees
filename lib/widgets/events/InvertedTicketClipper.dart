import 'package:flutter/cupertino.dart';

class InvertedTicketClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    double radius = 20;

    Path path = Path();
    path.moveTo(radius, 0);

    // Top edge
    path.lineTo(size.width - radius, 0);
    path.arcToPoint(
      Offset(size.width, radius),
      radius: Radius.circular(radius),
      clockwise: false,
    );

    // Right edge
    path.lineTo(size.width, size.height - radius);
    path.arcToPoint(
      Offset(size.width - radius, size.height),
      radius: Radius.circular(radius),
      clockwise: false,
    );

    // Bottom edge
    path.lineTo(radius, size.height);
    path.arcToPoint(
      Offset(0, size.height - radius),
      radius: Radius.circular(radius),
      clockwise: false,
    );

    // Left edge
    path.lineTo(0, radius);
    path.arcToPoint(
      Offset(radius, 0),
      radius: Radius.circular(radius),
      clockwise: false,
    );

    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
