import 'package:attendance_app/res/common_lib.dart';

class ColoredButton extends StatelessWidget {
  const ColoredButton({
    super.key,
    required this.text,
    required this.onClick,
    required this.color,
  });

  final Color color;
  final String text;
  final Function() onClick;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
          padding: WidgetStatePropertyAll(EdgeInsets.symmetric(
              vertical: style.insets.lg, horizontal: style.insets.lg)),
          backgroundColor: WidgetStatePropertyAll(color),
          shape: WidgetStatePropertyAll(ContinuousRectangleBorder(
              borderRadius: BorderRadius.circular(style.radius.xs)))),
      onPressed: onClick,
      child: Text(
        text,
        style: style.text.bodyContentSmall.copyWith(color: AppColors.white),
      ),
    );
  }
}
