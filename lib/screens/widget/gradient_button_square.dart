import 'package:attendance_app/res/common_lib.dart';

class GradientButtonSquare extends StatelessWidget {
  const GradientButtonSquare({
    required this.text,
    super.key,
    required this.onClick,
  });

  final String text;
  final Function() onClick;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(style.insets.sm),
              gradient: const LinearGradient(
                colors: [
                  Color(0xff7560d6),
                  AppColors.blueGradient,
                ],
              ),
            ),
          ),
        ),
        SizedBox(
          width: double.infinity,
          child: TextButton(
            style: TextButton.styleFrom(
              padding: EdgeInsets.symmetric(vertical: style.insets.md),
              shape: ContinuousRectangleBorder(
                  borderRadius: BorderRadius.circular(style.insets.sm)),
              foregroundColor: AppColors.white,
            ),
            onPressed: onClick,
            child: Text(
              text,
              style: style.text.bodyTitle,
            ),
          ),
        )
      ],
    );
  }
}
