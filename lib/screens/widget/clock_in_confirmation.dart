import 'package:attendance_app/res/common_lib.dart';

class ClockInConfirmation extends StatelessWidget {
  const ClockInConfirmation({
    super.key,
    required this.onClick,
    required this.text,
  });

  final String text;
  final Function() onClick;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: ContinuousRectangleBorder(borderRadius: BorderRadius.circular(12)),
      backgroundColor: AppColors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(padding: EdgeInsets.all(style.insets.md), child: Text(text)),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                  style: const ButtonStyle(
                      foregroundColor: WidgetStatePropertyAll(AppColors.black)),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    'No',
                    style: style.text.title,
                  )),
              TextButton(
                  style: const ButtonStyle(
                      foregroundColor: WidgetStatePropertyAll(AppColors.blue)),
                  onPressed: () {
                    Navigator.pop(context);
                    onClick();
                  },
                  child: Text(
                    'Yes',
                    style: style.text.title,
                  ))
            ],
          )
        ],
      ),
    );
  }
}
