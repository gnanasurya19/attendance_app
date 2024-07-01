import 'dart:async';
import 'package:attendance_app/controllers/home_controller.dart';
import 'package:attendance_app/res/common_lib.dart';
import 'package:intl/intl.dart';
import 'package:popover/popover.dart';
import 'widget/profile_popover.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    Provider.of<HomeController>(context, listen: false).getLocation(context);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        constraints: const BoxConstraints(minHeight: 700),
        height: MediaQuery.sizeOf(context).height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            const AppBarWidget(),
            Expanded(
              child: Builder(builder: (context) {
                if (MediaQuery.sizeOf(context).width <= 600) {
                  return const Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      TimeContainerWidget(),
                      ClockInfoWidget(),
                    ],
                  );
                } else {
                  return const Row(
                    children: [
                      TimeContainerWidget(),
                      ClockInfoWidget(),
                    ],
                  );
                }
              }),
            ),
            // const Gap(20),
          ],
        ),
      ),
    );
  }
}

class TimeContainerWidget extends StatelessWidget {
  const TimeContainerWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    HomeController homeController = Provider.of<HomeController>(context);
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const DisplayTimeWidget(),
        const MaxGap(50),

        //punch in button
        Stack(
          clipBehavior: Clip.antiAliasWithSaveLayer,
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              clipBehavior: Clip.antiAliasWithSaveLayer,
              width: MediaQuery.sizeOf(context).width * 0.15 +
                  MediaQuery.sizeOf(context).height * 0.15,
              height: MediaQuery.sizeOf(context).width * 0.15 +
                  MediaQuery.sizeOf(context).height * 0.15,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color:
                    homeController.isAttCompleted ? AppColors.lightBlue : null,
                boxShadow: (homeController.clockOut != null &&
                        homeController.clockIn != null)
                    ? null
                    : const [
                        BoxShadow(
                            color: Color(0xffeaf5ff),
                            blurRadius: 5,
                            spreadRadius: 10),
                        BoxShadow(
                          color: AppColors.shadowBlue,
                          blurRadius: 10,
                          spreadRadius: -5,
                          offset: Offset(-5, 15),
                        ),
                      ],
                gradient: homeController.isAttCompleted
                    ? null
                    : LinearGradient(
                        begin: Alignment.bottomLeft,
                        end: Alignment.topRight,
                        colors: homeController.clockIn == null
                            ? [const Color(0xffb776e8), const Color(0xff3E82E0)]
                            : [
                                const Color(0xffe83170),
                                const Color(0xff82198d),
                              ],
                      ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SvgIcon(
                    name: homeController.isWfh ? 'home' : 'touch',
                    size: style.icon.xl,
                    color: AppColors.white,
                  ),
                  const MaxGap(14),
                  Text(
                    homeController.currentLocation == null
                        ? "please wait..."
                        : homeController.isAttCompleted
                            ? "COMPLETED"
                            : (homeController.clockIn == null
                                ? "CLOCK IN"
                                : "CLOCK OUT"),
                    style: style.text.bodyContentLg
                        .copyWith(color: AppColors.white),
                  )
                ],
              ),
            ),
            Positioned.fill(
              child: Material(
                color: Colors.transparent,
                clipBehavior: Clip.antiAliasWithSaveLayer,
                shape: const CircleBorder(eccentricity: 0),
                child: InkWell(
                  splashColor: AppColors.white.withOpacity(0.3),
                  highlightColor: AppColors.white.withOpacity(0.3),
                  onTap: homeController.isAttCompleted ||
                          homeController.currentLocation == null
                      ? null
                      : () {
                          homeController.toggleClockIn(context);
                        },
                ),
              ),
            ),
          ],
        ),
        const Gap(20),
        Container(
          width: MediaQuery.sizeOf(context).width * 0.7,
          alignment: Alignment.center,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.location_pin,
                color: AppColors.blueGrey,
                size: style.icon.xxs,
              ),
              const Gap(10),
              Text(
                'Location: ${homeController.currentLocation ?? 'fetching...'}',
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: style.text.bodyContentSmall,
              ),
            ],
          ),
        )
      ],
    );
  }
}

