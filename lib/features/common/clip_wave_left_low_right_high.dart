import 'package:flutter/material.dart';

class ClipWaveLeftLowRightHigh extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();

    path.lineTo(0, size.height - (size.height / 4));

    var firstControlPoint = Offset(size.width / 4, size.height / 4);
    var firstEndPoint = Offset(size.width / 2, size.height / 2);

    var secondControlPoint = Offset(size.width - (size.width / 4), size.height);
    var secondEndPoint = Offset(size.width, size.height / 2);

    path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy, firstEndPoint.dx, firstEndPoint.dy);

    path.quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy, secondEndPoint.dx, secondEndPoint.dy);

    path.lineTo(size.width, 0);

    path.close();

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}
