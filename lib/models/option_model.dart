import 'package:attendance_app/res/common_lib.dart';

class OptionModel {
  final String icon;
  final List<Color> colors;
  final String text;
  final String? navigation;

  OptionModel(
      {required this.icon,
      required this.colors,
      required this.text,
      this.navigation});
}
