// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SvgIcon extends StatelessWidget {
  final String name;
  final double? size;
  final Color? color;
  const SvgIcon({super.key, required this.name, this.size, this.color});

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      'assets/icons/$name.svg',
      width: size ?? 20,
      height: size ?? 20,
      color: color,
    );
  }
}
