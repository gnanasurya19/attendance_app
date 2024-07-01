import 'package:attendance_app/res/common_lib.dart';

class HeaderClipper extends CustomClipper<Path> {
  @override
  getClip(Size size) {
    final path = Path();
    double w = size.width;
    double h = size.height;
    path.lineTo(0, h);
    int curvesCount = (size.width ~/ 12) % 2 == 0
        ? (size.width ~/ 12)
        : (size.width ~/ 12) + 1;
    double w1 = w / curvesCount;

    for (var i = 1; i < curvesCount; i++) {
      if (i % 2 != 0) {
        path.lineTo(w1 * i, h - 5);
      } else {
        path.lineTo(w1 * i, h);
      }
    }

    path.lineTo(w, h);
    path.lineTo(w, 0);
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper oldClipper) {
    return false;
  }
}
