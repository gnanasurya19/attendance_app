import 'dart:math';
import 'package:attendance_app/res/common_lib.dart';
import 'package:attendance_app/screens/widget/circular_chat.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class TeamReportsPage extends StatefulWidget {
  const TeamReportsPage({super.key});

  @override
  State<TeamReportsPage> createState() => _TeamReportsPageState();
}

class _TeamReportsPageState extends State<TeamReportsPage>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
  }

  final List<WorkingHrsModel> workingHrs = [
    WorkingHrsModel(
      clockInTime: '08:00am',
      clockOutTime: '06:20',
      workingTimeInMin: 280,
      profile:
          'https://images.unsplash.com/photo-1560250097-0b93528c311a?q=80&w=1374&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
    ),
    WorkingHrsModel(
      clockInTime: '09:00am',
      clockOutTime: '06:05',
      workingTimeInMin: 355,
      profile:
          'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?q=80&w=1374&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
    ),
    WorkingHrsModel(
        clockInTime: '09:00am',
        clockOutTime: '06:05',
        workingTimeInMin: 200,
        profile:
            'https://images.unsplash.com/photo-1531891437562-4301cf35b7e4?q=80&w=1528&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D'),
    WorkingHrsModel(
        clockInTime: '09:00am',
        clockOutTime: '06:05',
        workingTimeInMin: 400,
        profile:
            'https://images.unsplash.com/photo-1531891437562-4301cf35b7e4?q=80&w=1528&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D'),
    WorkingHrsModel(
        clockInTime: '09:00am',
        clockOutTime: '06:05',
        workingTimeInMin: 320,
        profile:
            'https://images.unsplash.com/photo-1587723958656-ee042cc565a1?q=80&w=1374&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D'),
  ];

  final List<AttendanceChartModel> attendanceChartDetail = [
    AttendanceChartModel(1, 8.45),
    AttendanceChartModel(2, 8.51),
    AttendanceChartModel(3, 8.39),
    AttendanceChartModel(6, 9),
    AttendanceChartModel(7, 8.51),
    AttendanceChartModel(8, 8.58),
    AttendanceChartModel(9, 8.55),
    AttendanceChartModel(10, 9),
    AttendanceChartModel(13, 8.57),
    AttendanceChartModel(14, 8.49),
    AttendanceChartModel(15, 8.52),
    AttendanceChartModel(16, 9.01),
    AttendanceChartModel(17, 9),
    AttendanceChartModel(20, 9.04),
    AttendanceChartModel(21, 8.40),
    AttendanceChartModel(22, 8.59),
    AttendanceChartModel(23, 8.45),
    AttendanceChartModel(24, 8.52),
    AttendanceChartModel(27, 8.43),
    AttendanceChartModel(28, 8.50),
    AttendanceChartModel(29, 8.56),
    AttendanceChartModel(30, 8.56),
    AttendanceChartModel(31, 8.54),
  ];

  final List<AttendanceChartModel> attendanceChartDetail1 = [
    AttendanceChartModel(1, 18.07),
    AttendanceChartModel(2, 18.12),
    AttendanceChartModel(3, 18.10),
    AttendanceChartModel(6, 18.18),
    AttendanceChartModel(7, 18.10),
    AttendanceChartModel(8, 18.06),
    AttendanceChartModel(9, 18.07),
    AttendanceChartModel(10, 18.04),
    AttendanceChartModel(13, 18.05),
    AttendanceChartModel(14, 18.03),
    AttendanceChartModel(15, 18.12),
    AttendanceChartModel(16, 18.12),
    AttendanceChartModel(17, 18.06),
    AttendanceChartModel(20, 18.09),
    AttendanceChartModel(21, 18.07),
    AttendanceChartModel(22, 18.04),
    AttendanceChartModel(23, 18.11),
    AttendanceChartModel(24, 18.06),
    AttendanceChartModel(27, 18.07),
    AttendanceChartModel(28, 18.13),
    AttendanceChartModel(29, 18.09),
    AttendanceChartModel(30, 18.07),
    AttendanceChartModel(31, 18.01),
  ];

  final List<AttendanceCircleChatModel> attStatus = [
    AttendanceCircleChatModel('present', 20, AppColors.blue),
    AttendanceCircleChatModel('leave', 5, AppColors.orange),
    AttendanceCircleChatModel('wfh', 3, AppColors.red),
  ];

  final List<AttendanceCircleChatModel> leaveStatus = [
    AttendanceCircleChatModel('leave', 10, AppColors.blue),
    AttendanceCircleChatModel('total', 24, AppColors.blurbg),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage(
                'assets/images/home_bg.png',
              ),
              fit: BoxFit.cover),
        ),
        constraints: const BoxConstraints.expand(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppBar(
              scrolledUnderElevation: 0,
              backgroundColor: Colors.transparent,
              shadowColor: Colors.transparent,
              elevation: 0,
              leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(
                  Icons.arrow_back_ios_new_rounded,
                  size: style.icon.sm,
                ),
              ),
              centerTitle: true,
              title: Text(
                'Team Reports',
                style: style.text.h2,
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const Gap(50),
                    Container(
                      decoration: BoxDecoration(
                          color: AppColors.white,
                          border: Border.all(
                              color: AppColors.lightGrey, width: 1.5),
                          borderRadius: BorderRadius.circular(style.radius.xl)),
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.all(style.insets.lg),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Avg. Team Punctuality',
                                  style: style.text.h3,
                                ),
                                IconButton(
                                    style: const ButtonStyle(
                                        padding: WidgetStatePropertyAll(
                                          EdgeInsets.zero,
                                        ),
                                        side: WidgetStatePropertyAll(BorderSide(
                                            color: AppColors.lightGrey)),
                                        shape: WidgetStatePropertyAll(
                                            CircleBorder(eccentricity: 0))),
                                    onPressed: () {},
                                    iconSize: style.icon.xs,
                                    icon: const Icon(
                                      Icons.file_download_outlined,
                                      color: AppColors.lightGrey,
                                    ))
                              ],
                            ),
                          ),
                          //line chart
                          SizedBox(
                            height: 200,
                            child: SfCartesianChart(
                              trackballBehavior: TrackballBehavior(
                                markerSettings: const TrackballMarkerSettings(
                                  color: AppColors.blue,
                                  markerVisibility:
                                      TrackballVisibilityMode.visible,
                                ),
                                enable: true,
                                activationMode: ActivationMode.singleTap,
                                tooltipSettings: const InteractiveTooltip(),
                                tooltipDisplayMode:
                                    TrackballDisplayMode.floatAllPoints,
                              ),
                              series: <LineSeries<AttendanceChartModel, num>>[
                                LineSeries(
                                  pointColorMapper: (datum, index) =>
                                      datum.date! >= 8.55
                                          ? Colors.orange
                                          : Colors.blue,
                                  // color: AppColors.purpleGradient,
                                  markerSettings: const MarkerSettings(
                                      isVisible: true,
                                      color: AppColors.blue,
                                      height: 5,
                                      width: 5,
                                      borderWidth: 0),
                                  dataSource: attendanceChartDetail,
                                  xValueMapper: (datum, index) => datum.time,
                                  yValueMapper: (datum, index) => datum.date,
                                ),
                                LineSeries(
                                  // color: AppColors.purpleGradient,
                                  pointColorMapper: (datum, index) =>
                                      datum.date! <= 18.03
                                          ? Colors.orange
                                          : Colors.blue,
                                  markerSettings: const MarkerSettings(
                                    isVisible: true,
                                    color: AppColors.blue,
                                    borderWidth: 0,
                                    height: 5,
                                    width: 5,
                                  ),
                                  dataSource: attendanceChartDetail1,
                                  xValueMapper: (datum, index) => datum.time,
                                  yValueMapper: (datum, index) => datum.date,
                                ),
                              ],
                              primaryXAxis: const NumericAxis(
                                labelFormat: "June {value}",
                                interval: 1,
                                majorGridLines: MajorGridLines(
                                  width: 0,
                                ),
                              ),
                              primaryYAxis: const NumericAxis(
                                labelFormat: "{value}",
                                interval: 1,
                                minimum: 8,
                                desiredIntervals: 1,
                                enableAutoIntervalOnZooming: true,
                              ),
                            ),
                          ),
                          Container(
                            decoration: const BoxDecoration(
                              border: Border(
                                top: BorderSide(color: AppColors.lightGrey),
                              ),
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(
                                style.insets.lg,
                              ),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      children: [
                                        Text('On Time',
                                            style: style.text.h5.copyWith(
                                                color: AppColors.green)),
                                        Text(
                                          '14.5 Days',
                                          style: style.text.titleMd,
                                        ),
                                      ],
                                    ),
                                  ),
                                  ColoredBox(
                                    color: AppColors.lightGrey,
                                    child: SizedBox(
                                      height: 35 * style.scale,
                                      width: 1,
                                    ),
                                  ),
                                  Expanded(
                                    child: Column(
                                      children: [
                                        Text('Late',
                                            style: style.text.h5.copyWith(
                                                color: AppColors.red)),
                                        Text(
                                          '01 Days',
                                          style: style.text.titleMd,
                                        ),
                                      ],
                                    ),
                                  ),
                                  ColoredBox(
                                    color: AppColors.lightGrey,
                                    child: SizedBox(
                                      height: 35 * style.scale,
                                      width: 1,
                                    ),
                                  ),
                                  Expanded(
                                    child: Column(
                                      children: [
                                        Text('Exception',
                                            style: style.text.h5.copyWith(
                                                color:
                                                    AppColors.purpleGradient)),
                                        Text(
                                          '01 Days',
                                          style: style.text.titleMd,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Gap(30),
                    //circular chart
                    // CircularChat(attStatus: attStatus),
                    // RotatingWidget(animation: _animation),

                    //chart
                    Container(
                      decoration: BoxDecoration(
                          color: AppColors.white,
                          border: Border.all(
                              color: AppColors.lightGrey, width: 1.5),
                          borderRadius: BorderRadius.circular(style.radius.xl)),
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.all(style.insets.lg),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Working Hours & Timings',
                                  style: style.text.h3,
                                ),
                                IconButton(
                                    style: const ButtonStyle(
                                        padding: WidgetStatePropertyAll(
                                          EdgeInsets.zero,
                                        ),
                                        side: WidgetStatePropertyAll(BorderSide(
                                            color: AppColors.lightGrey)),
                                        shape: WidgetStatePropertyAll(
                                            CircleBorder(eccentricity: 0))),
                                    onPressed: () {},
                                    iconSize: style.icon.xs,
                                    icon: const Icon(
                                      Icons.file_download_outlined,
                                      color: AppColors.lightGrey,
                                    ))
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(style.insets.md),
                            child: ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: workingHrs.length,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: EdgeInsets.symmetric(
                                    vertical: style.insets.xs,
                                  ),
                                  child: Row(
                                    children: [
                                      ClipOval(
                                        child: CachedNetworkImage(
                                          cacheKey: workingHrs[index].profile,
                                          width: style.scale * 40,
                                          height: style.scale * 40,
                                          fit: BoxFit.cover,
                                          imageUrl:
                                              "${workingHrs[index].profile!}.png",
                                          placeholder: (context, url) =>
                                              Container(
                                            color: AppColors.lightGrey,
                                          ),
                                        ),
                                      ),
                                      Gap(style.insets.lg),
                                      Expanded(
                                        child: LayoutBuilder(
                                          builder: (context, constraints) {
                                            return Stack(
                                              alignment: Alignment.centerLeft,
                                              children: [
                                                SizedBox(
                                                  width: double.infinity,
                                                  height: 25 * style.scale,
                                                ),
                                                // indicators
                                                Positioned(
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                        color: (workingHrs[index]
                                                                            .workingTimeInMin! /
                                                                        480) *
                                                                    100 >
                                                                75
                                                            ? AppColors
                                                                .lightBlue
                                                            : (workingHrs[index].workingTimeInMin! /
                                                                            480) *
                                                                        100 >
                                                                    50
                                                                ? const Color(
                                                                    0xff87e4a1)
                                                                : AppColors
                                                                    .pink,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(style
                                                                    .radius
                                                                    .xs)),
                                                    width: (constraints
                                                                .maxWidth /
                                                            100) *
                                                        ((workingHrs[index]
                                                                    .workingTimeInMin! /
                                                                480) *
                                                            100),
                                                    height: 20 * style.scale,
                                                  ),
                                                ),
                                                // text alignments
                                                Positioned(
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: style
                                                                .insets.sm),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Text(
                                                          workingHrs[index]
                                                                  .clockInTime ??
                                                              '',
                                                          style: style
                                                              .text.title
                                                              .copyWith(
                                                                  color: AppColors
                                                                      .greyText),
                                                        ),
                                                        Text(
                                                          workingHrs[index]
                                                                  .clockOutTime ??
                                                              '',
                                                          style:
                                                              style.text.title,
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            );
                                          },
                                        ),
                                      ),
                                      Gap(style.insets.lg),
                                      Text(
                                        "${(workingHrs[index].workingTimeInMin! / 60).truncate()}h ${(workingHrs[index].workingTimeInMin! % 60).truncate()}m",
                                        style: style.text.h4,
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),
                          const Divider(
                            color: AppColors.lightGrey,
                          ),
                          Padding(
                            padding: EdgeInsets.all(style.insets.lg),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Avg per day hours',
                                    style: style.text.bodyContent),
                                Text(
                                  '8h 12m',
                                  style: style.text.h5,
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),

                    Container(
                      decoration: BoxDecoration(boxShadow: [
                        BoxShadow(
                          color: AppColors.lightGrey.withOpacity(0.4),
                          blurRadius: 10,
                          spreadRadius: 0,
                        ),
                      ]),
                      child: GridView(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisExtent: 200 * style.scale,
                        ),
                        children: [
                          Container(
                            margin: EdgeInsets.all(style.insets.md),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: AppColors.white,
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Align(
                                  heightFactor: 0.7,
                                  alignment: Alignment.centerRight,
                                  child: Container(
                                    margin: EdgeInsets.only(
                                      top: style.insets.xs,
                                      right: style.insets.xs,
                                    ),
                                    decoration: const BoxDecoration(
                                      color: AppColors.blue,
                                      shape: BoxShape.circle,
                                    ),
                                    padding: EdgeInsets.all(style.insets.md),
                                    child: Text(
                                      '2',
                                      style:
                                          style.text.bodyContentSmall.copyWith(
                                        color: AppColors.white,
                                      ),
                                    ),
                                  ),
                                ),
                                Text(
                                  'New Employee',
                                  style: style.text.bodyContentXSmall
                                      .copyWith(color: AppColors.grey),
                                ),
                                Padding(
                                  padding: EdgeInsets.fromLTRB(style.insets.lg,
                                      style.insets.xs, style.insets.lg, 0),
                                  child: Text(
                                    'AjithKumar joined your team welcome him',
                                    textAlign: TextAlign.center,
                                    style: style.text.titleMd.copyWith(
                                      color: AppColors.blue,
                                    ),
                                  ),
                                ),
                                Text(
                                  'Notification',
                                  style: style.text.bodyContent,
                                ),
                                Gap(style.insets.sm),
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.all(style.insets.md),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: AppColors.white,
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Align(
                                  heightFactor: 0.7,
                                  alignment: Alignment.centerRight,
                                  child: Container(
                                    margin: EdgeInsets.only(
                                      top: style.insets.xs,
                                      right: style.insets.xs,
                                    ),
                                    decoration: const BoxDecoration(
                                      color: AppColors.blue,
                                      shape: BoxShape.circle,
                                    ),
                                    padding: EdgeInsets.all(style.insets.md),
                                    child: Text(
                                      '2',
                                      style:
                                          style.text.bodyContentSmall.copyWith(
                                        color: AppColors.white,
                                      ),
                                    ),
                                  ),
                                ),
                                Text(
                                  'New Employee',
                                  style: style.text.bodyContentXSmall
                                      .copyWith(color: AppColors.grey),
                                ),
                                Padding(
                                  padding: EdgeInsets.fromLTRB(style.insets.lg,
                                      style.insets.xs, style.insets.lg, 0),
                                  child: Text(
                                    'Will be on Leave from 27th to 20th Aug ',
                                    maxLines: 3,
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.center,
                                    style: style.text.titleMd.copyWith(
                                      color: AppColors.blue,
                                    ),
                                  ),
                                ),
                                Text(
                                  'Request',
                                  style: style.text.bodyContent,
                                ),
                                Gap(style.insets.sm),
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.all(style.insets.md),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: AppColors.white,
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Expanded(
                                    child: Stack(
                                  children: [
                                    CircularChat(attStatus: leaveStatus),
                                    Positioned(
                                      child: Center(
                                        child: Text(
                                          '10/12',
                                          style: style.text.bodyContent
                                              .copyWith(color: AppColors.blue),
                                        ),
                                      ),
                                    ),
                                  ],
                                )),
                                Text(
                                  'Leaves',
                                  style: style.text.bodyContent,
                                ),
                                Gap(style.insets.sm),
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.all(style.insets.md),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: AppColors.white,
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Expanded(
                                    child: Stack(
                                  children: [
                                    CircularChat(attStatus: attStatus),
                                    Positioned(
                                      child: Center(
                                        child: RichText(
                                          text: TextSpan(
                                              style: style.text.bodyContent,
                                              children: const [
                                                TextSpan(
                                                  text: '20-',
                                                  style: TextStyle(
                                                    color: AppColors.blue,
                                                  ),
                                                ),
                                                TextSpan(
                                                  text: '5-',
                                                  style: TextStyle(
                                                    color: AppColors.red,
                                                  ),
                                                ),
                                                TextSpan(
                                                  text: '3',
                                                  style: TextStyle(
                                                    color: AppColors.orange,
                                                  ),
                                                ),
                                              ]),
                                        ),
                                      ),
                                    ),
                                  ],
                                )),
                                Text(
                                  'Attendance',
                                  style: style.text.bodyContent,
                                ),
                                Gap(style.insets.sm),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Gap(30)
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class RotatingWidget extends StatelessWidget {
  const RotatingWidget({
    super.key,
    required Animation<double> animation,
  }) : _animation = animation;

  final Animation<double> _animation;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AnimatedBuilder(
        animation: _animation,
        builder: (context, child) {
          double angle = _animation.value;
          double radius = 100.0;
          double x = radius * cos(angle);
          double y = radius * sin(angle);
          return Transform.translate(
            offset: Offset(x, y),
            child: child,
          );
        },
        child: Container(
          width: 50,
          height: 50,
          decoration: const BoxDecoration(
            color: Colors.blue,
            shape: BoxShape.circle,
          ),
        ),
      ),
    );
  }
}

class AttendanceCircleChatModel {
  final String name;
  final double value;
  final Color color;
  AttendanceCircleChatModel(this.name, this.value, this.color);
}

class AttendanceChartModel {
  final double? time;
  final double? date;
  AttendanceChartModel(
    this.time,
    this.date,
  );
}

class WorkingHrsModel {
  String? profile;
  double? workingTimeInMin;
  String? clockInTime;
  String? clockOutTime;
  WorkingHrsModel(
      {this.profile,
      this.workingTimeInMin,
      this.clockInTime,
      this.clockOutTime});
}
