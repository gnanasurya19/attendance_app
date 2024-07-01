import 'package:animations/animations.dart';
import 'package:attendance_app/controllers/attendance_controller.dart';
import 'package:attendance_app/models/attendance_model.dart';
import 'package:attendance_app/res/common_lib.dart';

import 'widget/edit_time_dialog.dart';
import 'widget/month_picker.dart';
import 'widget/request_sent_dialog.dart';

class AttendancePage extends StatefulWidget {
  const AttendancePage({super.key});

  @override
  State<AttendancePage> createState() => _AttendancePageState();
}

class _AttendancePageState extends State<AttendancePage>
    with SingleTickerProviderStateMixin {
  final GlobalKey<AnimatedListState> listKey = GlobalKey<AnimatedListState>();

  @override
  void initState() {
    super.initState();
    // populateList();
  }

  // void populateList() {
  //   Future.delayed(const Duration(milliseconds: 500), () {
  //     for (int i = 0; i < attendanceList.length; i++) {
  //       Future.delayed(Duration(milliseconds: i * 100), () {
  //         animationList.add(attendanceList[i]);
  //         listKey.currentState?.insertItem(animationList.length - 1);
  //       });
  //     }
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          // appbar
          Container(
            height: kToolbarHeight,
            alignment: Alignment.center,
            child: Text(
              'Attendance',
              style: style.text.h2,
            ),
          ),
          //year month picker
          Container(
            padding: EdgeInsets.symmetric(vertical: style.insets.xs),
            decoration: const BoxDecoration(
              color: AppColors.white,
              border: Border.symmetric(
                horizontal: BorderSide(color: AppColors.shadow),
              ),
            ),
            child: Row(
              children: [
                IconButton(
                  onPressed: () {
                    context.read<AttendanceController>().decreaseMonth();
                  },
                  icon: Icon(
                    Icons.arrow_back_ios_new_rounded,
                    color: AppColors.grey,
                    size: style.icon.xs,
                  ),
                ),
                const Expanded(
                  child: MonthPicker(),
                ),
                IconButton(
                  onPressed: () async {
                    context.read<AttendanceController>().increaseMonth();
                  },
                  icon: Icon(
                    Icons.arrow_forward_ios_rounded,
                    color: AppColors.grey,
                    size: style.icon.xs,
                  ),
                )
              ],
            ),
          ),
          // table header
          Container(
            padding: const EdgeInsets.symmetric(vertical: 10),
            color: AppColors.greybg,
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    'Date',
                    textAlign: TextAlign.center,
                    style: style.text.title,
                  ),
                ),
                Expanded(
                  child: Text(
                    'Clock In',
                    textAlign: TextAlign.center,
                    style: style.text.title,
                  ),
                ),
                Expanded(
                  child: Text(
                    'Clock Out',
                    textAlign: TextAlign.center,
                    style: style.text.title,
                  ),
                ),
                Expanded(
                  child: Text(
                    "Working Hr's",
                    textAlign: TextAlign.center,
                    style: style.text.title,
                  ),
                ),
              ],
            ),
          ),
          //table content
          Expanded(
            child: Consumer<AttendanceController>(
                builder: (context, attController, child) {
              var listView = ListView.builder(
                key: listKey,
                itemCount: attController.attendanceList.length,
                itemBuilder: (context, index) {
                  if (attController.attendanceList[index].attendanceType == 0) {
                    return Container(
                      margin: EdgeInsets.all(style.insets.md),
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      alignment: Alignment.center,
                      color: const Color(0xfffcfcf1),
                      child: Text(
                        'Weekend : 09 Sunday & Saturday',
                        style: style.text.bodyContent,
                      ),
                    );
                  } else {
                    return AttendanceDetail(
                      attendance: attController.attendanceList[index],
                    );
                  }
                },
              );
              var listVie2 = ListView.builder(
                itemCount: attController.attendanceList1.length,
                itemBuilder: (context, index) {
                  if (attController.attendanceList1[index].attendanceType ==
                      0) {
                    return Container(
                      margin: EdgeInsets.all(style.insets.md),
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      alignment: Alignment.center,
                      color: const Color(0xfffcfcf1),
                      child: Text(
                        'Weekend : 09 Sunday & Saturday',
                        style: style.text.bodyContent,
                      ),
                    );
                  } else {
                    return AttendanceDetail(
                      attendance: attController.attendanceList1[index],
                    );
                  }
                },
              );
              return PageTransitionSwitcher(
                child: attController.isAnimate ? listView : listVie2,
                transitionBuilder:
                    (child, primaryAnimation, secondaryAnimation) =>
                        FadeThroughTransition(
                  fillColor: Colors.transparent,
                  animation: primaryAnimation,
                  secondaryAnimation: secondaryAnimation,
                  child: child,
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}

class AttendanceDetail extends StatelessWidget {
  const AttendanceDetail({
    super.key,
    required this.attendance,
  });

  final AttendanceModel attendance;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        showGeneralDialog(
            context: context,
            pageBuilder: (BuildContext context, animation, secondaryAnimation) {
              final Animation<Offset> offsetAnimation =
                  Tween(begin: const Offset(0, 1), end: const Offset(0, 0))
                      .animate(animation);
              return SlideTransition(
                position: offsetAnimation,
                child: EditTimeDialog(
                  onClick: () {
                    Navigator.pop(context);
                    showDialog(
                        context: context,
                        builder: (context) => const RequestSentDialog());
                  },
                ),
              );
            });
      },
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.symmetric(vertical: style.insets.md),
            child: Row(
              children: [
                Expanded(
                  child: Align(
                    child: LayoutBuilder(builder: (context, constraints) {
                      return Container(
                        width: constraints.maxWidth * 0.6,
                        height: constraints.maxWidth * 0.6,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: AppColors.white,
                          border: Border.all(
                            color: AppColors.shadow,
                          ),
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              attendance.date!.substring(0, 2),
                              style: style.text.h3,
                            ),
                            Text(
                              attendance.date!.substring(2),
                              style: style.text.h5,
                            ),
                          ],
                        ),
                      );
                    }),
                  ),
                ),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (attendance.clockInTime != null &&
                          !(attendance.isClockInlate ?? false))
                        Transform.rotate(
                          angle: 3.14 * 0.5,
                          child: SvgIcon(
                            name: 'arrow-right-up',
                            size: style.icon.xs,
                          ),
                        ),
                      if (attendance.isClockInlate ?? false) ...[
                        SvgIcon(
                          name: 'alert',
                          size: style.icon.xxs,
                        ),
                        const Gap(2)
                      ],
                      Text(attendance.clockInTime ?? '--:--',
                          style: style.text.titleMd.copyWith(
                              color: attendance.clockInTime == null
                                  ? AppColors.black
                                  : attendance.isClockInlate ?? false
                                      ? AppColors.red
                                      : AppColors.green)),
                    ],
                  ),
                ),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (attendance.clockOutTime != null &&
                          !(attendance.isClockOutlate ?? false))
                        SvgIcon(
                          name: 'arrow-right-up',
                          size: style.icon.xs,
                        ),
                      if (attendance.isClockOutlate ?? false) ...[
                        SvgIcon(
                          name: 'alert',
                          size: style.icon.xxs,
                        ),
                        const Gap(2)
                      ],
                      Text(
                        attendance.clockOutTime ?? '--:--',
                        textAlign: TextAlign.center,
                        style: style.text.titleMd.copyWith(
                          color: attendance.clockOutTime == null
                              ? AppColors.black
                              : attendance.isClockOutlate ?? false
                                  ? AppColors.red
                                  : AppColors.green,
                        ),
                      )
                    ],
                  ),
                ),
                Expanded(
                  child: Text(
                    attendance.workingHrsIn ?? "--:--",
                    textAlign: TextAlign.center,
                    style: style.text.titleMd.copyWith(
                      color: attendance.workingHrsIn == null
                          ? AppColors.black
                          : attendance.isworkHrsLess ?? false
                              ? AppColors.red
                              : AppColors.green,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
