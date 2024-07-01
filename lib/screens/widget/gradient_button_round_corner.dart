import 'package:attendance_app/res/common_lib.dart';

class GradientButtonRoundCorner extends StatelessWidget {
  final String text;
  final Function() onClick;
  const GradientButtonRoundCorner({
    super.key,
    required this.text,
    required this.onClick,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      children: [
        Positioned.fill(
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 3),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              gradient: const LinearGradient(
                colors: [
                  AppColors.purpleGradient,
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
                padding: EdgeInsets.zero,
                visualDensity: VisualDensity.compact,
                foregroundColor: AppColors.white,
              ),
              onPressed: onClick,
              child: Text(
                text,
                style: style.text.bodyContent,
              )),
        )
      ],
    );
  }
}
