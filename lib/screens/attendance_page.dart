import 'package:animations/animations.dart';
import 'package:attendance_app/controllers/attendance_controller.dart';
import 'package:attendance_app/models/attendance_model.dart';
import 'package:attendance_app/res/common_lib.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';

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
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) =>
        Provider.of<AttendanceController>(context, listen: false)
            .getMonthlyData());
    super.initState();
  }

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

              return PageTransitionSwitcher(
                child: attController.attendanceList.isEmpty
                    ? const EmptyAttendance()
                    : attController.isAnimate
                        ? listView
                        : listVie2,
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

class EmptyAttendance extends StatelessWidget {
  const EmptyAttendance({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Lottie.asset(
            'assets/lottie/empty.json',
            width: 200,
            height: 200,
            repeat: false,
          ),
          Text(
            'No data found',
            style: style.text.h3.copyWith(
              color: AppColors.grey,
            ),
          )
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
        openEditTime(context);
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
                      return Stack(
                        alignment: Alignment.center,
                        children: [
                          Container(
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
                                  DateFormat('dd').format(attendance.date!),
                                  style: style.text.h3,
                                ),
                                Text(
                                  DateFormat('EEE').format(attendance.date!),
                                  style: style.text.h5,
                                ),
                              ],
                            ),
                          ),
                          if (attendance.attendanceType == 0)
                            Positioned(
                              top: -4,
                              right: -4,
                              child: Container(
                                padding: const EdgeInsets.all(4),
                                color: AppColors.white,
                                child: const SvgIcon(
                                  name: 'home-fill',
                                  size: 10,
                                ),
                              ),
                            ),
                        ],
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
                      if (attendance.clockInTime != null)
                        Text(
                          DateFormat('hh:mm').format(attendance.clockInTime!),
                          style: style.text.titleMd.copyWith(
                              color: attendance.clockInTime == null
                                  ? AppColors.black
                                  : attendance.isClockInlate ?? false
                                      ? AppColors.red
                                      : AppColors.green),
                        )
                      else
                        Text(
                          '--:--',
                          style: style.text.titleMd,
                        ),
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
                      if (attendance.clockOutTime != null)
                        Text(
                          DateFormat('hh:mm').format(attendance.clockOutTime!),
                          textAlign: TextAlign.center,
                          style: style.text.titleMd.copyWith(
                            color: attendance.clockOutTime == null
                                ? AppColors.black
                                : attendance.isClockOutlate ?? false
                                    ? AppColors.red
                                    : AppColors.green,
                          ),
                        )
                      else
                        Text(
                          '--:--',
                          style: style.text.titleMd,
                        )
                    ],
                  ),
                ),
                Expanded(
                  child: Text(
                    attendance.workingHrsInMin == null
                        ? "--:--"
                        : "${attendance.workingHrsInMin! ~/ 60}h:${(attendance.workingHrsInMin! % 60)}m",
                    textAlign: TextAlign.center,
                    style: style.text.titleMd.copyWith(
                      color: attendance.workingHrsInMin == null
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

  Future openEditTime(BuildContext context) {
    return showGeneralDialog(
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
  }
}