class DisplayTimeWidget extends StatefulWidget {
  const DisplayTimeWidget({
    super.key,
  });

  @override
  State<DisplayTimeWidget> createState() => _DisplayTimeWidgetState();
}

class _DisplayTimeWidgetState extends State<DisplayTimeWidget> {
  DateTime datetime = DateTime.now();
  get time => DateFormat('hh:mm').format(datetime);
  get date => DateFormat('EEEE, MMM dd').format(datetime);
  late final Timer timer;
  bool isTimer = false;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 60 - DateTime.now().second), getTime)
        .then((value) {
      if (mounted) {
        timer = Timer.periodic(const Duration(seconds: 60), (timer) {
          getTime();
        });
        isTimer = true;
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  getTime() {
    if (mounted) {
      setState(() {
        datetime = DateTime.now();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('$time', style: style.text.h.copyWith(color: AppColors.blueGrey)),
        Text(
          date,
          style: style.text.bodyTitle.copyWith(
            color: AppColors.blueGrey,
          ),
        ),
      ],
    );
  }
}

class AppBarWidget extends StatelessWidget {
  const AppBarWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          width: double.infinity,
          height: kToolbarHeight,
          alignment: Alignment.center,
          child: Text(
            'THECOMPANY',
            style: style.text.bodyTitle,
          ),
        ),
        Positioned(
          right: style.insets.lg,
          child: Container(
            padding: EdgeInsets.all(style.insets.sm),
            decoration: const BoxDecoration(
              color: AppColors.white,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: AppColors.shadow,
                  offset: Offset(0, 3),
                  blurRadius: 3,
                )
              ],
            ),
            child: const ProfileButton(),
          ),
        )
      ],
    );
  }
}

class ProfileButton extends StatelessWidget {
  const ProfileButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        showPopover(
            arrowWidth: 0,
            context: context,
            bodyBuilder: (context) => const ProfilePopover());
      },
      child: const SvgIcon(
        name: 'leaf',
        color: AppColors.green,
        size: 20,
      ),
    );
  }
}

class ClockInfoWidget extends StatelessWidget {
  const ClockInfoWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    HomeController homeController = Provider.of<HomeController>(context);
    List<Widget> widgets = [
      Column(
        children: [
          SvgIcon(
            name: 'clock-in',
            size: style.icon.md,
          ),
          const SizedBox(height: 10),
          Text(
            homeController.clockInTime,
            style: style.text.h3.copyWith(letterSpacing: 1.2),
          ),
          Text(
            'Clock In',
            style: style.text.bodyContentSmall,
          ),
        ],
      ),
      Column(
        children: [
          SvgIcon(
            name: 'clock-out',
            size: style.icon.md,
          ),
          const SizedBox(height: 10),
          Text(
            homeController.clockOutTime,
            style: style.text.h3.copyWith(letterSpacing: 1.2),
          ),
          Text(
            'Clock Out',
            style: style.text.bodyContentSmall,
          ),
        ],
      ),
      Column(
        children: [
          SvgIcon(
            name: 'check-mark',
            size: style.icon.sm,
          ),
          const SizedBox(height: 10),
          Text(
            homeController.workingHrs,
            style: style.text.h3.copyWith(letterSpacing: 1.2),
          ),
          Text(
            "Working Hr's",
            style: style.text.bodyContentSmall,
          ),
        ],
      )
    ];
    return Builder(builder: (context) {
      if (MediaQuery.sizeOf(context).width <= 600) {
        return Row(
          children: widgets
              .map(
                (e) => Expanded(child: e),
              )
              .toList(),
        );
      } else {
        return Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: widgets,
        );
      }
    });
  }
}
