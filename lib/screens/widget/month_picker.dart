import 'package:attendance_app/controllers/attendance_controller.dart';
import 'package:attendance_app/res/common_lib.dart';
import 'package:attendance_app/screens/widget/year_month_picker.dart';
import 'package:popover/popover.dart';

class MonthPicker extends StatelessWidget {
  const MonthPicker({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        showPopover(
          direction: PopoverDirection.top,
          context: context,
          width: MediaQuery.sizeOf(context).width * 0.8,
          height: MediaQuery.sizeOf(context).width * 0.8,
          bodyBuilder: (context) => const YearMonthPicker(),
        );
      },
      child: Consumer<AttendanceController>(builder: (context, value, child) {
        return Align(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgIcon(
                name: 'calendar-outline',
                size: style.icon.xs,
              ),
              const Gap(10),
              Text(
                '${value.selectedMonth} ${value.selectedYear}',
                style: style.text.h4.copyWith(color: AppColors.blue),
              )
            ],
          ),
        );
      }),
    );
  }
}
