import 'package:flutter/material.dart';

class TabModel {
  final String icon;
  final String activeIcon;
  final String label;
  final Widget page;
  TabModel(
      {required this.icon,
      required this.activeIcon,
      required this.label,
      required this.page});
}
