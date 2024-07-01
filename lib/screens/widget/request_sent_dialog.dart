import 'package:attendance_app/res/common_lib.dart';

class RequestSentDialog extends StatelessWidget {
  const RequestSentDialog({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: AppColors.white,
      alignment: Alignment.topCenter,
      shape: ContinuousRectangleBorder(
          borderRadius: BorderRadius.circular(style.radius.md)),
      insetPadding: EdgeInsets.symmetric(
          horizontal: style.insets.md, vertical: kToolbarHeight + 100),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: style.insets.xxl),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgIcon(
              name: 'fast-time',
              size: style.icon.xl,
            ),
            const Gap(25),
            Text(
              'Time Update Request Sent',
              style: style.text.h3,
            )
          ],
        ),
      ),
    );
  }
}
